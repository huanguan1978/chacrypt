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

/// Copied from [filetools] (Repo: https://github.com/huanguan1978/ft)
/// Methods: FileWriteLevel, fileOverWrite, isDirWritable
/// Update: Replace the implementation below with latest code from repo.

// --- Implementation ---

/// Checks if a [directory] is writable by the current process.
///
/// It attempts to create and then clean up a temporary subdirectory inside [directory]. <br/>
/// If [directory] does not exist, it's first created and deleted to test write permissions on its parent.
///
/// Returns `true` if writable, `false` otherwise (e.g., permission denied, invalid path).
bool isDirWritable(Directory directory, {bool? isDirExist}) {
  isDirExist ??= directory.existsSync();
  Directory? testDir;

  try {
    if (!isDirExist) {
      directory
        ..createSync(recursive: true)
        ..deleteSync();
      return true;
    }

    bool runing = true;
    while (runing) {
      final tempDirName = '._writable_test_${Random().nextInt(1000000)}';
      testDir = Directory('${directory.path}/$tempDirName');
      if (!testDir.existsSync()) {
        runing = false;
        testDir.createSync();
      }
    }

    return true;
  } catch (e) {
    return false;
  } finally {
    if (testDir != null && testDir.existsSync()) {
      try {
        testDir.deleteSync(recursive: true);
      } catch (e) {
        // print(e);
      }
    }
  }
}

// Define security levels for file overwrite.
enum FileWriteLevel { low, medium, high }

/// Overwrite the content of a [file] based on the specified [level] pattern.
///
/// I/O exceptions during the write operation are propagated to the caller. <br />
/// [level]: Fill content: `low` for zeros, `medium` for bits, `high` for random. Defaults to `medium`.
bool fileOverWrite(
  File file, {
  bool? isFileExist,
  FileWriteLevel level = FileWriteLevel.medium,
  bool autoDelete = true, // auto delete after save
}) {
  isFileExist ??= file.existsSync();
  if (!isFileExist) return false;

  final fileSize = file.lengthSync();
  final random = Random.secure();

  // fixed-length list
  List<int> buffer = switch (level) {
    FileWriteLevel.low => List<int>.filled(fileSize, 0),
    FileWriteLevel.medium => List<int>.generate(fileSize, (i) => i % 2),
    _ => List<int>.generate(fileSize, (i) => random.nextInt(256)),
  };

  file.writeAsBytesSync(buffer, flush: true);
  buffer = []; // use dart gc

  if (autoDelete) file.deleteSync();

  return true;
}
