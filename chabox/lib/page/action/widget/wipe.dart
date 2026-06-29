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
import 'shared/action_button.dart';
import 'shared/action_section.dart';
import '../../../core/constant.dart' show CleanupEnum;
import '../../../message/definition.dart';
import '../../../widget/enum_menu_entity.dart';
import '../../../widget/enum_menu_action.dart';

class Wipe extends StatefulWidget {
  final bool isProcessing;
  final VoidCallback? onWipe;
  final CleanupEnum initialLevel;
  final int initialIterations;
  final Function(CleanupEnum level, int iterations) onSettingsChanged;

  const Wipe({
    super.key,
    required this.isProcessing,
    this.onWipe,
    required this.initialLevel,
    required this.initialIterations,
    required this.onSettingsChanged,
  });

  @override
  State<Wipe> createState() => _WipeState();
}

class _WipeState extends State<Wipe> {
  late CleanupEnum _level;
  late int _iterations;

  @override
  void initState() {
    super.initState();
    _level = widget.initialLevel;
    _iterations = widget.initialIterations;
  }

  void _notifyChanges() {
    widget.onSettingsChanged(_level, _iterations);
  }

  @override
  Widget build(BuildContext context) {
    return ActionSection(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            spacing: 12,
            children: [
              Expanded(
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: ME.tr(
                      MD.stHomeDrawerSettingCleanupParam,
                      args: {'param': 'level'},
                    ),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                  ),
                  child: MenuAction<CleanupEnum>(
                    menuType: MenuType.dropdownButton,
                    menuItems: CleanupEnum.values
                        .where((e) => e.name.startsWith('wipe'))
                        .toList(),
                    menuSelected: _level,
                    localized: (key) => ME.tr(
                      MD.stHomeDrawerSettingCleanupLabel,
                      args: {'cleanup': key},
                    ),
                    onSelectedAction: widget.isProcessing
                        ? (val, passthrough) {}
                        : (val, _) {
                            if (val != null) {
                              setState(() => _level = val);
                              _notifyChanges();
                            }
                          },
                  ),
                ),
              ),
              Expanded(
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: ME.tr(
                      MD.stHomeDrawerSettingCleanupParam,
                      args: {'param': 'iter'},
                    ),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                  ),
                  child: MenuAction<int>(
                    menuType: MenuType.dropdownButton,
                    menuItems: const [1, 2, 3],
                    menuSelected: _iterations,
                    onSelectedAction: widget.isProcessing
                        ? (val, passthrough) {}
                        : (val, _) {
                            if (val != null) {
                              setState(() => _iterations = val);
                              _notifyChanges();
                            }
                          },
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: ActionButton(
            isProcessing: widget.isProcessing,
            onPressed: widget.onWipe,
            icon: MenuEntity.shredding.getIcon(),
            label: ME.tr(
              MD.stCommonGlobalNavActionLabel,
              args: {'action': MenuEntity.shredding.toString()},
            ),
          ),
        ),
      ],
    );
  }
}
