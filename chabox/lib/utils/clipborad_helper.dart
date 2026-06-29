/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'dart:async' show Timer;

import 'package:flutter/services.dart'
    show Clipboard, ClipboardData, VoidCallback;

class SecureClipboardManager {
  Timer? _timer;
  final int seconds;
  final VoidCallback? onCompleted;

  SecureClipboardManager({this.seconds = 5, this.onCompleted});

  void ignoreAutoClear() => _timer?.cancel();

  void startAutoClear() {
    if (seconds < 1) return;

    _timer?.cancel();
    _timer = Timer(Duration(seconds: seconds), () {
      Clipboard.setData(const ClipboardData(text: ''));
      onCompleted?.call();
    });
  }

  void dispose() => _timer?.cancel();
}
