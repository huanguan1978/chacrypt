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

import '../../../../core/applock_types.dart';
import '../../../../utils/caching.dart';
import '../../../../message/definition.dart';
import '../../../../widget/enum_button_entity.dart';
import '../../../../widget/enum_menu_action.dart';

class SettingAppLock extends StatelessWidget with WatchItMixin {
  const SettingAppLock({super.key});

  @override
  Widget build(BuildContext context) {
    final applockName = watchValue((Caching c) => c.applock);
    final applock = AppLock.values.byName(applockName);

    return ListTile(
      title: Text(
        ME.tr(MD.stHomeDrawerSettingTitle, args: {'title': 'applock'}),
      ),
      trailing: UnconstrainedBox(
        child: MenuAction<AppLock>(
          menuType: MenuType.dropdownButton,
          menuItems: AppLock.values,
          menuSelected: applock,
          alignment: .centerRight,
          localized: (String key) =>
              ME.tr(MD.stHomeDrawerSettingApplockLabel, args: {'applock': key}),
          onSelectedAction: (action, _) async {
            if (action == null) return;

            if (action != AppLock.none) {
              final confirmed = await _confirmEnableAppLock(context);
              if (confirmed == true) {
                sl<Caching>().applock = action.name;
              }
            } else {
              sl<Caching>().applock = action.name;
            }
          },
        ),
      ),
    );
  }

  Future<bool?> _confirmEnableAppLock(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(
            ME.tr(MD.stCommonDialogTitle, args: {'action': 'applock'}),
          ),
          content: Text(
            ME.tr(MD.cdCommonDialogConfirmMessage, args: {'action': 'applock'}),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(
                ME.tr(
                  MD.stCommonGlobalButtonActionLabel,
                  args: {'action': ButtonEntity.cancel.toString()},
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
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
}
