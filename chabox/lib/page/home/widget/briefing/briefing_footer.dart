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
// import 'package:flutter_it/flutter_it.dart';
import '../../../../utils/sysinfo.dart';

class BriefingFooter extends StatelessWidget {
  const BriefingFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // final pkg = di<Map>(instanceName: 'pkgInfo') as Map<String, dynamic>;
    // final version = pkg['version'] ?? '0.0.0';
    final platform = platformName();
    final platformDisplay = platform[0].toUpperCase() + platform.substring(1);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.lock_outline_rounded,
                size: 12,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 4),
              Text(
                "$platformDisplay | Pure Offline Mode",
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
