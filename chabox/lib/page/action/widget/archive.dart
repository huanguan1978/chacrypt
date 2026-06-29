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
import '../../../utils/file_select_helper.dart';
import '../../../widget/directory.dart';
import 'shared/action_button.dart';
import 'shared/action_section.dart';
import '../../../message/definition.dart';
import '../../../widget/enum_menu_entity.dart';

class Archive extends StatefulWidget {
  final bool isProcessing;
  final String initialOutDir;
  final bool initialOverwrite;
  final VoidCallback? onArchive;
  final Function(String outDir, bool overwrite) onSettingsChanged;
  final bool isDesktop;

  const Archive({
    super.key,
    required this.isProcessing,
    required this.initialOutDir,
    required this.initialOverwrite,
    this.onArchive,
    required this.onSettingsChanged,
    required this.isDesktop,
  });

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  late String _outDir;
  late bool _overwrite;

  @override
  void initState() {
    super.initState();
    _outDir = widget.initialOutDir;
    _overwrite = widget.initialOverwrite;
  }

  void _notifyChanges() {
    widget.onSettingsChanged(_outDir, _overwrite);
  }

  void _handleDirChanged(String path) {
    setState(() => _outDir = path);
    _notifyChanges();
  }

  @override
  Widget build(BuildContext context) {
    void onError(Object err, StackTrace st) =>
        onDirPickError(err, stackTrace: st, context: context);

    return ActionSection(
      children: [
        DirectorySelector(
          title: ME.tr(
            MD.stHomeDrawerDirectoryTitle,
            args: {'title': MenuEntity.archive.toString()},
          ),
          directory: _outDir,
          onError: onError,
          options: [
            DirectoryOption(
              label: ME.tr(
                MD.stCommonGlobalPopupActionLabel,
                args: {'action': MenuEntity.pickfolder.toString()},
              ),
              icon: MenuEntity.pickfolder.getIcon(size: 16),
              onAction: () => DirectorySelector.pickDirectory(
                _outDir,
                _handleDirChanged,
                onError: onError,
              ),
            ),
            if (widget.isDesktop)
              DirectoryOption(
                label: ME.tr(
                  MD.stCommonGlobalPopupActionLabel,
                  args: {'action': MenuEntity.openfolder.toString()},
                ),
                icon: MenuEntity.openfolder.getIcon(size: 16),
                onAction: () =>
                    DirectorySelector.openDirectory(_outDir, onError: onError),
              ),
          ],
          onChanged: (path, _) => _handleDirChanged(path),
        ),
        const Divider(height: 1),
        SwitchListTile(
          title: Text(
            ME.tr(MD.stHomeDrawerSettingTitle, args: {'title': 'overwrite'}),
          ),
          value: _overwrite,
          onChanged: widget.isProcessing
              ? null
              : (val) {
                  setState(() => _overwrite = val);
                  _notifyChanges();
                },
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: ActionButton(
            isProcessing: widget.isProcessing,
            onPressed: widget.onArchive,
            icon: MenuEntity.archive.getIcon(),
            label: ME.tr(
              MD.stCommonGlobalNavActionLabel,
              args: {'action': MenuEntity.archive.toString()},
            ),
          ),
        ),
      ],
    );
  }
}
