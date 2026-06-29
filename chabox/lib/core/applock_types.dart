/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

/// Application Lock Types
enum AppLock { none, passphrase, biometrics }

/// Auto Lock Screen Delay
enum AutoLock {
  m1(60),
  m5(300),
  m15(900);

  final int s;
  const AutoLock(this.s);

  String get label => switch (this) {
    AutoLock.m1 => 'After 1 min',
    AutoLock.m5 => 'After 5 min',
    AutoLock.m15 => 'After 15 min',
  };

  @override
  String toString() => name;
}
