/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

/// An interface for menu items to ensure they provide necessary display information.
abstract interface class MenuItem {
  /// The label or display text for the menu item.
  String? get label;

  /// The icon associated with the menu item, if any.
  /// This is defined as Object? to remain decoupled from Flutter's Widget type.
  Object? get icon;
}
