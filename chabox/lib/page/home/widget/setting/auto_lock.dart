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
import '../../../../message/definition.dart';
import '../../../../utils/caching.dart';
import '../../../../widget/enum_menu_action.dart';

class SettingAutoLock extends StatelessWidget with WatchItMixin {
  const SettingAutoLock({super.key});

  @override
  Widget build(BuildContext context) {
    final autolockName = watchValue((Caching c) => c.autolock);
    final selectedEnum = AutoLock.values.firstWhere(
      (e) => e.name == autolockName,
      orElse: () => AutoLock.m5,
    );

    return ListTile(
      title: Text(
        ME.tr(MD.stHomeDrawerSettingTitle, args: {'title': 'autolock'}),
      ),
      trailing: UnconstrainedBox(
        child: MenuAction<AutoLock>(
          menuType: MenuType.dropdownButton,
          menuItems: AutoLock.values,
          menuSelected: selectedEnum,
          alignment: Alignment.centerRight,
          // Since AutoLock no longer implements MenuItem, we handle naming manually.
          localized: (String key) => ME.tr(
            MD.stHomeDrawerSettingAutolockLabel,
            args: {'autolock': key},
          ),
          onSelectedAction: (action, _) {
            if (action != null) {
              sl<Caching>().autolock = action.name;
            }
          },
        ),
      ),
    );
  }
}
