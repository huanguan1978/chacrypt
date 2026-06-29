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

import '../../../../core/constant.dart' show CleanupEnum;
import '../../../../message/definition.dart';
import '../../../../utils/caching.dart';
import '../../../../widget/enum_menu_action.dart';

/// source cleanup

class SettingCleanup extends StatelessWidget with WatchItMixin {
  const SettingCleanup({super.key});

  @override
  Widget build(BuildContext context) {
    final cleanup = watchValue((Caching c) => c.cleanup);
    final cleanupEnum = CleanupEnum.values.asNameMap().containsKey(cleanup)
        ? CleanupEnum.values.byName(cleanup)
        : CleanupEnum.keep;

    return ListTile(
      title: Text(
        ME.tr(MD.stHomeDrawerSettingTitle, args: {'title': 'cleanup'}),
      ),
      trailing: MenuAction<CleanupEnum>(
        menuType: MenuType.dropdownButton,
        menuItems: CleanupEnum.values,
        menuSelected: cleanupEnum,
        alignment: .centerRight,

        localized: (key) =>
            ME.tr(MD.stHomeDrawerSettingCleanupLabel, args: {'cleanup': key}),
        onSelectedAction: (cleanup, _) {
          if (cleanup != null) {
            sl<Caching>().cleanup = cleanup.name;
          }
        },
      ),
    );
  }
}
