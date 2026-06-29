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
import 'package:flutter_it/flutter_it.dart';

import '../../../utils/caching.dart';
import '../../../core/metrics.dart';

import '../../core/constant.dart';
import '../../utils/obfuscator.dart';
import '../../utils/responsive.dart';
import '../../widget/enum_button_entity.dart';
import '../../widget/enum_menu_action.dart';
import '../../widget/enum_menu_entity.dart';
import '../../message/definition.dart';

import 'file_list_widget.dart';
import 'action_common.dart';

class VaultListPage extends StatefulWidget with WatchItStatefulWidgetMixin {
  const VaultListPage({super.key});

  @override
  State<VaultListPage> createState() => _VaultListPageState();
}

class _VaultListPageState extends State<VaultListPage> {
  final Obfuscator _obfuscator = di<Obfuscator>();
  final GlobalKey<FileListViewState> _fileListKey =
      GlobalKey<FileListViewState>();

  @override
  Widget build(BuildContext context) {
    final isDesktop = sl<bool>(instanceName: 'isDesktop');
    final os = sl<String>(instanceName: 'os');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vault"),
        elevation: 1,
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              final overwrite = sl<Caching>().overwrited.value;
              final result = await _fileListKey.currentState?.pickfiles(
                overwrite: overwrite,
              );
              if (!context.mounted || result == null) return;
              final saved = result.saved;
              final skipped = result.skipped;
              if (saved.isEmpty && skipped.isEmpty) return;
              final parts = [
                if (saved.isNotEmpty) 'Saved: ${saved.join(', ')}',
                if (skipped.isNotEmpty) 'Skipped: ${skipped.join(', ')}',
              ];
              context.showSnackBar(parts.join('  |  '));
            },
            icon: ButtonEntity.pickfiles.getIcon(),
            tooltip: ME.tr(
              MD.stCommonGlobalButtonActionLabel,
              args: {'action': ButtonEntity.pickfiles.toString()},
            ),
          ),

          if (os != 'linux')
            IconButton(
              onPressed: () => _fileListKey.currentState?.sharefiles(),
              icon: ButtonEntity.sharefiles.getIcon(),
              tooltip: ME.tr(
                MD.stCommonGlobalButtonActionLabel,
                args: {'action': ButtonEntity.sharefiles.toString()},
              ),
            ),
        ],
      ),
      body: FileListView(
        key: _fileListKey,
        directory: sl<Caching>().encDir,
        pattern: "**$chaFileExtName",
        trailingMenuAction: (context, file) => MenuAction<MenuEntity>(
          menuType: MenuType.popupMenuButton,
          menuItems: [
            if (os != 'linux') MenuEntity.share,

            MenuEntity.view,
            if (isDesktop) MenuEntity.copyto,
            if (isDesktop) MenuEntity.moveto,
            MenuEntity.copypath,
            MenuEntity.rename,
            MenuEntity.touch,
            MenuEntity.delete,
            MenuEntity.erase,
          ],
          passthrough: file,
          localized: (label) =>
              ME.tr(MD.stCommonGlobalPopupActionLabel, args: {'action': label}),
          onSelectedAction: (action, passthrough) {
            final result = _obfuscator.normalize(
              passthrough.toString(),
              SystemMetrics.bufferSeed,
            );

            // Perform dynamic business-specific check
            if (result.verify(
              (d) => d != null && d.length >= SystemMetrics.blockAlign,
            )) {
              onFileSelectedAction(
                context,
                action,
                passthrough,
                onDone: action == MenuEntity.touch
                    ? _fileListKey.currentState?.refresh
                    : null,
              );
            } else {
              context.showSnackBar(ME.tr(MD.cdVaultActionSecurityCheckFailed));
            }
          },
        ),
      ),
    );
  }

  // cls_lastline
}
