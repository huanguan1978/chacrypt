/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';

import '../../home/helper/vault_stats_service.dart';
import '../../../message/definition.dart';
import '../../../utils/crypt_helper.dart' show CommandException, decryptCommand;
import '../../../utils/logger_stream_controller.dart';
import '../../../utils/caching.dart';
import '../../../utils/responsive.dart';
import '../../../utils/file_helper.dart';
import '../widget/shared/action_layout.dart';
import '../../../widget/logger_stream_view.dart';
import '../../../widget/enum_menu_entity.dart';
import '../widget/shared/multi_path.dart';
import '../widget/crypt.dart';

class Decrypt extends StatefulWidget with WatchItStatefulWidgetMixin {
  const Decrypt({super.key});

  @override
  State<Decrypt> createState() => _DecryptState();
}

class _DecryptState extends State<Decrypt> {
  final List<String> _paths = [];
  final _logStreamController = sl<LogStreamController>();
  bool _isProcessing = false;

  late String _selectedOutDir;
  late bool _selectedOverwrite;
  late String _selectedPassword;

  late final ListenableSubscription _decryptCommandResultsListen;

  void _errorCallback(Object? e) {
    if (e is CommandException) {
      final message =
          'Error: ${e.message}\n failures:\n ${e.failures}\n success:\n ${e.success}';
      _logStreamController.add(ML.SEVERE, message);
    } else {
      _logStreamController.add(ML.SEVERE, e.toString());
    }
    setState(() => _isProcessing = false);
  }

  void _dataCallback(List<(String, String)> datas) {
    if (datas.isNotEmpty) {
      _logStreamController.add(ML.INFO, 'Decrypted: $datas');
    }
    setState(() {
      _isProcessing = false;
    });
  }

  @override
  void initState() {
    super.initState();
    final caching = sl<Caching>();
    _selectedOutDir = caching.decpath.value;
    _selectedOverwrite = caching.overwrited.value;
    _selectedPassword = caching.password.value;

    _decryptCommandResultsListen = decryptCommand.results.listen((rst, _) {
      if (rst.isRunning) {
        setState(() => _isProcessing = true);
      }

      final isConfigDir = isWithinPath(caching.decpath.value, _selectedOutDir);

      if (rst.hasError) {
        _errorCallback(rst.error);
        if (isConfigDir) sl<VaultStatsService>().refresh();
      }

      if (rst.isSuccess && rst.hasData) {
        _dataCallback(rst.data ?? []);
        if (isConfigDir) sl<VaultStatsService>().refresh();
      }
    });

    // Security Notice: Move UI warning to logs to save space
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _logStreamController.clear();
      _logStreamController.add(
        ML.INFO,
        ME.tr(MD.stCommonGlobalInfoIndependent),
      );
      _logStreamController.add(ML.INFO, ME.tr(MD.stDecryptGlobalInfoAtomic));
      _logStreamController.add(ML.INFO, ME.tr(MD.stCommonGlobalInfoNoGlobal));
    });
  }

  @override
  void dispose() {
    _decryptCommandResultsListen.cancel();
    super.dispose();
  }

  void _decrypt() {
    if (_paths.isEmpty) {
      _logStreamController.add(ML.WARNING, 'No files selected for decryption.');
      return;
    }

    if (_selectedOutDir.isEmpty) {
      _logStreamController.add(
        ML.WARNING,
        'Output directory is not specified.',
      );
      return;
    }

    if (_selectedPassword.isEmpty) {
      _logStreamController.add(ML.WARNING, 'Password is not specified.');
      return;
    }

    _logStreamController.clear();
    _logStreamController.add(
      ML.INFO,
      'Starting atomic decryption of ${_paths.length} items to $_selectedOutDir',
    );

    decryptCommand.run((
      Directory(_selectedOutDir),
      _paths,
      _selectedOverwrite,
      _selectedPassword,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = sl<bool>(instanceName: 'isDesktop');

    return Scaffold(
      appBar: AppBar(
        /*
        title: Text(
          ME.tr(
            MD.stCommonGlobalNavActionLabel,
            args: {'action': MenuEntity.encrypt.toString()},
          ),
        ),
        */
      ),
      body: ActionLayout(
        inputWidget: MultiPath(
          allowPickFolder: false,
          paths: _paths,
          onPathsChanged: (newPaths) {
            setState(() {
              _paths.clear();
              _paths.addAll(newPaths);
            });
          },
        ),
        actionWidget: CryptActionWidget(
          isDesktop: isDesktop,
          type: CryptActionType.decrypt,
          isProcessing: _isProcessing,
          initialOutDir: _selectedOutDir,
          initialOverwrite: _selectedOverwrite,
          initialPassword: _selectedPassword,
          onExecute: _decrypt,
          onSettingsChanged: (outDir, overwrite, password) {
            _selectedOutDir = outDir;
            _selectedOverwrite = overwrite;
            _selectedPassword = password;
          },
        ),
        logWidget: LogStreamView<MenuEntity>(
          logStream: _logStreamController.stream,
          menuItems: const [MenuEntity.copy, MenuEntity.clear],
          onMenuSelected: (value, currentText) {
            switch (value) {
              case MenuEntity.copy:
                Clipboard.setData(
                  ClipboardData(text: _logStreamController.allText),
                );
                context.showSnackBar(ME.tr(MD.rsCommonGlobalActionCopied));
              case MenuEntity.clear:
                _logStreamController.clear();
                setState(() {});
              default:
            }
          },
        ),
      ),
    );
  }
}
