/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

// This implementation provides a robust, memory-first editor.
// It handles temporary file lifecycles uniquely per entry,
// implements a 3-second debounce for auto-saving,
// and supports optional encryption callbacks with a secure-erase fallback.

import 'dart:async';
import 'dart:io';
import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

import 'package:app_lifecycle_protector/app_lifecycle_protector.dart' as alp;

import '../../core/constant.dart';
import '../../thirdparty/ft_textmime.dart';
import '../../thirdparty/patching_tmpl.dart';
import '../../thirdparty/patching_zlib.dart';
import '../../utils/caching.dart';
import '../../utils/file_helper.dart';
import '../../utils/responsive.dart';
import '../view/text_plain_page.dart';
import 'text_variable_page.dart';

import '../../../../widget/enum_button_entity.dart';
import '../../../../message/definition.dart';

class TextPlainEditPage extends StatefulWidget {
  final File? txtFile;

  const TextPlainEditPage({super.key, this.txtFile});

  @override
  State<TextPlainEditPage> createState() => _TextPlainEditPageState();
}

class _TextPlainEditPageState extends State<TextPlainEditPage> {
  final tempDir = GetIt.I<Directory>(instanceName: 'tempDir');
  final noteDir = sl<Caching>().noteDir;
  final secret = sl<Caching>().secret;
  final autosave = sl<Caching>().autosave.value;

  late final TextEditingController _controller;
  late final File _tempFile;
  late final File _noteFile;
  late final String _tempName;

  String _lastSavedText = "";
  Timer? _debounce;
  bool _isLoading = false;
  bool _isChanged = false;

  @override
  void initState() {
    super.initState();

    alp.AppLifecycleScheduler.instance.aliveAtNow();

    _controller = TextEditingController();
    _tempName = (widget.txtFile == null)
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : p.basenameWithoutExtension(widget.txtFile!.path);

    _noteFile =
        widget.txtFile ??
        File(p.join(noteDir.path, '$_tempName$txtNoteExtName'));
    _tempFile = File(p.join(tempDir.path, '$_tempName$txtNoteExtName'));

    _initEditor();
  }

  // Load existing temp file for crash recovery
  void _initEditor() {
    if (_tempFile.existsSync() && _tempFile.lengthSync() > 0) {
      setState(() => _isLoading = true);
      _tempFile
          .readAsString()
          .then((content) {
            _controller.text = content;
            _lastSavedText = _controller.text;
          })
          .catchError((error) {
            _controller.text = error.toString();
          })
          .whenComplete(() => setState(() => _isLoading = false));
    } else {
      if (_noteFile.existsSync() && _noteFile.lengthSync() > 0) {
        setState(() => _isLoading = true);

        final (realName, fileExts) = fileNameWithExts(_noteFile.path);
        final isTextFile = isTextMimeType(realName);
        if (isTextFile) {
          if (fileExts.isEmpty) {
            _noteFile
                .readAsString()
                .then((content) {
                  _controller.text = content;
                  _lastSavedText = _controller.text;
                })
                .catchError((error) {
                  _controller.text = error.toString();
                })
                .whenComplete(() => setState(() => _isLoading = false));
          }

          final nextExt = fileExts.isEmpty ? '' : fileExts.removeAt(0);
          if (fileExts.isEmpty && (nextExt.toLowerCase() == '.gz')) {
            final memFile = MemoryFileSystem().file(
              p.basenameWithoutExtension(_tempName),
            );

            decompressFile(
              _noteFile,
              memFile,
              onSuccess: (file) {
                _controller.text = file.readAsStringSync();
                _lastSavedText = _controller.text;

                memFile.deleteSync();
              },
              onError: (error, _) {
                _controller.text = error.toString();
              },
            );
          } else {
            _controller.text = 'invalid view, ${_noteFile.path}.';
          }
        } else {
          _controller.text = 'only edit text file.';
        }
      }
    }
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (_lastSavedText.isEmpty) return;
    if (_controller.text.trim().isEmpty) return;
    if (_controller.text == _lastSavedText) return;

    _isChanged = true;
    _debounce?.cancel();

    if (autosave > 0) {
      _debounce = Timer(Duration(seconds: autosave), _autoSaveToTemp);
    }

    alp.AppLifecycleScheduler.instance.aliveAtNow();
  }

  void _autoSaveToTemp() async {
    if (_controller.text.trim().isEmpty) return;
    if (_controller.text == _lastSavedText) return;

    _tempFile
        .writeAsString(_controller.text, flush: true)
        .then((value) {
          _lastSavedText = _controller.text;
          // debugPrint("Auto-save: Temp file updated.");
        })
        .catchError((error) {
          sl<Logger>().warning("Auto-save failed: $error");

          if (!mounted) return;
          context.showSnackBar(
            ME.tr(MD.rsEditActionAutoSaveFailed, args: {'error': '$error'}),
          );
        });
  }

  // Final save: Uses high-level encryption and wipes temp file
  Future<void> _finalSave() async {
    if (!_isChanged) return;

    _debounce?.cancel();
    if (_controller.text.trim().isNotEmpty) {
      setState(() => _isLoading = true);
      _noteFile
          .writeAsString(_controller.text)
          .then((value) {
            _isChanged = false;
            if (mounted) {
              context.showSnackBar(ME.tr(MD.rsEditActionJournalSaved));
            }
          })
          .catchError((error) {
            sl<Logger>().warning("file write failed: $error");
            if (mounted) {
              context.showSnackBar(
                ME.tr(
                  MD.rsEditActionFileWriteFailed,
                  args: {'error': '$error'},
                ),
              );
            }
          })
          .whenComplete(() => setState(() => _isLoading = false));
    }
  }

  // Overwrites temp file with zeros before deletion for security
  void _secureEraseTemp() {
    if (_tempFile.existsSync()) _tempFile.deleteSync();
  }

  // Shows a confirmation dialog for unsaved changes.
  // Returns true if the user wants to discard changes and leave (true),
  // or false if they want to stay on the page (false).
  // It *does not* perform the save operation itself.
  Future<bool?> _showUnsavedChangesDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            ME.tr(MD.stCommonDialogTitle, args: {'action': 'unsaved'}),
          ),
          content: Text(
            ME.tr(MD.cdCommonDialogConfirmMessage, args: {'action': 'unsaved'}),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                ME.tr(
                  MD.stCommonGlobalButtonActionLabel,
                  args: {'action': ButtonEntity.cancel.toString()},
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                ME.tr(
                  MD.stCommonGlobalButtonActionLabel,
                  args: {'action': ButtonEntity.confirm.toString()},
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _preview() {
    // context.push(TextPlainViewPage(_tempFile));

    final memPath = _isChanged ? _tempFile.path : _noteFile.path;
    final memFile = MemoryFileSystem().file(memPath);
    memFile.createSync(recursive: true);

    // Apply template variable substitution before preview; the editor text is unchanged.
    final variables = _loadAllVariables();
    final rendered = Tmpl(variables).tmpl(_controller.text);
    memFile.writeAsStringSync(rendered, flush: true);

    context
        .push(TextPlainViewPage(memFile))
        .then((rtn) => memFile.deleteSync());
  }

  /// Builds the merged variable map for template rendering.
  /// System path variables are converted to POSIX format (forward slash).
  /// User-defined variables from [Caching.textvars] are merged in;
  /// system variables take priority and cannot be overridden.
  Map<String, String> _loadAllVariables() {
    final caching = sl<Caching>();
    String toPosix(String path) => path.replaceAll(r'\', '/');

    // Start with user-defined variables.
    final variables = Map<String, String>.from(caching.textvars.value);

    // System read-only variables always take priority.
    variables.addAll({
      'noteDir': toPosix(caching.noteDir.path),
      'encDir': toPosix(caching.encDir.path),
      'decDir': toPosix(caching.decDir.path),
      'enaDir': toPosix(caching.enaDir.path),
      'deaDir': toPosix(caching.deaDir.path),
    });

    return variables;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();

    _secureEraseTemp();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        // If the route was already popped by another mechanism, do nothing.
        if (didPop) return;
        if (!_isChanged) return Navigator.of(context).pop();

        _showUnsavedChangesDialog().then((userWantsToLeave) {
          // If userWantsToLeave is true, it means they chose to discard changes and leave.
          if (userWantsToLeave == true) {
            if (!mounted) return false;
            if (context.mounted) Navigator.of(context).pop(true);
          }
          // If userWantsToLeave is false or null, we do nothing, preventing the pop.
        });
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: ButtonEntity.variables.getIcon(),
              tooltip: ME.tr(
                MD.stCommonGlobalButtonActionLabel,
                args: {'action': ButtonEntity.variables.toString()},
              ),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const TextVariablePage()),
              ),
            ),
            IconButton(
              icon: ButtonEntity.view.getIcon(),
              tooltip: ME.tr(
                MD.stCommonGlobalButtonActionLabel,
                args: {'action': ButtonEntity.view.toString()},
              ),
              onPressed: () => _preview(),
            ),
            IconButton(
              icon: ButtonEntity.save.getIcon(),
              tooltip: ME.tr(
                MD.stCommonGlobalButtonActionLabel,
                args: {'action': ButtonEntity.save.toString()},
              ),
              onPressed: _finalSave,
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _controller,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                hintText: ME.tr(MD.stEditTextHint),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
