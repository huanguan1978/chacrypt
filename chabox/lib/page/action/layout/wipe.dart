/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';

import '../../../../core/constant.dart' show CleanupEnum;
import '../../../../message/definition.dart';
import '../../../../utils/crypt_helper.dart'
    show CommandException, cleanupCommand;
import '../../../../utils/logger_stream_controller.dart';
import '../../../../utils/responsive.dart';
import '../../../../widget/logger_stream_view.dart';
import '../../../../widget/enum_menu_entity.dart';
import '../widget/shared/action_layout.dart';
import '../widget/shared/multi_path.dart';
import '../widget/wipe.dart' as widget;

class Wipe extends StatefulWidget with WatchItStatefulWidgetMixin {
  const Wipe({super.key});

  @override
  State<Wipe> createState() => _WipeState();
}

class _WipeState extends State<Wipe> {
  final List<String> _paths = [];
  final _logStreamController = sl<LogStreamController>();
  bool _isProcessing = false;

  CleanupEnum _selectedLevel = CleanupEnum.wipemedium;
  int _selectedIterations = 1;

  late final ListenableSubscription _cleanupCommandResultsListen;

  void _errorCallback(Object? e) {
    if (e is CommandException) {
      final message =
          'Error:${e.message}\n failures:\n ${e.failures}\n success:\n ${e.success}';
      _logStreamController.add(ML.SEVERE, message);
    } else {
      _logStreamController.add(ML.SEVERE, e.toString());
    }
    setState(() => _isProcessing = false);
  }

  void _dataCallback(List<(String, String)> datas) {
    if (datas.isNotEmpty) {
      _logStreamController.add(ML.INFO, 'Cleaned up: $datas');
    }
    setState(() {
      _isProcessing = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _cleanupCommandResultsListen = cleanupCommand.results.listen((rst, _) {
      if (rst.isRunning) {
        setState(() => _isProcessing = true);
      }

      if (rst.hasError) {
        _errorCallback(rst.error);
      }

      if (rst.isSuccess && rst.hasData) {
        _dataCallback(rst.data ?? []);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _logStreamController.clear();
      _logStreamController.add(
        ML.INFO,
        ME.tr(MD.stCommonGlobalInfoIndependent),
      );
      _logStreamController.add(ML.INFO, ME.tr(MD.stCommonGlobalInfoNoGlobal));
    });
  }

  @override
  void dispose() {
    _cleanupCommandResultsListen.cancel();
    super.dispose();
  }

  void _secureErase() {
    if (_paths.isEmpty) {
      _logStreamController.add(
        ML.WARNING,
        'No files or folders selected for wiping.',
      );
      return;
    }

    _logStreamController.clear();
    _logStreamController.add(
      ML.INFO,
      'Starting secure erase of ${_paths.length} items using strategy: ${_selectedLevel.name}, iterations: $_selectedIterations',
    );

    cleanupCommand.run((_selectedLevel, _paths, _selectedIterations));
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = sl<bool>(instanceName: 'isDesktop');
    final os = sl<String>(instanceName: 'os');
    bool allowPickFolder = false;
    if (isDesktop || (os == 'android')) {
      allowPickFolder = true;
    }

    return Scaffold(
      appBar: AppBar(
        /*
        title: Text(
          ME.tr(
            MD.stCommonGlobalNavActionLabel,
            args: {'action': MenuEntity.shredding.toString()},
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
        actionWidget: widget.Wipe(
          isProcessing: _isProcessing,
          onWipe: _secureErase,
          initialLevel: _selectedLevel,
          initialIterations: _selectedIterations,
          onSettingsChanged: (level, iterations) {
            setState(() {
              _selectedLevel = level;
              _selectedIterations = iterations;
            });
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
