/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'package:chabox/widget/enum_menu_action.dart';
import 'package:chabox/widget/enum_menu_entity.dart';
import 'package:chabox/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_selector/file_selector.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'dart:io';

import '../../../../message/definition.dart';
import '../../../../widget/enum_button_entity.dart';

class MultiPath extends StatefulWidget {
  final List<String> paths;
  final Function(List<String>) onPathsChanged;
  final bool allowPickFolder;

  const MultiPath({
    super.key,
    required this.paths,
    required this.onPathsChanged,
    this.allowPickFolder = true,
  });

  @override
  State<MultiPath> createState() => _MultiPathState();
}

class _MultiPathState extends State<MultiPath> {
  bool _isDragging = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _addPaths(List<String> newPaths) {
    final updatedPaths = List<String>.from(widget.paths);
    for (var path in newPaths) {
      if (!updatedPaths.contains(path)) {
        updatedPaths.add(path);
      }
    }
    widget.onPathsChanged(updatedPaths);
  }

  Future<void> _pickFiles() async {
    final List<XFile> files = await openFiles();
    if (files.isNotEmpty) {
      _addPaths(files.map((f) => f.path).toList());
    }
  }

  Future<void> _pickDirectory() async {
    final String? path = await getDirectoryPath();
    if (path != null) {
      _addPaths([path]);
    }
  }

  void _showManageDialog() {
    showDialog(
      context: context,
      builder: (context) => _PathManageDialog(
        initialPaths: widget.paths,
        onSave: (newPaths) {
          widget.onPathsChanged(newPaths);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragEntered: (_) => setState(() => _isDragging = true),
      onDragExited: (_) => setState(() => _isDragging = false),
      onDragDone: (details) {
        setState(() => _isDragging = false);
        if (details.files.isNotEmpty) {
          _addPaths(details.files.map((f) => f.path).toList());
        }
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: _isDragging ? Colors.blue : Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        constraints: const BoxConstraints(minHeight: 60, maxHeight: 160),
        child: Stack(
          children: [
            widget.paths.isEmpty
                ? Center(
                    child: Text(
                      ME.tr(
                        widget.allowPickFolder
                            ? MD.stMultiPathEmptyHint
                            : MD.stMultiFileOnlyEmptyHint,
                      ),
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  )
                : Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(
                        right: 80,
                        top: 4,
                        bottom: 4,
                      ),
                      itemCount: widget.paths.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 8,
                          ),
                          child: Text(
                            widget.paths[index],
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      },
                    ),
                  ),
            Positioned(
              top: 0,
              right: 0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_note, size: 20),
                    // tooltip: "Manage Paths",
                    tooltip: ME.tr(MD.stMultiPathManageTitle),
                    onPressed: _showManageDialog,
                    visualDensity: VisualDensity.compact,
                  ),
                  MenuAction<MenuEntity>(
                    menuType: MenuType.popupMenuButton,
                    buttonIcon: const Icon(Icons.add, size: 20),
                    tooltip: ME.tr(MD.stMultiPathAddTooltip),
                    menuItems: [
                      MenuEntity.pickfile,
                      if (widget.allowPickFolder) MenuEntity.pickfolder,
                    ],
                    localized: (key) => ME.tr(
                      MD.stCommonGlobalPopupActionLabel,
                      args: {'action': key},
                    ),
                    onSelectedAction: (entity, _) {
                      if (entity == MenuEntity.pickfile) _pickFiles();
                      if (entity == MenuEntity.pickfolder) _pickDirectory();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PathManageDialog extends StatefulWidget {
  final List<String> initialPaths;
  final Function(List<String>) onSave;

  const _PathManageDialog({required this.initialPaths, required this.onSave});

  @override
  State<_PathManageDialog> createState() => _PathManageDialogState();
}

class _PathManageDialogState extends State<_PathManageDialog> {
  late List<String> _paths;
  final _pasteController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _paths = List<String>.from(widget.initialPaths);
  }

  @override
  void dispose() {
    _pasteController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _parseAndAdd(String text) {
    // Regex to match potential Unix and Windows paths
    final pathRegex = RegExp(
      r'(/[a-zA-Z0-9._\-/ ]+)|([a-zA-Z]:\\[a-zA-Z0-9._\-\\ ]+)',
      multiLine: true,
    );

    final matches = pathRegex.allMatches(text);
    final newPaths = <String>[];

    for (final match in matches) {
      final potentialPath = match.group(0)?.trim();
      if (potentialPath == null || potentialPath.isEmpty) continue;

      if (FileSystemEntity.typeSync(potentialPath) !=
          FileSystemEntityType.notFound) {
        if (!_paths.contains(potentialPath) &&
            !newPaths.contains(potentialPath)) {
          newPaths.add(potentialPath);
        }
      }
    }

    if (newPaths.isEmpty) {
      final lines = text.split(RegExp(r'[\n\r,;]'));
      for (var line in lines) {
        final trimmed = line.trim();
        if (trimmed.isEmpty) continue;
        if (FileSystemEntity.typeSync(trimmed) !=
            FileSystemEntityType.notFound) {
          if (!_paths.contains(trimmed) && !newPaths.contains(trimmed)) {
            newPaths.add(trimmed);
          }
        }
      }
    }

    if (newPaths.isNotEmpty) {
      setState(() {
        _paths.addAll(newPaths);
      });
      _pasteController.clear();
    }
  }

  void _copyAll() {
    if (_paths.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _paths.join('\n')));
      context.showSnackBar(ME.tr(MD.rsCommonGlobalActionCopied));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(ME.tr(MD.stMultiPathManageTitle)),
      content: SizedBox(
        width: 600,
        height: 500,
        child: Column(
          children: [
            TextField(
              controller: _pasteController,
              maxLines: 5,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: ME.tr(MD.stMultiPathPasteHint),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () => _parseAndAdd(_pasteController.text),
                  icon: ButtonEntity.new_.getIcon(size: 20),
                  tooltip: ME.tr(MD.stMultiPathAddFromInputTooltip),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _paths.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _paths[index],
                        style: const TextStyle(fontSize: 12),
                      ),
                      trailing: IconButton(
                        icon: ButtonEntity.remove.getIcon(size: 20),
                        tooltip: ME.tr(MD.stMultiPathRemoveTooltip),
                        onPressed: () {
                          setState(() {
                            _paths.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              TextButton(
                onPressed: _copyAll,
                child: Tooltip(
                  message: ME.tr(
                    MD.stCommonGlobalButtonActionLabel,
                    args: {'action': ButtonEntity.copyall.toString()},
                  ),
                  child: Text(
                    ME.tr(
                      MD.stCommonGlobalButtonActionLabel,
                      args: {'action': ButtonEntity.copyall.toString()},
                    ),
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Tooltip(
                  message: ME.tr(
                    MD.stCommonGlobalButtonActionLabel,
                    args: {'action': ButtonEntity.cancel.toString()},
                  ),
                  child: Text(
                    ME.tr(
                      MD.stCommonGlobalButtonActionLabel,
                      args: {'action': ButtonEntity.cancel.toString()},
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  widget.onSave(_paths);
                  Navigator.pop(context);
                },
                child: Tooltip(
                  message: ME.tr(
                    MD.stCommonGlobalButtonActionLabel,
                    args: {'action': ButtonEntity.confirm.toString()},
                  ),
                  child: Text(
                    ME.tr(
                      MD.stCommonGlobalButtonActionLabel,
                      args: {'action': ButtonEntity.confirm.toString()},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
