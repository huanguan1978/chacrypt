/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'dart:async' show FutureOr, Timer;

import 'package:flutter/material.dart';

/// Configuration constants for responsive breakpoints and base scaling.
class ResponsiveConfig {
  static const double mobileLimit = 768.0; // 600.0;
  static const double tabletLimit = 1024.0;

  // Base width for UI scaling (derived from design draft, usually 375 for mobile).
  static const double baseWidth = 375.0;

  // Scaling limits to prevent extreme UI distortions on large/small screens.
  static const double minScaleFactor = 0.8;
  static const double maxScaleFactor = 1.5;
}

/// Helper extensions for BuildContext to simplify responsive checks.
extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  // Device type detection.
  bool get isMobile => screenWidth < ResponsiveConfig.mobileLimit;
  bool get isTablet =>
      screenWidth >= ResponsiveConfig.mobileLimit &&
      screenWidth < ResponsiveConfig.tabletLimit;
  bool get isDesktop => screenWidth >= ResponsiveConfig.tabletLimit;

  /// Scales values (font size, padding, spacing) based on screen width.
  /// Uses [ResponsiveConfig.baseWidth] as the reference point.
  double scale(double value) {
    final double scaleFactor = screenWidth / ResponsiveConfig.baseWidth;
    return (value * scaleFactor).clamp(
      value * ResponsiveConfig.minScaleFactor,
      value * ResponsiveConfig.maxScaleFactor,
    );
  }
}

/// A wrapper widget to provide conditional layout rendering.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isDesktop) return desktop;
    if (context.isTablet && tablet != null) return tablet!;
    return mobile;
  }
}

/// Helper to get responsive UI based on device type.
/// Usage: ResponsiveHelper.choose(context, mobile: ..., desktop: ...)
class ResponsiveHelper {
  static T choose<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (context.isDesktop) return desktop;
    if (context.isTablet && tablet != null) return tablet;
    return mobile;
  }
}

// Extension methods for concise navigation in Flutter.
extension NavigationContext on BuildContext {
  /// Pushes the given [page] onto the stack.
  Future<T?> push<T>(Widget page, {bool fullscreenDialog = false}) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(
        builder: (_) => page,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  /// Replaces the current route with the given [page].
  Future<T?> pushReplacement<T, TO>(Widget page) {
    return Navigator.pushReplacement<T, TO>(
      this,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Pushes the [page] and removes all previous routes.
  Future<T?> pushAndRemoveUntil<T>(Widget page) {
    return Navigator.pushAndRemoveUntil<T>(
      this,
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  /// Pops the top-most route off the navigator.
  void pop<T>([T? result]) => Navigator.pop<T>(this, result);
}

/// Extensions for showing custom snackbars.
extension SnackBarContext on BuildContext {
  static OverlayEntry? _entry;
  static Timer? _timer;

  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    _entry?.remove();
    _timer?.cancel();

    final overlay = Overlay.of(this);
    final visible = ValueNotifier(true);

    _entry = OverlayEntry(
      builder: (context) {
        final theme = Theme.of(context);
        final snackBarTheme = theme.snackBarTheme;

        return Positioned(
          bottom: 50,
          left: 20,
          right: 20,
          child: GestureDetector(
            onTap: () => visible.value = false,
            child: ValueListenableBuilder<bool>(
              valueListenable: visible,
              builder: (_, val, _) => AnimatedOpacity(
                opacity: val ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                onEnd: () {
                  if (!val) _removeSnackBar();
                },
                child: Material(
                  color:
                      snackBarTheme.backgroundColor ??
                      (theme.brightness == Brightness.dark
                          ? Colors.grey[800]
                          : Colors.grey[900]),
                  borderRadius: snackBarTheme.shape is RoundedRectangleBorder
                      ? (snackBarTheme.shape as RoundedRectangleBorder)
                            .borderRadius
                      : BorderRadius.circular(4),
                  elevation: snackBarTheme.elevation ?? 6.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      message,
                      style:
                          snackBarTheme.contentTextStyle ??
                          const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(_entry!);
    _timer = Timer(duration, () => visible.value = false);
  }

  static void _removeSnackBar() {
    _timer?.cancel();
    _timer = null;
    _entry?.remove();
    _entry = null;
  }
}

/// Extensions for showing custom dialogs.
extension DialogContext on BuildContext {
  /// Shows a dialog with a self-sufficient form component.
  ///
  /// The [child] should be a form-like widget that manages its own state.
  /// The [onConfirm] and [onReset] are simple command triggers.
  ///
  /// Example (Standard Encapsulated Pattern):
  /// ```dart
  /// // 1. Component acts as a "Bridge", managing internal FormState
  /// class _UserForm extends StatefulWidget {
  ///   const _UserForm({super.key});
  ///   @override
  ///   State<_UserForm> createState() => _UserFormState();
  /// }
  ///
  /// class _UserFormState extends State<_UserForm> {
  ///   final _formKey = GlobalKey<FormState>(); // Internal: Cascaded by external key
  ///   final _data = <String, String>{};
  ///
  ///   void reset() => _formKey.currentState?.reset();
  ///
  ///   // This is the "Public API" of your form component
  ///   Future<Map<String, String>?> submit() async {
  ///     if (!(_formKey.currentState?.validate() ?? false)) return null;
  ///
  ///     _formKey.currentState?.save();
  ///     // Optional: Do async work here (e.g., call API, crypto check)
  ///     return _data; // Non-null result will trigger dialog pop
  ///   }
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Form(
  ///       key: _formKey,
  ///       child: TextFormField(
  ///         decoration: const InputDecoration(labelText: "Username"),
  ///         validator: (v) => v!.isEmpty ? "Required" : null,
  ///         onSaved: (v) => _data['name'] = v!,
  ///       ),
  ///     );
  ///   }
  /// }
  ///
  /// // 2. Caller controls everything through a single "Bridge" key
  /// final userFormKey = GlobalKey<_UserFormState>();
  /// final result = await context.showFormDialog<Map<String, String>>(
  ///   title: const Text("User Profile"),
  ///   child: _UserForm(key: userFormKey),
  ///   onConfirm: () => userFormKey.currentState?.submit(), // Cascades to internal logic
  ///   onReset: () => userFormKey.currentState?.reset(),
  /// );
  /// ```
  Future<T?> showFormDialog<T>({
    required Widget title,
    required Widget child,
    required FutureOr<T?> Function() onConfirm,
    VoidCallback? onReset,
    String cancelText = "CANCEL",
    String confirmText = "CONFIRM",
    String resetText = "RESET",
    Color? confirmColor,
    bool barrierDismissible = true,
  }) {
    bool isBusy = false;

    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: title,
              content: Opacity(
                opacity: isBusy ? 0.5 : 1.0,
                child: AbsorbPointer(
                  absorbing: isBusy,
                  child: SingleChildScrollView(child: child),
                ),
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                if (onReset != null)
                  TextButton(
                    onPressed: isBusy ? null : onReset,
                    child: Text(
                      resetText,
                      style: TextStyle(
                        color: isBusy ? Colors.grey : Colors.blueGrey,
                      ),
                    ),
                  )
                else
                  const SizedBox.shrink(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: isBusy ? null : () => Navigator.pop(context),
                      child: Text(cancelText),
                    ),
                    TextButton(
                      onPressed: isBusy
                          ? null
                          : () async {
                              setState(() => isBusy = true);
                              try {
                                final result = await onConfirm();
                                if (result != null) {
                                  if (context.mounted) {
                                    Navigator.pop(context, result);
                                  }
                                }
                              } finally {
                                if (context.mounted) {
                                  setState(() => isBusy = false);
                                }
                              }
                            },
                      child: isBusy
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              confirmText,
                              style: confirmColor != null
                                  ? TextStyle(color: confirmColor)
                                  : null,
                            ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Shows a common confirmation dialog.
  Future<bool?> showConfirmDialog({
    required Widget title,
    Widget? content,
    String cancelText = "CANCEL",
    String confirmText = "CONFIRM",
    Color? confirmColor,
    bool barrierDismissible = true,
  }) {
    return showDialog<bool>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
        title: title,
        content: content != null ? SingleChildScrollView(child: content) : null,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              confirmText,
              style: confirmColor != null
                  ? TextStyle(color: confirmColor)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  /// Shows a common input dialog.
  Future<String?> showInputDialog({
    required Widget title,
    Widget? content,
    required Widget inputField,
    required TextEditingController controller,
    String cancelText = "CANCEL",
    String confirmText = "CONFIRM",
    Color? confirmColor,
    bool barrierDismissible = true,
    void Function(BuildContext)? onConfirm,
  }) {
    return showDialog<String>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          title: title,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (content != null) ...[content, const SizedBox(height: 16)],
                inputField,
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(cancelText),
            ),
            TextButton(
              onPressed: onConfirm != null
                  ? () => onConfirm(context)
                  : () => Navigator.pop(context, controller.text.trim()),
              child: Text(
                confirmText,
                style: confirmColor != null
                    ? TextStyle(color: confirmColor)
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

// cls_lastline
