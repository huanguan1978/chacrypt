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
import 'enum_menu_item.dart';

/// Supported display types for the menu.
enum MenuType { dropdownButton, popupMenuButton }

/// A generic menu widget that decouples menu logic from its presentation.
///
/// It supports both [PopupMenuButton] and [DropdownButton] styles.
///
/// ### Example Usage:
///
/// #### 1. Standard Enum (simple labels):
/// ```dart
/// enum MyMenu { save, cancel }
/// MenuAction<MyMenu>(
///   menuType: MenuType.popupMenuButton,
///   menuItems: MyMenu.values,
///   onSelectedAction: (action, _) => print(action?.name),
/// )
/// ```
///
/// #### 2. Intermediate: Enum with Metadata (implementing [MenuItem]):
/// ```dart
/// enum StatusAction implements MenuItem {
///   sync(label: "Sync", icon: Icon(Icons.sync)),
///   clear(label: "Clear", icon: Icon(Icons.delete));
///
///   final String label;
///   final Widget icon;
///   const StatusAction({required this.label, required this.icon});
/// }
///
/// MenuAction<StatusAction>(
///   menuType: MenuType.popupMenuButton,
///   menuItems: StatusAction.values,
///   onSelectedAction: (action, _) => print(action?.label),
/// )
/// ```
///
/// #### 3. Advanced: Using a custom class to implement [MenuItem]:
/// This is useful when you need to bundle functional metadata (like paths,
/// callbacks, or patterns) with your menu items.
/// ```dart
/// class MyOption implements MenuItem {
///   final String label;
///   final Widget icon;
///   final VoidCallback onSelect;
///
///   MyOption(this.label, this.icon, this.onSelect);
/// }
///
/// final items = [MyOption("Open", Icon(Icons.folder), () => print("Opening"))];
///
/// MenuAction<MyOption>(
///   menuType: MenuType.dropdownButton,
///   menuItems: items,
///   onSelectedAction: (option, _) => option?.onSelect(),
/// )
/// ```
class MenuAction<T> extends StatelessWidget {
  const MenuAction({
    super.key,
    required this.menuItems,
    required this.menuType,
    required this.onSelectedAction,
    this.localized,
    this.menuSelected,
    this.passthrough,
    this.alignment,
    this.buttonIcon,
    this.tooltip,
  });

  /// The list of items to display in the menu.
  final List<T> menuItems;

  /// Whether to show as a popup button or a dropdown.
  final MenuType menuType;

  /// The currently selected item (optional).
  final T? menuSelected;

  /// Optional data to pass back to the [onSelectedAction] callback.
  final Object? passthrough;

  /// Alignment of the text within the menu item.
  final Alignment? alignment;

  /// Callback triggered when an item is selected.
  final void Function(T?, Object?) onSelectedAction;

  /// Optional localization function for the item labels.
  final String Function(String)? localized;

  /// The icon shown on the button that opens the menu.
  /// If null, no icon will be displayed.
  final Widget? buttonIcon;

  /// Optional tooltip for the button.
  final String? tooltip;

  Widget _buildItemContent(T item) {
    String label = item.toString();
    Widget? iconWidget;

    if (item case MenuItem item) {
      final customLabel = item.label;
      if (customLabel != null && customLabel.isNotEmpty) {
        label = customLabel;
      }
      if (item.icon case Widget icon) {
        iconWidget = icon;
      }
    }

    if (localized != null) {
      if (item case Enum item) label = item.name;
      label = localized!(label);
    }

    return Align(
      alignment: alignment ?? Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconWidget != null) ...[
            SizedBox(width: 20, child: Center(child: iconWidget)),
            const SizedBox(width: 12),
          ],
          Text(label),
        ],
      ),
    );
  }

  List<PopupMenuItem<T>> popupMenuItemBuilder(BuildContext context) {
    return menuItems.map((item) {
      return PopupMenuItem<T>(value: item, child: _buildItemContent(item));
    }).toList();
  }

  List<DropdownMenuItem<T>> dropdownItemBuilder() {
    return menuItems.map((item) {
      return DropdownMenuItem<T>(value: item, child: _buildItemContent(item));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (menuType == MenuType.popupMenuButton) {
      return PopupMenuButton<T>(
        icon: buttonIcon ?? const Icon(Icons.more_vert),
        tooltip: tooltip,
        itemBuilder: popupMenuItemBuilder,
        onSelected: (entry) => onSelectedAction(entry, passthrough),
        initialValue: menuSelected,
      );
    } else {
      return DropdownButton<T>(
        underline: const SizedBox.shrink(),
        alignment: alignment ?? Alignment.centerLeft,
        icon: buttonIcon ?? const SizedBox.shrink(),
        items: dropdownItemBuilder(),
        onChanged: (entry) => onSelectedAction(entry, passthrough),
        value: menuSelected,
      );
    }
  }
}
