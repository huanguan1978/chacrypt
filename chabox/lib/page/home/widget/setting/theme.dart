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

import '../../../../utils/caching.dart';
import '../../../../message/definition.dart';
import '../../../../widget/enum_menu_action.dart';

class SettingTheme extends StatelessWidget with WatchItMixin {
  const SettingTheme({super.key});

  @override
  Widget build(BuildContext context) {
    final themeName = watchValue((Caching c) => c.theme);
    final selectedTheme = ThemeMode.values.firstWhere(
      (e) => e.name == themeName,
      orElse: () => ThemeMode.system,
    );

    return ListTile(
      title: Text(ME.tr(MD.stHomeDrawerSettingTitle, args: {'title': 'theme'})),
      trailing: MenuAction<ThemeMode>(
        menuType: MenuType.dropdownButton,
        menuItems: ThemeMode.values,
        menuSelected: selectedTheme,
        alignment: .centerRight,

        localized: (label) =>
            ME.tr(MD.stHomeDrawerSettingThemeLabel, args: {'theme': label}),
        onSelectedAction: (action, _) {
          if (action != null) {
            sl<Caching>().theme = action.name;
          }
        },
      ),
    );
  }
}
