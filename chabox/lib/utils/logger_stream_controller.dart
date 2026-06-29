/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'dart:async';

import 'package:logging/logging.dart' show Level;

class LogStreamController {
  final _controller = StreamController<(Level, String)>.broadcast();
  final StringBuffer _buffer = StringBuffer();

  Stream<(Level, String)> get stream => _controller.stream;

  String get allText => _buffer.toString();
  bool get isEmptyText => _buffer.isEmpty;

  void add(Level level, String text) {
    _buffer.writeln('[$level] $text');
    _controller.add((level, _buffer.toString()));
  }

  void clear() {
    _buffer.clear();
    _controller.add((Level.INFO, ""));
  }

  void dispose() {
    _controller.close();
  }

  // cls.lastline
}
