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

class SettingLanguage extends StatelessWidget with WatchItMixin {
  final void Function(String)? onSelected;

  const SettingLanguage({super.key, this.onSelected});

  @override
  Widget build(BuildContext context) {
    final lang = watchValue((Caching c) => c.lang);
    final selectedLang = LangEnum.values.firstWhere(
      (e) => e.name == lang,
      orElse: () => LangEnum.en,
    );

    return ListTile(
      title: Text(ME.tr(MD.stHomeDrawerSettingTitle, args: {'title': 'lang'})),

      trailing: MenuAction<LangEnum>(
        menuType: MenuType.dropdownButton,
        menuItems: LangEnum.values,
        menuSelected: selectedLang,
        alignment: .centerRight,

        localized: (label) =>
            ME.tr(MD.stHomeDrawerSettingLangLabel, args: {'lang': label}),
        onSelectedAction: (action, _) {
          if (action != null) {
            sl<Caching>().lang = action.name;
            onSelected?.call(action.name);
          }
        },
      ),
    );
  }
}
