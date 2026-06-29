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

import '../../core/action_registry.dart';
import '../action/layout/autocrypt.dart';
import 'widget/about/about_dialog.dart';
import 'widget/setting/setting_drawer.dart';
import '../../widget/enum_menu_action.dart';
import '../../widget/enum_menu_entity.dart';
import '../../../message/definition.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final isDesktop = sl<bool>(instanceName: 'isDesktop');
    final sourcePath = sl<String>(instanceName: 'sourcePath');
    final displayPath = sourcePath.isNotEmpty ? sourcePath : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: MenuEntity.notes.getIcon(),
            tooltip: ME.tr(
              MD.stCommonGlobalNavActionLabel,
              args: {'action': MenuEntity.notes.name},
            ),
            onPressed: () =>
                ActionRouter.navigate(context, ActionRoute.notesList),
          ),
          IconButton(
            icon: MenuEntity.vault.getIcon(),
            tooltip: ME.tr(
              MD.stCommonGlobalNavActionLabel,
              args: {'action': MenuEntity.vault.name},
            ),
            onPressed: () =>
                ActionRouter.navigate(context, ActionRoute.vaultList),
          ),

          if (isDesktop)
            IconButton(
              icon: MenuEntity.shredding.getIcon(),
              tooltip: ME.tr(
                MD.stCommonGlobalNavActionLabel,
                args: {'action': MenuEntity.shredding.name},
              ),
              onPressed: () => ActionRouter.navigate(context, ActionRoute.wipe),
            ),
          MenuAction<MenuEntity>(
            menuType: MenuType.popupMenuButton,
            menuItems: const [
              MenuEntity.archive,
              MenuEntity.unarchive,
              MenuEntity.encrypt,
              MenuEntity.decrypt,
              MenuEntity.shredding,
              MenuEntity.about,
            ],

            localized: (String key) =>
                ME.tr(MD.stCommonGlobalNavActionLabel, args: {'action': key}),

            onSelectedAction: (entity, _) {
              if (entity == null) return;
              switch (entity) {
                case MenuEntity.shredding:
                  ActionRouter.navigate(context, ActionRoute.wipe);
                case MenuEntity.archive:
                  ActionRouter.navigate(context, ActionRoute.archive);
                case MenuEntity.unarchive:
                  ActionRouter.navigate(context, ActionRoute.unarchive);
                case MenuEntity.encrypt:
                  ActionRouter.navigate(context, ActionRoute.encrypt);
                case MenuEntity.decrypt:
                  ActionRouter.navigate(context, ActionRoute.decrypt);
                case MenuEntity.about:
                  showDialog(
                    context: context,
                    builder: (_) => const AboutInfoDialog(),
                  );
                default:
                  break;
              }
            },
          ),
        ],
      ),
      drawer: SettingDrawer(),
      body: AutocryptPage(sourcePath: displayPath),
    );
  }
}
