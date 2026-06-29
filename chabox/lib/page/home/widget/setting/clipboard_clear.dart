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

import '../../../../core/constant.dart' show ClipDelay;
import '../../../../message/definition.dart';
import '../../../../utils/caching.dart';
import '../../../../widget/enum_menu_action.dart';

class SettingAutoClearClipboard extends StatelessWidget with WatchItMixin {
  const SettingAutoClearClipboard({super.key});

  @override
  Widget build(BuildContext context) {
    final autocc = watchValue((Caching c) => c.autocc);
    final selectedEnum = ClipDelay.values.firstWhere(
      (e) => e.name == autocc,
      orElse: () => ClipDelay.s00,
    );

    return ListTile(
      title: Text(
        ME.tr(MD.stHomeDrawerSettingTitle, args: {'title': 'autoclear'}),
      ),
      trailing: MenuAction<ClipDelay>(
        menuType: MenuType.dropdownButton,
        menuItems: ClipDelay.values,
        menuSelected: selectedEnum,
        alignment: .centerRight,

        localized: (key) =>
            ME.tr(MD.stHomeDrawerSettingAutoccLabel, args: {'autocc': key}),
        onSelectedAction: (action, _) {
          if (action != null) {
            sl<Caching>().autocc = action.name;
          }
        },
      ),
    );
  }
}
