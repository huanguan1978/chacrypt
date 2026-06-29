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
import '../../../utils/crypt_helper.dart' show CommandException, archiveCommand;
import '../../../utils/logger_stream_controller.dart';
import '../../../utils/caching.dart';
import '../../../utils/responsive.dart';
import '../../../utils/file_helper.dart';
import '../widget/shared/action_layout.dart';
import '../../../widget/logger_stream_view.dart';
import '../../../widget/enum_menu_entity.dart';
import '../widget/archive.dart' as widget;
import '../widget/shared/multi_path.dart';

class Archive extends StatefulWidget with WatchItStatefulWidgetMixin {
  const Archive({super.key});

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  final List<String> _paths = [];
  final _logStreamController = sl<LogStreamController>();
  bool _isProcessing = false;

  late String _selectedOutDir;
  late bool _selectedOverwrite;

  late final ListenableSubscription _archiveCommandResultsListen;

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
      _logStreamController.add(ML.INFO, 'Archived: $datas');
    }
    setState(() {
      _isProcessing = false;
    });
  }

  @override
  void initState() {
    super.initState();
    final caching = sl<Caching>();
    _selectedOutDir = caching.enapath.value;
    _selectedOverwrite = caching.overwrited.value;

    _archiveCommandResultsListen = archiveCommand.results.listen((rst, _) {
      if (rst.isRunning) {
        setState(() => _isProcessing = true);
      }

      final isConfigDir = isWithinPath(caching.enapath.value, _selectedOutDir);

      if (rst.hasError) {
        _errorCallback(rst.error);
        if (isConfigDir) sl<VaultStatsService>().refresh();
      }

      if (rst.isSuccess && rst.hasData) {
        _dataCallback(rst.data ?? []);
        if (isConfigDir) sl<VaultStatsService>().refresh();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _logStreamController.clear();
      _logStreamController.add(
        ML.INFO,
        ME.tr(MD.stArchiveGlobalInfoIndependent),
      );
      _logStreamController.add(
        ML.INFO,
        ME.tr(MD.stArchiveGlobalInfoCompression),
      );
      _logStreamController.add(ML.INFO, ME.tr(MD.stCommonGlobalInfoNoGlobal));
    });
  }

  @override
  void dispose() {
    _archiveCommandResultsListen.cancel();
    super.dispose();
  }

  void _archive() {
    if (_paths.isEmpty) {
      _logStreamController.add(
        ML.WARNING,
        'No files or folders selected for archiving.',
      );
      return;
    }

    if (_selectedOutDir.isEmpty) {
      _logStreamController.add(
        ML.WARNING,
        'Output directory is not specified.',
      );
      return;
    }

    _logStreamController.clear();
    _logStreamController.add(
      ML.INFO,
      'Starting archive of ${_paths.length} items to $_selectedOutDir',
    );

    archiveCommand.run((
      Directory(_selectedOutDir),
      _paths,
      _selectedOverwrite,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = sl<bool>(instanceName: 'isDesktop');
    final os = sl<String>(instanceName: 'os');
    bool allowPickFolder = false;
    if (isDesktop || (os == 'android')) {
      allowPickFolder = true;
    }

    // Watch global defaults, but use local state for current operation
    watchValue((Caching c) => c.enapath);
    watchValue((Caching c) => c.overwrited);

    return Scaffold(
      appBar: AppBar(
        /*
        title: Text(
          ME.tr(
            MD.stCommonGlobalNavActionLabel,
            args: {'action': MenuEntity.archive.toString()},
          ),
        ),
        */
      ),
      body: ActionLayout(
        inputWidget: MultiPath(
          allowPickFolder: allowPickFolder,
          paths: _paths,
          onPathsChanged: (newPaths) {
            setState(() {
              _paths.clear();
              _paths.addAll(newPaths);
            });
          },
        ),
        actionWidget: widget.Archive(
          isDesktop: isDesktop,
          isProcessing: _isProcessing,
          initialOutDir: _selectedOutDir,
          initialOverwrite: _selectedOverwrite,
          onArchive: _archive,
          onSettingsChanged: (outDir, overwrite) {
            _selectedOutDir = outDir;
            _selectedOverwrite = overwrite;
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
