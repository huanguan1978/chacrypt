/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'package:flutter/foundation.dart';
import '../helper/vault_scanner.dart';

class VaultStatsService extends ChangeNotifier {
  VaultStats? _stats;
  bool _loading = false;
  bool _enabled = true;

  VaultStats? get stats => _stats;
  bool get loading => _loading;
  bool get enabled => _enabled;

  void setEnabled(bool enabled) {
    if (_enabled == enabled) return;
    _enabled = enabled;
    if (!_enabled) {
      _stats = VaultStats.zero();
    }
    notifyListeners();
  }

  Future<void> scan({bool force = false}) async {
    if (!_enabled) {
      _stats = VaultStats.zero();
      notifyListeners();
      return;
    }

    if (_stats != null && !force) return;

    _loading = true;
    notifyListeners();

    _stats = await VaultScanner().scan();
    _loading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    await VaultScanner().refresh();
    await scan(force: true);
  }
}
