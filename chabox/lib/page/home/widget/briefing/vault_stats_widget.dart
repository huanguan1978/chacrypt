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
import '../../helper/vault_scanner.dart';

import '../../../../widget/enum_menu_entity.dart';
import '../../../../../message/definition.dart';

class VaultStatsWidget extends StatelessWidget {
  final VaultStats stats;

  const VaultStatsWidget({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: IntrinsicColumnWidth(),
        2: FlexColumnWidth(3),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        _buildRow(
          ME.tr(
            MD.stCommonGlobalNavActionLabel,
            args: {'action': MenuEntity.archive.toString()},
          ),
          stats.enaCount,
          stats.enaSize,
          context,
        ),
        _buildRow(
          ME.tr(
            MD.stCommonGlobalNavActionLabel,
            args: {'action': MenuEntity.unarchive.toString()},
          ),
          stats.deaCount,
          stats.deaSize,
          context,
        ),
        _buildRow(
          ME.tr(
            MD.stCommonGlobalNavActionLabel,
            args: {'action': MenuEntity.encrypt.toString()},
          ),
          stats.encCount,
          stats.encSize,
          context,
        ),
        _buildRow(
          ME.tr(
            MD.stCommonGlobalNavActionLabel,
            args: {'action': MenuEntity.decrypt.toString()},
          ),
          stats.decCount,
          stats.decSize,
          context,
        ),
        _buildRow(
          ME.tr(
            MD.stCommonGlobalNavActionLabel,
            args: {'action': MenuEntity.notes.toString()},
          ),
          stats.noteCount,
          stats.noteSize,
          context,
        ),
      ],
    );
  }

  TableRow _buildRow(String label, int count, int size, BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );
    final numberStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontFamily: 'monospace',
      fontWeight: FontWeight.w500,
    );

    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text(label, style: labelStyle),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          child: Text(
            count.toString(),
            textAlign: TextAlign.right,
            style: numberStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text(
            stats.formatSize(size),
            textAlign: TextAlign.right,
            style: numberStyle,
          ),
        ),
      ],
    );
  }
}
