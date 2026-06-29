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

import '../../../../core/constant.dart';
import '../../../../message/definition.dart';
import '../../../../utils/caching.dart';
import '../../../../widget/enum_menu_action.dart';

class SettingAutoSave extends StatelessWidget with WatchItMixin {
  const SettingAutoSave({super.key});

  @override
  Widget build(BuildContext context) {
    final autosave = watchValue((Caching c) => c.autosave);
    final selectedEnum = NoteAutoSave.values.firstWhere(
      (e) => e.s == autosave,
      orElse: () => NoteAutoSave.s30,
    );

    return ListTile(
      title: Text(
        ME.tr(MD.stHomeDrawerSettingTitle, args: {'title': 'autosave'}),
      ),
      trailing: MenuAction<NoteAutoSave>(
        menuType: MenuType.dropdownButton,
        menuItems: NoteAutoSave.values,
        menuSelected: selectedEnum,
        alignment: .centerRight,
        localized: (key) =>
            ME.tr(MD.stHomeDrawerSettingAutosaveLabel, args: {'autosave': key}),
        onSelectedAction: (action, _) {
          if (action != null) {
            sl<Caching>().autosave = action.s;
          }
        },
      ),
    );
  }
}
