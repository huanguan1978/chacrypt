/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'dart:io';
import 'dart:math';
import 'package:chabox/core/constant.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:flutter_it/flutter_it.dart';
import '../../../utils/caching.dart';

class VaultStats {
  final int encCount;
  final int encSize;
  final int noteCount;
  final int noteSize;
  final int decCount;
  final int decSize;
  final int enaCount;
  final int enaSize;
  final int deaCount;
  final int deaSize;

  VaultStats({
    required this.encCount,
    required this.encSize,
    required this.noteCount,
    required this.noteSize,
    required this.decCount,
    required this.decSize,
    required this.enaCount,
    required this.enaSize,
    required this.deaCount,
    required this.deaSize,
  });

  factory VaultStats.zero() => VaultStats(
    encCount: 0,
    encSize: 0,
    noteCount: 0,
    noteSize: 0,
    decCount: 0,
    decSize: 0,
    enaCount: 0,
    enaSize: 0,
    deaCount: 0,
    deaSize: 0,
  );

  String formatSize(int bytes) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(2)} ${suffixes[i]}';
  }
}

class VaultScanner {
  VaultStats? _stats;

  VaultStats? get stats => _stats;

  Future<VaultStats> scan({bool force = false}) async {
    if (!force && _stats != null) {
      return _stats!;
    }

    final caching = GetIt.I<Caching>();

    final encFiles = await _scanDir(caching.encDir, '**$chaFileExtName');
    final noteFiles = await _scanDir(caching.noteDir, '**$chaNoteExtName');
    final decFiles = await _scanDir(caching.decDir, anyFileExtName);
    final enaFiles = await _scanDir(caching.enaDir, anyFileExtName);
    final deaFiles = await _scanDir(caching.deaDir, anyFileExtName);

    _stats = VaultStats(
      encCount: encFiles.count,
      encSize: encFiles.size,
      noteCount: noteFiles.count,
      noteSize: noteFiles.size,
      decCount: decFiles.count,
      decSize: decFiles.size,
      enaCount: enaFiles.count,
      enaSize: enaFiles.size,
      deaCount: deaFiles.count,
      deaSize: deaFiles.size,
    );

    return _stats!;
  }

  Future<VaultStats> refresh() => scan(force: true);

  Future<({int count, int size})> _scanDir(
    Directory dir,
    String pattern,
  ) async {
    int count = 0;
    int size = 0;
    if (!await dir.exists()) return (count: 0, size: 0);

    final glob = Glob(pattern, recursive: true);
    try {
      final list = glob.listSync(root: dir.path);
      for (final entity in list) {
        if (entity case File file) {
          count++;
          size += file.lengthSync();
        }
      }
    } catch (e) {
      // ignore errors
    }
    return (count: count, size: size);
  }
}
