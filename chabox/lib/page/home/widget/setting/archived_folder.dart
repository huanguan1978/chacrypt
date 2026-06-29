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

import '../../../../utils/file_select_helper.dart';
import '../../../../widget/directory.dart';
import '../../../../widget/enum_menu_entity.dart';
import '../../../../message/definition.dart';
import '../../../../utils/caching.dart';

class SettingArchivedFolder extends StatelessWidget with WatchItMixin {
  const SettingArchivedFolder({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = sl<bool>(instanceName: 'isDesktop');
    final enapath = watchValue((Caching c) => c.enapath);

    void onError(Object err, StackTrace st) =>
        onDirPickError(err, stackTrace: st, context: context);

    return DirectorySelector(
      title: ME.tr(
        MD.stHomeDrawerDirectoryTitle,
        args: {'title': MenuEntity.archive.toString()},
      ),
      directory: enapath,
      onError: onError,
      options: [
        DirectoryOption(
          label: ME.tr(
            MD.stCommonGlobalPopupActionLabel,
            args: {'action': MenuEntity.pickfolder.toString()},
          ),
          icon: MenuEntity.pickfolder.getIcon(size: 16),
          onAction: () => DirectorySelector.pickDirectory(
            enapath,
            (p) => sl<Caching>().enapath = p,
          ),
        ),
        if (isDesktop)
          DirectoryOption(
            label: ME.tr(
              MD.stCommonGlobalPopupActionLabel,
              args: {'action': MenuEntity.openfolder.toString()},
            ),
            icon: MenuEntity.openfolder.getIcon(size: 16),
            onAction: () => DirectorySelector.openDirectory(enapath),
          ),
      ],
      onChanged: (l, _) => sl<Caching>().enapath = l,
    );
  }
}
