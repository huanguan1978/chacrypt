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
import 'package:file_selector/file_selector.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/file_helper.dart';
import '../../../../widget/enum_menu_action.dart';
import '../../../../widget/enum_menu_item.dart';

/// Represents a single option within the [DirectorySelector] menu.
///
/// ### Behavior:
/// - If [onAction] is provided, it handles the logic entirely (e.g., picking a folder).
/// - If [onAction] is null, [path] must be provided to trigger [DirectorySelector.onChanged].
class DirectoryOption implements MenuItem {
  @override
  final String label;
  @override
  final Widget icon;
  final String? path;
  final String? pattern;

  /// Custom action. If set, [DirectorySelector.onChanged] won't be called automatically.
  final VoidCallback? onAction;

  DirectoryOption({
    required this.label,
    required this.icon,
    this.path,
    this.pattern,
    this.onAction,
  });
}

/// A specialized [ListTile] for directory selection and management.
///
/// ### Logic Flow:
/// 1. **Data-driven**: Options with [DirectoryOption.path] trigger [onChanged].
/// 2. **Action-driven**: Options with [DirectoryOption.onAction] execute custom logic.
///
/// **Note**: When using [onAction] to update state, manually call the update logic
/// used in [onChanged] to maintain consistency.
///
/// ### Error Handling:
/// Pass [onError] to receive errors from [pickDirectory] or [openDirectory].
/// When omitted, errors are silently ignored.
///
/// ### Recommended Usage:
/// ```dart
/// void _update(String p, [String? pat]) {
///   setState(() => _dir = p);
///   _notify(p);
/// }
///
/// DirectorySelector(
///   onChanged: _update,
///   onError: (e, st) => ScaffoldMessenger.of(context).showSnackBar(...),
///   options: [
///     // Triggers onChanged automatically
///     DirectoryOption(label: "Home", path: "/home", icon: ...),
///     // Requires manual update call in callback
///     DirectoryOption(
///       label: "Pick",
///       icon: ...,
///       onAction: () => DirectorySelector.pickDirectory(
///         _dir, _update, onError: _onError,
///       ),
///     ),
///   ],
/// )
/// ```
class DirectorySelector extends StatelessWidget {
  final String title;
  final String directory;
  final Function(String path, String? pattern) onChanged;
  final List<DirectoryOption> options;

  /// Optional error handler for [pickDirectory] and [openDirectory].
  /// Receives the thrown error and its stack trace.
  final void Function(Object error, StackTrace stackTrace)? onError;

  const DirectorySelector({
    super.key,
    required this.title,
    required this.directory,
    required this.onChanged,
    required this.options,
    this.onError,
  });

  static void pickDirectory(
    String current,
    Function(String) onChanged, {
    void Function(Object error, StackTrace stackTrace)? onError,
  }) {
    getDirectoryPath(initialDirectory: current, canCreateDirectories: true)
        .then((dir) {
          if (dir != null) onChanged(dir);
        })
        .catchError((Object e, StackTrace st) {
          onError?.call(e, st);
        });
  }

  static void openDirectory(
    String directory, {
    void Function(Object error, StackTrace stackTrace)? onError,
  }) {
    final uri = Uri.file(directory);
    canLaunchUrl(uri)
        .then((ok) {
          if (ok) launchUrl(uri);
        })
        .catchError((Object e, StackTrace st) {
          onError?.call(e, st);
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Tooltip(
        message: directory,
        child: Text(
          abbreviatePath(directory, keepFirstSegments: 1, keepLastSegments: 2),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      leading: MenuAction<DirectoryOption>(
        menuType: MenuType.popupMenuButton,
        menuItems: options,
        onSelectedAction: (option, _) {
          if (option == null) return;
          if (option.onAction != null) {
            option.onAction!();
          } else if (option.path != null) {
            onChanged(option.path!, option.pattern);
          }
        },
      ),
    );
  }
}
