/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'package:chabox/widget/enum_menu_entity.dart';
import 'package:flutter/material.dart';
import '../../../utils/file_select_helper.dart';
import '../../../widget/directory.dart';
import 'shared/action_button.dart';
import 'shared/action_section.dart';
import '../../../message/definition.dart';

enum CryptActionType { encrypt, decrypt }

class CryptActionWidget extends StatefulWidget {
  final CryptActionType type;
  final bool isProcessing;
  final String initialOutDir;
  final bool initialOverwrite;
  final String initialPassword;
  final VoidCallback? onExecute;
  final Function(String outDir, bool overwrite, String password)
  onSettingsChanged;
  final bool isDesktop;

  const CryptActionWidget({
    super.key,
    required this.type,
    required this.isProcessing,
    required this.initialOutDir,
    required this.initialOverwrite,
    required this.initialPassword,
    this.onExecute,
    required this.onSettingsChanged,
    required this.isDesktop,
  });

  @override
  State<CryptActionWidget> createState() => _CryptActionWidgetState();
}

class _CryptActionWidgetState extends State<CryptActionWidget> {
  late String _outDir;
  late bool _overwrite;
  late String _password;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _outDir = widget.initialOutDir;
    _overwrite = widget.initialOverwrite;
    _password = widget.initialPassword;
  }

  void _notifyChanges() {
    widget.onSettingsChanged(_outDir, _overwrite, _password);
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
          title: widget.type == CryptActionType.encrypt
              ? ME.tr(
                  MD.stHomeDrawerDirectoryTitle,
                  args: {'title': MenuEntity.encrypt.toString()},
                )
              : ME.tr(
                  MD.stHomeDrawerDirectoryTitle,
                  args: {'title': MenuEntity.decrypt.toString()},
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextFormField(
            initialValue: _password,
            obscureText: _isObscure,
            decoration: InputDecoration(
              labelText: ME.tr(
                MD.stHomeDrawerSettingTitle,
                args: {'title': 'secret'},
              ),
              isDense: true,
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => setState(() => _isObscure = !_isObscure),
              ),
            ),
            onChanged: (val) {
              _password = val;
              _notifyChanges();
            },
          ),
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
            onPressed: widget.onExecute,
            icon: widget.type == CryptActionType.encrypt
                ? MenuEntity.encrypt.getIcon()
                : MenuEntity.decrypt.getIcon(),
            label: widget.type == CryptActionType.encrypt
                ? ME.tr(
                    MD.stCommonGlobalNavActionLabel,
                    args: {'action': MenuEntity.encrypt.toString()},
                  )
                : ME.tr(
                    MD.stCommonGlobalNavActionLabel,
                    args: {'action': MenuEntity.decrypt.toString()},
                  ),
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.type == CryptActionType.encrypt
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.secondaryContainer,
              foregroundColor: widget.type == CryptActionType.encrypt
                  ? Theme.of(context).colorScheme.onPrimaryContainer
                  : Theme.of(context).colorScheme.onSecondaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
