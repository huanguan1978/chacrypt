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

class SettingOverwrite extends StatelessWidget with WatchItMixin {
  const SettingOverwrite({super.key});

  @override
  Widget build(BuildContext context) {
    final overwrited = watchValue((Caching c) => c.overwrited);

    return Row(
      children: [
        Checkbox(
          value: overwrited,
          onChanged: (l) => sl<Caching>().overwrited = l ?? true,
        ),

        Expanded(
          child: Text(
            ME.tr(MD.stHomeDrawerSettingTitle, args: {'title': 'overwrite'}),
          ),
        ),
      ],
    );
  }
}
