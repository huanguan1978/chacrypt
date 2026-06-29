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

/// Enforces a consistent three-part vertical layout architecture across action pages:
/// - [inputWidget]: The top section (e.g., input path selection).
/// - [actionWidget]: The middle control section (e.g., settings and action button).
/// - [logWidget]: The bottom section (e.g., logging or status display).
class ActionLayout extends StatelessWidget {
  final Widget inputWidget;
  final Widget actionWidget;
  final Widget logWidget;

  const ActionLayout({
    super.key,
    required this.inputWidget,
    required this.actionWidget,
    required this.logWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        inputWidget,
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: actionWidget,
        ),
        // const Divider(height: 1),
        Expanded(child: logWidget),
      ],
    );
  }
}
