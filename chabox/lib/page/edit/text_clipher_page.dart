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
import 'package:chapose/chapose.dart' hide ME, MD;
import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

import 'package:app_lifecycle_protector/app_lifecycle_protector.dart' as alp;

import '../../core/constant.dart';
import '../../utils/caching.dart';
import '../../utils/clipborad_helper.dart';
import '../../utils/responsive.dart';
import '../view/text_plain_page.dart';
import 'text_variable_page.dart';

import '../../../../widget/enum_button_entity.dart';
import '../../../../message/definition.dart';

class TextClipherEditPage extends StatefulWidget {
  final File? chaFile; // Unique ID for the temp file

  const TextClipherEditPage({super.key, this.chaFile});

  @override
  State<TextClipherEditPage> createState() => _TextClipherEditPageState();
}

class _TextClipherEditPageState extends State<TextClipherEditPage> {
  final tempDir = GetIt.I<Directory>(instanceName: 'tempDir');
  final noteDir = sl<Caching>().noteDir;
  final secret = sl<Caching>().secret;
  final autosave = sl<Caching>().autosave.value;

  final _focusNode = FocusNode();
  final _controller = TextEditingController();

  final _autocc = sl<Caching>().autocc.value;
  int get _secs => ClipDelay.values.byName(_autocc).s;
  SecureClipboardManager get _clipboardManager => SecureClipboardManager(
    seconds: _secs,
    onCompleted: () =>
        sl<Logger>().finer('SecureClipboard, AutoClean, secs:$_secs'),
  );

  late final File _tempFile;
  late final File _noteFile;
  late String _tempName;

  String _lastSavedText = "";
  Timer? _debounce;
  bool _isLoading = false;
  bool _isChanged = false;

  @override
  void initState() {
    super.initState();

    alp.AppLifecycleScheduler.instance.aliveAtNow();

    _tempName = DateTime.now().millisecondsSinceEpoch.toString();
    if (widget.chaFile case File chaFile) {
      final chaPath = chaFile.path;
      if (chaPath.toLowerCase().endsWith(chaNoteExtName)) {
        _tempName = p.basenameWithoutExtension(
          p.basenameWithoutExtension(chaPath),
        );
      }
    }

    if (_tempName.toLowerCase().endsWith(chaFileExtName)) {
      _tempName = p.basenameWithoutExtension(_tempName);
    }

    _noteFile =
        widget.chaFile ??
        File(p.join(noteDir.path, '$_tempName$chaNoteExtName'));
    _tempFile = File(p.join(tempDir.path, '$_tempName$chaNoteExtName'));

    _initEditor();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) _clipboardManager.startAutoClear();
    });
  }

  // Load existing temp file for crash recovery
  void _initEditor() {
    if (_tempFile.existsSync() && _tempFile.lengthSync() > 0) {
      setState(() => _isLoading = true);
      _tempFile
          .readAsString()
          .then((content) {
            _controller.text = secret.dexthree(content, _tempName);
            _lastSavedText = _controller.text;
          })
          .catchError((error) {
            sl<Logger>().warning("Decryption failed: $error");
            if (!mounted) return;
            context.showSnackBar(
              ME.tr(
                MD.rsClipherActionDecryptionFailed,
                args: {'error': '$error'},
              ),
            );
          })
          .whenComplete(() => setState(() => _isLoading = false));
    } else {
      if (_noteFile.existsSync() && _noteFile.lengthSync() > 0) {
        setState(() => _isLoading = true);
        final memFile = MemoryFileSystem().file(_tempFile.path)
          ..createSync(recursive: true);
        fileDecrypt(deriveKey(sl<Caching>().password.value), _noteFile, memFile)
            .then((result) {
              _controller.text = memFile.readAsStringSync().trim();
              _lastSavedText = _controller.text;
              _isChanged = false;
            })
            .catchError((error) {
              sl<Logger>().warning("Decryption failed: $error");
              if (!mounted) return;
              context.showSnackBar(
                ME.tr(
                  MD.rsClipherActionDecryptionFailed,
                  args: {'error': '$error'},
                ),
              );
            })
            .whenComplete(() {
              memFile.deleteSync();
              setState(() => _isLoading = false);
            });
      }
    }
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    _clipboardManager.ignoreAutoClear();

    // if (_lastSavedText.isEmpty) return;
    if (_controller.text.trim().isEmpty) return;
    if (_controller.text.trim() == _lastSavedText) return;

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
        .writeAsString(
          secret.enxthree(_controller.text, _tempName),
          flush: true,
        )
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

      final memFile =
          MemoryFileSystem().file(
              p.join(
                tempDir.path,
                DateTime.now().millisecondsSinceEpoch.toString(),
              ),
            )
            ..createSync(recursive: true)
            ..writeAsStringSync(_controller.text);
      fileEncrypt(deriveKey(sl<Caching>().password.value), memFile, _noteFile)
          .then((result) {
            _isChanged = false;
            // _controller.text = memFile.readAsStringSync();
            if (!mounted) return;
            context.showSnackBar(ME.tr(MD.rsEditActionJournalSaved));
          })
          .catchError((error) {
            sl<Logger>().warning("Encryption failed: $error");
            if (!mounted) return;
            context.showSnackBar(
              ME.tr(
                MD.rsClipherActionEncryptionFailed,
                args: {'error': '$error'},
              ),
            );
          })
          .whenComplete(() {
            memFile.deleteSync();
            setState(() => _isLoading = false);
          });
    }
  }

  // Overwrites temp file with zeros before deletion for security
  void _secureEraseTemp() {
    if (_tempFile.existsSync()) {
      _tempFile.deleteSync();
      /*
      final cleanup = sl<Caching>().cleanup.value;
      final writeLevel = switch (cleanup) {
        'wipehigh' => FileWriteLevel.high,
        'wipemedium' => FileWriteLevel.medium,
        _ => FileWriteLevel.low,
      };
      // _lastSavedText = _controller.text;
      fileOverWrite(_tempFile, level: writeLevel, isFileExist: true);
      */
    }
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
    /*
    final tmpName = _tempName.endsWith(txtNoteExtName)
        ? _tempName
        : _tempName + txtNoteExtName;
    final tmpPath = p.join(tempDir.path, tmpName);
    */

    final memPath = p.withoutExtension(
      _isChanged ? _tempFile.path : _noteFile.path,
    );
    final memFile = MemoryFileSystem().file(memPath);
    memFile.createSync(recursive: true);
    memFile.writeAsStringSync(_controller.text, flush: true);

    context
        .push(TextPlainViewPage(memFile))
        .then((rtn) => memFile.deleteSync());
  }

  @override
  void dispose() {
    _clipboardManager.dispose();
    _focusNode.dispose();

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
          title: Text(_tempName),
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
              onPressed: _preview,
              icon: ButtonEntity.view.getIcon(),
              tooltip: ME.tr(
                MD.stCommonGlobalButtonActionLabel,
                args: {'action': ButtonEntity.view.toString()},
              ),
            ),
            IconButton(
              onPressed: _finalSave,
              icon: ButtonEntity.save.getIcon(),
              tooltip: ME.tr(
                MD.stCommonGlobalButtonActionLabel,
                args: {'action': ButtonEntity.save.toString()},
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              focusNode: _focusNode,
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
