/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'dart:async';
import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:mime/mime.dart' show MimeTypeResolver;
import 'package:path/path.dart' as p;
import 'package:share_plus/share_plus.dart';
import 'package:chapose/chapose.dart' show isChaFile;

import '../../core/constant.dart' show chaFileExtName;
import '../../message/definition.dart';
import '../../utils/file_helper.dart';
import '../../utils/responsive.dart';
import '../../widget/enum_button_entity.dart';
import 'file_filter_widget.dart';

/// A widget that lists files in a directory based on a glob pattern.
/// It automatically watches for changes in the directory.
class FileListView extends StatefulWidget {
  final Directory directory;
  final String? pattern;
  final Widget Function(BuildContext context, File file)? trailingMenuAction;

  const FileListView({
    super.key,
    required this.directory,
    this.pattern,
    this.trailingMenuAction,
  });

  @override
  State<FileListView> createState() => FileListViewState();
}

class FileListViewState extends State<FileListView> {
  final StreamController<List<File>> _fileStreamController = StreamController();
  StreamSubscription? _watcherSubscription;

  late final MimeTypeResolver _mimeTypeResolver = sl<MimeTypeResolver>();
  late Map<String, dynamic> _filterData;
  late Directory _currentDirectory;

  @override
  void initState() {
    super.initState();
    _currentDirectory = widget.directory;
    _filterData = {
      'directory': _currentDirectory.path,
      'pattern': widget.pattern ?? '**',
    };
    _initFileSystem();
  }

  @override
  void didUpdateWidget(FileListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.directory.path != widget.directory.path ||
        oldWidget.pattern != widget.pattern) {
      if (oldWidget.pattern != widget.pattern) {
        _filterData['pattern'] = widget.pattern ?? '**';
      }
      if (oldWidget.directory.path != widget.directory.path) {
        _currentDirectory = widget.directory;
        _filterData['directory'] = _currentDirectory.path;
      }
      _watcherSubscription?.cancel();
      _initFileSystem();
    }
  }

  void _initFileSystem() {
    refresh();
    try {
      _watcherSubscription = _currentDirectory
          .watch(recursive: true)
          .listen((_) => refresh());
    } catch (e) {
      debugPrint(
        "Warning: Directory watching not supported on this platform: $e",
      );
    }
  }

  /// Builds and returns the list of files matching the current filter criteria.
  List<File> _buildFileList() {
    if (!_currentDirectory.existsSync()) return [];

    final pattern = _filterData['pattern'] as String? ?? '**';
    final glob = Glob(pattern, recursive: true);
    // List files matching the glob pattern
    final List<File> files =
        glob.listSync(root: _currentDirectory.path).whereType<File>().where((
            file,
          ) {
            // Mimetype filter
            final mimePart = _filterData['mimetype'];
            if (mimePart != null && mimePart.isNotEmpty) {
              final mime = _mimeTypeResolver.lookup(file.path) ?? '';
              if (!mime.toLowerCase().contains(mimePart.toLowerCase())) {
                return false;
              }
            }

            // Optimization: Only call statSync if size or date filters are active
            final minSize = _filterData['minSize'] as int?;
            final maxSize = _filterData['maxSize'] as int?;
            final startDate = _filterData['startDate'] as DateTime?;
            final endDate = _filterData['endDate'] as DateTime?;

            if (minSize != null ||
                maxSize != null ||
                startDate != null ||
                endDate != null) {
              final stat = file.statSync();

              // Size filter
              if (minSize != null && stat.size < minSize) return false;
              if (maxSize != null && stat.size > maxSize) return false;

              // Date filter
              if (startDate != null && stat.modified.isBefore(startDate)) {
                return false;
              }
              if (endDate != null &&
                  stat.modified.isAfter(endDate.add(const Duration(days: 1)))) {
                return false;
              }
            }

            return true;
          }).toList()
          // Sort by modification date (newest first)
          ..sort(
            (a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()),
          );

    return files;
  }

  void refresh() {
    try {
      _fileStreamController.add(_buildFileList());
    } catch (e) {
      _fileStreamController.addError(e);
    }
  }

  /// Lets the user pick files via the system file picker and copies them into
  /// [_currentDirectory]. When [overwrite] is `true`, existing files are
  /// replaced; otherwise they are skipped.
  ///
  /// Returns a record with:
  /// - `saved`  – basenames of files that were successfully copied.
  /// - `skipped` – basenames of files that were skipped (already existed).
  Future<({List<String> saved, List<String> skipped})> pickfiles({
    required bool overwrite,
  }) async {
    final List<String> saved = [];
    final List<String> skipped = [];

    final List<XFile> picked = await openFiles();
    if (picked.isEmpty) return (saved: saved, skipped: skipped);

    final os = sl<String>(instanceName: 'os');
    final isAndroid = os == 'android';

    for (final xfile in picked) {
      final baseName = xfile.name;
      final sourceFile = File(xfile.path);
      final destName =
          (isAndroid &&
              baseName.toLowerCase().endsWith('.bin') &&
              isChaFile(sourceFile))
          ? '${baseName.substring(0, baseName.length - 4)}$chaFileExtName'
          : baseName;
      final destPath = p.join(_currentDirectory.path, destName);
      final destFile = File(destPath);

      if (destFile.existsSync() && !overwrite) {
        skipped.add(destName);
        continue;
      }

      sourceFile.copySync(destPath);
      unawaited(() async {
        try {
          final lastModified = await xfile.lastModified();
          destFile.setLastModifiedSync(lastModified);
        } catch (_) {
          // Ignore timestamp sync failures; copy already succeeded.
        }
      }());
      saved.add(destName);
    }

    return (saved: saved, skipped: skipped);
  }

  /// Shares all files that match the current filter criteria via [share_plus].
  void sharefiles() {
    final files = _buildFileList();
    if (files.isEmpty) return;

    final mimeType = 'application/octet-stream';
    final xfiles = files
        .map(
          (f) => XFile(
            f.path,
            name: p.basename(f.path),
            lastModified: f.lastModifiedSync(),
            mimeType: mimeType,
          ),
        )
        .toList();
    SharePlus.instance.share(ShareParams(files: xfiles)).then((value) {
      if (!mounted) return;
      context.showSnackBar(value.toString());
    });
  }

  Future<void> _showFilterDialog() async {
    final formKey = GlobalKey<FileFilterFormState>();
    final result = await context.showFormDialog<Map<String, dynamic>>(
      title: Text(ME.tr(MD.stCommonDialogTitle, args: {'action': 'filter'})),
      cancelText: ME.tr(
        MD.stCommonGlobalButtonActionLabel,
        args: {'action': ButtonEntity.cancel.toString()},
      ),
      confirmText: ME.tr(
        MD.stCommonGlobalButtonActionLabel,
        args: {'action': ButtonEntity.confirm.toString()},
      ),
      resetText: ME.tr(
        MD.stCommonGlobalButtonActionLabel,
        args: {'action': ButtonEntity.reset.toString()},
      ),

      child: FileFilterForm(key: formKey, initialData: _filterData),
      onConfirm: () => formKey.currentState?.submit(),
      onReset: () => formKey.currentState?.reset(),
    );

    if (result != null) {
      setState(() {
        final oldDirPath = _currentDirectory.path;
        _filterData = result;
        final newDirPath = _filterData['directory'] as String;

        if (oldDirPath != newDirPath) {
          _currentDirectory = Directory(newDirPath);
          _watcherSubscription?.cancel();
          _initFileSystem();
        } else {
          refresh();
        }
      });
    }
  }

  String _getFilterSummary() {
    List<String> parts = [];
    if (_filterData['pattern'] != null && _filterData['pattern'] != '**') {
      parts.add("Pattern: ${_filterData['pattern']}");
    }
    if (_filterData['mimetype'] != null && _filterData['mimetype'].isNotEmpty) {
      parts.add("Mime: ${_filterData['mimetype']}");
    }
    if (_filterData['minSize'] != null || _filterData['maxSize'] != null) {
      parts.add(
        "Size: ${_filterData['minSize'] ?? 0} - ${_filterData['maxSize'] ?? '∞'}",
      );
    }
    if (_filterData['startDate'] != null || _filterData['endDate'] != null) {
      final start = _filterData['startDate']?.toString().split(' ')[0] ?? '...';
      final end = _filterData['endDate']?.toString().split(' ')[0] ?? '...';
      parts.add("Date: $start - $end");
    }
    return parts.isEmpty ? "All files (**)" : parts.join(", ");
  }

  @override
  void dispose() {
    _watcherSubscription?.cancel();
    _fileStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFilterBar(),
        const Divider(height: 1),
        Expanded(
          child: StreamBuilder<List<File>>(
            stream: _fileStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final files = snapshot.data!;

              if (files.isEmpty) {
                return const Center(
                  child: Text(
                    "No files found",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: files.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final file = files[index];
                  final fileName = p.basename(file.path);
                  final relDir = p.relative(
                    file.parent.path,
                    from: _currentDirectory.path,
                  );
                  final pathSuffix = relDir == '.' ? '' : '  ./$relDir';

                  return ListTile(
                    leading: _getLeadingIcon(fileName),
                    title: Text(
                      fileName,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      "${file.lastModifiedSync().toString().split('.')[0]}$pathSuffix",
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: widget.trailingMenuAction?.call(context, file),
                    onTap: () {
                      // By default, if there's no specific tap behavior provided,
                      // we might want to do nothing or have a default action.
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _getLeadingIcon(String fileName) {
    final String nameToLookup = fileName.toLowerCase().endsWith(chaFileExtName)
        ? fileName.substring(0, fileName.length - chaFileExtName.length)
        : fileName;

    final mimeType = _mimeTypeResolver.lookup(nameToLookup) ?? '';
    final specCate = getFileSpecCate(nameToLookup, mimeType);

    IconData iconData;
    Color iconColor = Colors.blueGrey;

    if (specCate != FileSpecCate.none) {
      switch (specCate) {
        case FileSpecCate.archive:
          iconData = Icons.folder_zip_outlined;
          iconColor = Colors.amber;
          break;
        case FileSpecCate.pdf:
          iconData = Icons.picture_as_pdf_outlined;
          iconColor = Colors.redAccent;
          break;
        case FileSpecCate.security:
          iconData = Icons.verified_user_outlined;
          iconColor = Colors.indigoAccent;
          break;
        case FileSpecCate.spreadsheet:
          iconData = Icons.table_chart_outlined;
          iconColor = Colors.teal;
          break;
        case FileSpecCate.presentation:
          iconData = Icons.slideshow_outlined;
          iconColor = Colors.orangeAccent;
          break;
        case FileSpecCate.document:
          iconData = Icons.article_outlined;
          iconColor = Colors.blueAccent;
          break;
        case FileSpecCate.code:
          iconData = Icons.code_outlined;
          iconColor = Colors.cyan;
          break;
        case FileSpecCate.ebook:
          iconData = Icons.menu_book_outlined;
          iconColor = Colors.brown;
          break;
        default:
          iconData = Icons.description_outlined;
      }
    } else {
      final typePart = mimeType.split('/').first;

      switch (typePart) {
        case 'text':
          iconData = Icons.text_snippet_outlined;
          break;
        case 'image':
          iconData = Icons.image_outlined;
          iconColor = Colors.lightBlue;
          break;
        case 'audio':
          iconData = Icons.audio_file_outlined;
          iconColor = Colors.purpleAccent;
          break;
        case 'video':
          iconData = Icons.video_file_outlined;
          iconColor = Colors.pinkAccent;
          break;
        case 'application':
          iconData = Icons.widgets_outlined;
          break;
        case 'font':
          iconData = Icons.font_download_outlined;
          break;
        case 'model':
          iconData = Icons.view_in_ar_outlined;
          iconColor = Colors.indigo;
          break;
        default:
          iconData = Icons.description_outlined;
      }
    }

    return Icon(iconData, color: iconColor);
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(
        context,
      ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.folder_open, size: 14, color: Colors.blueGrey),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  abbreviatePath(
                    _currentDirectory.path,
                    keepFirstSegments: 1,
                    keepLastSegments: 2,
                  ),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Tooltip(
                message: ME.tr(
                  MD.stCommonDialogTitle,
                  args: {'action': 'filter'},
                ),
                child: TextButton.icon(
                  onPressed: _showFilterDialog,
                  icon: const Icon(Icons.edit, size: 14),
                  label: const Text("Filter", style: TextStyle(fontSize: 12)),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.filter_alt_outlined,
                size: 14,
                color: Colors.blueGrey,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _getFilterSummary(),
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.blueGrey,
                    fontStyle: FontStyle.italic,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
