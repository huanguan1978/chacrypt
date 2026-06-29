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

/// A standardized button component for executing actions.
///
/// It encapsulates:
/// - State Handling: Automatic display of [CircularProgressIndicator] when [isProcessing] is true.
/// - Visual Feedback: Manages icon and label rendering.
/// - Consistent Styling: Defaults to a standard [ElevatedButton] style but supports
///   custom overrides via the [style] parameter.
class ActionButton extends StatelessWidget {
  final bool isProcessing;
  final VoidCallback? onPressed;
  final String label;
  final Widget icon;
  final ButtonStyle? style;

  const ActionButton({
    super.key,
    required this.isProcessing,
    required this.onPressed,
    required this.label,
    required this.icon,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        onPressed: isProcessing ? null : onPressed,
        icon: isProcessing
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : icon,
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        style:
            style ??
            ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
      ),
    );
  }
}
