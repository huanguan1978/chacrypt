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
import 'package:chapose/chapose.dart' hide MD, ME, ML;

import '../../../core/constant.dart' show CleanupEnum;
import '../../home/helper/security_briefing.dart';
import '../../../message/definition.dart';
import '../../../utils/caching.dart';
import '../../../utils/crypt_helper.dart'
    show
        CommandException,
        archiveCommand,
        cleanupCommand,
        encryptCommand,
        unarchiveCommand,
        decryptCommand;
import '../../../utils/logger_stream_controller.dart';
import '../../../utils/responsive.dart';
import '../widget/shared/action_layout.dart';
import '../../home/widget/briefing/briefing_view.dart';
import '../../../widget/enum_menu_entity.dart';
import '../../../widget/logger_stream_view.dart';
import '../widget/shared/action_button.dart';
import '../widget/shared/single_path.dart';

// Import local to re-use state
enum AutoCryptState {
  waiting(enabled: false, text: 'Waiting for Source...'),
  encrypt(enabled: true, text: 'Encrypt Selected Item'),
  decrypt(enabled: true, text: 'Decrypt Selected Item'),
  processing(enabled: false, text: 'Processing...');

  final String text;
  final bool enabled;
  const AutoCryptState({required this.text, required this.enabled});
}

class AutocryptPage extends StatefulWidget {
  final String? sourcePath;
  const AutocryptPage({super.key, this.sourcePath});

  @override
  State<AutocryptPage> createState() => _AutocryptPageState();
}

class _AutocryptPageState extends State<AutocryptPage> {
  final _sourceController = TextEditingController();
  final _cryptActionState = ValueNotifier(AutoCryptState.waiting);
  final _showLogview = ValueNotifier(false);
  final _logStreamController = sl<LogStreamController>();

  AutoCryptState get _currentCryptActionState {
    final path = _sourceController.text;
    if (path.isEmpty) return AutoCryptState.waiting;
    return path.toLowerCase().endsWith(ChaContant.extName)
        ? AutoCryptState.decrypt
        : AutoCryptState.encrypt;
  }

  late final ListenableSubscription _archiveCommandResultsListen;
  late final ListenableSubscription _unarchiveCommandResultsListen;
  late final ListenableSubscription _encryptCommandResultsListen;
  late final ListenableSubscription _decryptCommandResultsListen;
  late final ListenableSubscription _cleanupCommandResultsListen;

  void _errorCallback(Object? e, {bool popup = false}) {
    if (e is CommandException) {
      final message =
          'Error:${e.message}\n failures:\n ${e.failures}\n success:\n ${e.success}';
      _logStreamController.add(ML.SEVERE, message);
      if (popup) {
        context.showSnackBar(
          ME.tr(MD.rsAutocryptActionCommandResult, args: {'text': message}),
        );
      }
    } else {
      _logStreamController.add(ML.SEVERE, e.toString());
    }

    _cryptActionState.value = _currentCryptActionState;
  }

  void _dataCallback(
    List<(String, String)> datas, {
    String action = '',
    bool popup = false,
  }) {
    final text = action.isEmpty ? datas.toString() : '[$action] $datas';
    if (datas.isNotEmpty) _logStreamController.add(ML.INFO, text);
    if (popup) {
      context.showSnackBar(
        ME.tr(MD.rsAutocryptActionCommandResult, args: {'text': text}),
      );
    }

    _cryptActionState.value = _currentCryptActionState;
  }

  @override
  void initState() {
    super.initState();

    if (widget.sourcePath != null) {
      _sourceController.text = widget.sourcePath!;
      _cryptActionState.value = _currentCryptActionState;
    }

    _archiveCommandResultsListen = archiveCommand.results.listen((rst, _) {
      if (!mounted || !ModalRoute.of(context)!.isCurrent) return;

      if (rst.isRunning) _cryptActionState.value = AutoCryptState.processing;

      if (rst.hasError) _errorCallback(rst.error, popup: true);

      if (rst.isSuccess && rst.hasData) {
        _dataCallback(rst.data ?? [], action: 'archive');
      }
    });

    _unarchiveCommandResultsListen = unarchiveCommand.results.listen((rst, _) {
      if (!mounted || !ModalRoute.of(context)!.isCurrent) return;

      if (rst.isRunning) _cryptActionState.value = AutoCryptState.processing;

      if (rst.hasError) _errorCallback(rst.error, popup: true);

      if (rst.isSuccess && rst.hasData) {
        _dataCallback(rst.data ?? [], popup: true, action: 'unarchive');
      }
    });

    _encryptCommandResultsListen = encryptCommand.results.listen((rst, _) {
      if (!mounted || !ModalRoute.of(context)!.isCurrent) return;

      if (rst.isRunning) _cryptActionState.value = AutoCryptState.processing;

      if (rst.hasError) _errorCallback(rst.error, popup: true);

      if (rst.isSuccess && rst.hasData) {
        _dataCallback(rst.data ?? [], popup: true, action: 'encrypt');
      }
    });

    _decryptCommandResultsListen = decryptCommand.results.listen((rst, _) {
      if (!mounted || !ModalRoute.of(context)!.isCurrent) return;

      if (rst.isRunning) _cryptActionState.value = AutoCryptState.processing;

      if (rst.hasError) _errorCallback(rst.error, popup: true);

      if (rst.isSuccess && rst.hasData) {
        _dataCallback(rst.data ?? [], popup: false, action: 'decrypt');
      }
    });

    _cleanupCommandResultsListen = cleanupCommand.results.listen((rst, _) {
      if (!mounted || !ModalRoute.of(context)!.isCurrent) return;

      if (rst.isRunning) _cryptActionState.value = AutoCryptState.processing;

      if (rst.hasError) _errorCallback(rst.error);

      if (rst.isSuccess && rst.hasData) {
        _dataCallback(rst.data ?? [], action: 'cleanup');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _cryptActionState.dispose();
    _showLogview.dispose();
    _sourceController.dispose();

    _archiveCommandResultsListen.cancel();
    _unarchiveCommandResultsListen.cancel();
    _encryptCommandResultsListen.cancel();
    _decryptCommandResultsListen.cancel();
    _cleanupCommandResultsListen.cancel();
  }

  void _changeInputPath(String path) {
    if (_cryptActionState.value != AutoCryptState.processing) {
      _showLogview.value = true;
      _cryptActionState.value = path.toLowerCase().endsWith(ChaContant.extName)
          ? AutoCryptState.decrypt
          : AutoCryptState.encrypt;
    }
  }

  void _autoCrypt() {
    final input = _sourceController.text;
    if (input.isEmpty) {
      _logStreamController.add(ML.WARNING, 'no input file selected');
      context.showSnackBar(ME.tr(MD.cdAutocryptActionNoInput));
      return;
    }

    final caching = sl<Caching>();
    final cleanupEnum = CleanupEnum.values.byName(caching.cleanup.value);
    final overwrited = caching.overwrited.value;

    if (_cryptActionState.value == AutoCryptState.encrypt) {
      final deletes = <String>{input};
      _logStreamController.clear();
      _logStreamController.add(
        ML.FINEST,
        '${_cryptActionState.value.name} $input',
      );

      archiveCommand.pipeToCommand(
        encryptCommand,
        transform: (params) {
          final sources = <String>[];
          final targets = <String>[];
          for (var param in params) {
            sources.add(param.$1);
            targets.add(param.$2);
          }

          deletes.addAll(sources);
          deletes.addAll(targets);

          return (caching.encDir, targets, overwrited, caching.password.value);
        },
      );

      encryptCommand.pipeToCommand(
        cleanupCommand,
        transform: (params) {
          return (cleanupEnum, deletes.toList(), 1);
        },
      );

      archiveCommand.run((caching.enaDir, [input], overwrited));
    } // end if

    if (_cryptActionState.value == AutoCryptState.decrypt) {
      final deletes = <String>{input};
      _logStreamController.clear();
      _logStreamController.add(
        ML.FINEST,
        '${_cryptActionState.value.name} $input',
      );

      unarchiveCommand.pipeToCommand(
        cleanupCommand,
        transform: (params) {
          return (cleanupEnum, deletes.toList(), 1);
        },
      );

      decryptCommand.pipeToCommand(
        unarchiveCommand,
        transform: (params) {
          final sources = <String>[];
          final targets = <String>[];
          for (var param in params) {
            sources.add(param.$1);
            targets.add(param.$2);
          }

          deletes.addAll(sources);
          deletes.addAll(targets);

          return (caching.deaDir, targets, overwrited);
        },
      );

      decryptCommand.run((
        caching.decDir,
        [input],
        overwrited,
        caching.password.value,
      ));
    } // end if
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = encryptCommand.isRunning.value;
    if (isRunning) {
      _cryptActionState.value = AutoCryptState.processing;
    }
    final os = sl<String>(instanceName: 'os');

    return Scaffold(
      appBar: AppBar(),
      body: ActionLayout(
        inputWidget: SinglePath(
          os: os,
          controller: _sourceController,
          readonly: true,
          onChanged: _changeInputPath,
        ),
        actionWidget: ValueListenableBuilder<AutoCryptState>(
          valueListenable: _cryptActionState,
          builder: (context, state, _) => Padding(
            padding: const EdgeInsets.all(12.0),
            child: ActionButton(
              isProcessing: state == AutoCryptState.processing,
              onPressed: state.enabled ? _autoCrypt : null,
              icon: switch (state) {
                AutoCryptState.encrypt => MenuEntity.encrypt.getIcon(),
                AutoCryptState.decrypt => MenuEntity.decrypt.getIcon(),
                _ => const Icon(Icons.lock_outline),
              },
              label: ME.tr(
                MD.stActionAutocryptButtonLabel,
                args: {'action': state.name},
              ),
            ),
          ),
        ),
        logWidget: ValueListenableBuilder(
          valueListenable: _showLogview,
          builder: (context, showLog, child) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: showLog
                  ? LogStreamView<MenuEntity>(
                      key: const ValueKey('logview'),
                      logStream: _logStreamController.stream,
                      menuItems: const [
                        MenuEntity.copy,
                        MenuEntity.clear,
                        MenuEntity.help,
                      ],
                      onMenuSelected: (value, currentText) {
                        switch (value) {
                          case MenuEntity.copy:
                            Clipboard.setData(
                              ClipboardData(text: _logStreamController.allText),
                            );
                            context.showSnackBar(
                              ME.tr(MD.rsCommonGlobalActionCopied),
                            );
                          case MenuEntity.clear:
                            _logStreamController.clear();
                            setState(() {});
                          case MenuEntity.help:
                            _showLogview.value = false;
                          default:
                        }
                      },
                    )
                  : BriefingView(
                      key: const ValueKey('briefing'),
                      service: sl<BriefingService>(),
                    ),
            );
          },
        ),
      ),
    );
  }
}
