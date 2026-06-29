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

import '../../../../message/definition.dart';
import '../../../../utils/caching.dart';
import '../../helper/vault_stats_service.dart';

class SettingStats extends StatelessWidget with WatchItMixin {
  const SettingStats({super.key});

  @override
  Widget build(BuildContext context) {
    final showStats = watchValue((Caching c) => c.stats);
    /*
    return SwitchListTile(
      title: Text(ME.tr(MD.stHomeDrawerSettingTitle, args: {'title': 'stats'})),
      value: showStats,
      onChanged: (value) {
        sl<Caching>().showStats = value;
        sl<VaultStatsService>().setEnabled(value);
      },
    );
    */

    return Row(
      children: [
        Checkbox(
          value: showStats,
          onChanged: (l) {
            sl<Caching>().stats = l ?? true;
            sl<VaultStatsService>().setEnabled(l ?? true);
          },
        ),

        Expanded(
          child: Text(
            ME.tr(MD.stHomeDrawerSettingTitle, args: {'title': 'stats'}),
          ),
        ),
      ],
    );
  }
}
