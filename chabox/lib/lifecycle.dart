/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'package:app_lifecycle_protector/app_lifecycle_protector.dart';
import 'package:flutter_it/flutter_it.dart';

import 'chabox_app.dart';
import 'core/applock_types.dart' show AppLock;
import 'utils/caching.dart';

class MyLifecycleEvent extends AppLifecycleEvent {
  @override
  void onPeriodic() {
    final instance = AppLifecycleScheduler.instance;
    final isalive = instance.isAlive();
    final appLockName = GetIt.I<Caching>().applock.value;
    final appLock = AppLock.values.byName(appLockName);

    if (!isalive && (appLock != AppLock.none)) {
      screenSecure.setLocked(true);
    }

    super.onPeriodic();
  }

  @override
  void onPause() {
    screenSecure.setMasked(true);
    super.onPause();
  }

  @override
  void onResume() {
    screenSecure.setMasked(false);
    super.onResume();
  }
}
