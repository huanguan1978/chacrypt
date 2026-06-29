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
import 'dart:io';

import 'package:flutter_it/flutter_it.dart';
import 'package:path/path.dart' as p;

import 'package:chabox/thirdparty/ft_wipe.dart';
import 'package:chapose/chapose.dart';

import '../../core/constant.dart' show CleanupEnum, chaFileExtName;
import '../thirdparty/ft_archive.dart';
import '../thirdparty/ft_textmime.dart';
import '../thirdparty/patching_zlib.dart';

// --- Exceptions ---

/// Exception thrown when invalid input is provided to a cryptographic operation.
class CryptInputException implements Exception {
  final String message;
  final ML ml;

  CryptInputException(this.ml, this.message);

  @override
  String toString() => "Error $ml: $message";
}

/// Base exception for batch commands, tracking both failed and successful operations.
class CommandException implements Exception {
  /// A descriptive error message.
  final String message;

  /// A list of (source path, error message) pairs for failed operations.
  final List<(String, String)> failures;

  /// A list of (source path, result path) pairs for successful operations.
  final List<(String, String)> success;
  CommandException(this.message, this.failures, this.success);

  @override
  String toString() =>
      '$message: ${failures.length} errors occurred. failures:$failures. ';
}

/// Exception thrown when an error occurs during an encryption operation.
class EncryptException extends CommandException {
  EncryptException(super.message, super.failures, super.success);
}

/// Exception thrown when an error occurs during an archive operation.
class ArchiveException extends CommandException {
  ArchiveException(super.message, super.failures, super.success);
}

/// Exception thrown when an error occurs during an unarchive operation.
class UnarchiveException extends CommandException {
  UnarchiveException(super.message, super.failures, super.success);
}

/// Exception thrown when an error occurs during a decryption operation.
class DecryptException extends CommandException {
  DecryptException(super.message, super.failures, super.success);
}

/// Exception thrown when an error occurs during a cleanup or wipe operation.
class CleanupException extends CommandException {
  CleanupException(super.message, super.failures, super.success);
}

// --- Batch Framework ---

/// Represents a single unit of work within a batch operation.
class _BatchTask {
  /// The original file or directory.
  final FileSystemEntity source;

  /// The intended target file or directory.
  final FileSystemEntity target;

  /// The asynchronous operation to perform.
  final Future<void> Function() operation;

  _BatchTask({
    required this.source,
    required this.target,
    required this.operation,
  });
}

/// A clean, high-level coordinator for batch file operations.
///
/// Handles directory preparation, pre-check validation, concurrent execution,
/// and detailed error reporting.
Future<List<(String, String)>> _executeBatch(
  Directory toDir,
  List<String> paths,
  bool overwrited, {
  required _BatchTask? Function(FileSystemEntity source) createTask,
  required CommandException Function(
    String message,
    List<(String, String)> failures,
    List<(String, String)> success,
  )
  errorFactory,
}) async {
  if (!toDir.existsSync()) toDir.createSync(recursive: true);

  final List<(String, String)> success = [];
  final List<(String, String)> failures = [];
  final List<_BatchTask> tasks = [];

  // 1. Planning & Validation Phase
  for (var path in paths) {
    final type = FileSystemEntity.typeSync(path);
    if (type == FileSystemEntityType.notFound) {
      failures.add((path, 'Source not found.'));
      continue;
    }

    final source = type == FileSystemEntityType.directory
        ? Directory(path)
        : File(path);
    final task = createTask(source);

    if (task == null) continue;

    // Check for target conflicts if overwriting is disabled
    if (!overwrited && task.target.existsSync()) {
      failures.add((source.path, 'Target already exists: ${task.target.path}'));
    } else {
      tasks.add(task);
    }
  }

  // Pre-execution guard: abort if conflicts exist and overwriting is disabled
  if (failures.isNotEmpty && !overwrited) {
    throw errorFactory('Conflict detected before starting.', failures, success);
  }

  // 2. Execution Phase
  await Future.wait(
    tasks.map((task) async {
      try {
        await task.operation();
        success.add((task.source.path, task.target.path));
      } catch (e) {
        failures.add((task.source.path, e.toString()));
      }
    }),
  );

  // 3. Final Reporting
  if (failures.isNotEmpty) {
    throw errorFactory('Batch operation partially failed.', failures, success);
  }

  return success;
}

// --- Specific Command Helpers ---

/// Compresses a file using Gzip or copies it if it's not a text file.
Future<void> _performArchiveFile(File source, File target) async {
  if (!isTextMimeType(source.path)) {
    await source.copy(target.path);
    return;
  }
  await compressFile(source, target, onError: (e, _) => throw e);
}

/// Archives a directory into a .tgz (Tarball + Gzip) file.
Future<void> _performArchiveDir(Directory source, File target) {
  final completer = Completer<void>();
  TarHelper.archive(
    ArchiveOptions(
      entities: [source],
      basePath: source.parent.path,
      outputFile: target,
      useGzip: true,
      onSuccess: () => completer.complete(),
      onError: (e, _) => completer.completeError(e),
    ),
  );
  return completer.future;
}

// --- Public Commands ---

/// Batch encrypts files using a password-derived key.
///
/// Parameters:
/// - `pair.$1` ([Directory]): The target directory.
/// - `pair.$2` ([List]<[String]>): List of file paths to encrypt.
/// - `pair.$3` ([bool]): Whether to overwrite existing files.
/// - `pair.$4` ([String]): Raw password for key derivation.
final encryptCommand =
    Command.createAsync<
      (Directory, List<String>, bool, String),
      List<(String, String)>
    >(
      (pair) {
        final key = deriveKey(pair.$4);
        return _executeBatch(
          pair.$1,
          pair.$2,
          pair.$3,
          errorFactory: EncryptException.new,
          createTask: (source) {
            if (source is! File) return null;
            final fileName = p.basename(source.path);
            final targetName = fileName.endsWith(chaFileExtName)
                ? fileName
                : '$fileName$chaFileExtName';
            final target = File(p.join(pair.$1.path, targetName));

            return _BatchTask(
              source: source,
              target: target,
              operation: () => fileEncrypt(key, source, target),
            );
          },
        );
      },
      initialValue: <(String, String)>[],
      debugName: 'encryptCommand',
    );

/// Batch archives files (compressing text) and directories (to .tgz).
///
/// Parameters:
/// - `pair.$1` ([Directory]): The target directory.
/// - `pair.$2` ([List]<[String]>): List of paths to archive.
/// - `pair.$3` ([bool]): Whether to overwrite existing target files.
final archiveCommand =
    Command.createAsync<
      (Directory, List<String>, bool),
      List<(String, String)>
    >(
      (pair) => _executeBatch(
        pair.$1,
        pair.$2,
        pair.$3,
        errorFactory: ArchiveException.new,
        createTask: (source) {
          if (source is File) {
            final isText = isTextMimeType(source.path);
            final target = File(
              p.join(
                pair.$1.path,
                isText
                    ? '${p.basename(source.path)}.gz'
                    : p.basename(source.path),
              ),
            );
            return _BatchTask(
              source: source,
              target: target,
              operation: () => _performArchiveFile(source, target),
            );
          } else if (source is Directory) {
            final target = File(
              p.join(pair.$1.path, '${p.basename(source.path)}.tgz'),
            );
            return _BatchTask(
              source: source,
              target: target,
              operation: () => _performArchiveDir(source, target),
            );
          }
          return null;
        },
      ),
      initialValue: <(String, String)>[],
      debugName: 'archiveCommand',
    );

/// Batch restores .gz files and .tgz archives.
///
/// Parameters:
/// - `pair.$1` ([Directory]): The extraction target directory.
/// - `pair.$2` ([List]<[String]>): List of paths to restore.
/// - `pair.$3` ([bool]): Whether to overwrite existing entities.
final unarchiveCommand =
    Command.createAsync<
      (Directory, List<String>, bool),
      List<(String, String)>
    >(
      (pair) => _executeBatch(
        pair.$1,
        pair.$2,
        pair.$3,
        errorFactory: UnarchiveException.new,
        createTask: (source) {
          if (source is! File) return null;
          final path = source.path.toLowerCase();

          // Handle Directory Restore
          if (path.endsWith('.tgz') || path.endsWith('.tar')) {
            final target = Directory(
              p.join(pair.$1.path, p.basenameWithoutExtension(source.path)),
            );
            return _BatchTask(
              source: source,
              target: target,
              operation: () {
                final c = Completer<void>();
                TarHelper.unArchive(
                  UnArchiveOptions(
                    file: source,
                    targetDir: target,
                    onSuccess: () => c.complete(),
                    onError: (e, _) => c.completeError(e),
                  ),
                );
                return c.future;
              },
            );
          }

          // Handle File Restore
          if (path.endsWith('.gz')) {
            final target = File(
              p.join(pair.$1.path, p.basenameWithoutExtension(source.path)),
            );
            return _BatchTask(
              source: source,
              target: target,
              operation: () =>
                  decompressFile(source, target, onError: (e, _) => throw e),
            );
          }
          return null;
        },
      ),
      initialValue: <(String, String)>[],
      debugName: 'unarchiveCommand',
    );

/// Batch decrypts files with the .cha extension.
///
/// Parameters:
/// - `pair.$1` ([Directory]): The target directory.
/// - `pair.$2` ([List]<[String]>): List of paths to decrypt.
/// - `pair.$3` ([bool]): Whether to overwrite existing files.
/// - `pair.$4` ([String]): Raw password for key derivation.
final decryptCommand =
    Command.createAsync<
      (Directory, List<String>, bool, String),
      List<(String, String)>
    >(
      (pair) {
        final key = deriveKey(pair.$4);
        return _executeBatch(
          pair.$1,
          pair.$2,
          pair.$3,
          errorFactory: DecryptException.new,
          createTask: (source) {
            if (source is! File ||
                !source.path.toLowerCase().endsWith(chaFileExtName)) {
              return null;
            }
            final target = File(
              p.join(pair.$1.path, p.basenameWithoutExtension(source.path)),
            );
            return _BatchTask(
              source: source,
              target: target,
              operation: () => fileDecrypt(key, source, target),
            );
          },
        );
      },
      initialValue: <(String, String)>[],
      debugName: 'decryptCommand',
    );

/// Batch wipes or deletes files and directories.
///
/// Parameters:
/// - `pair.$1` ([CleanupEnum]): The cleanup strategy.
/// - `pair.$2` ([List]<[String]>): List of paths to clean.
/// - `pair.$3` ([int]): Number of iterations (only for wipe).
final cleanupCommand =
    Command.createSync<
      (CleanupEnum, List<String>, int),
      List<(String, String)>
    >(
      (pair) {
        final List<(String, String)> deleted = [];
        final List<(String, String)> errors = [];
        if (pair.$1 == CleanupEnum.keep) return deleted;

        final iterations = pair.$3.clamp(1, 3);
        final writeLevel = switch (pair.$1) {
          CleanupEnum.wipehigh => FileWriteLevel.high,
          CleanupEnum.wipemedium => FileWriteLevel.medium,
          _ => FileWriteLevel.low,
        };

        for (var path in pair.$2) {
          final type = FileSystemEntity.typeSync(path);
          try {
            if (type == FileSystemEntityType.file) {
              final file = File(path);

              for (var i = 0; i < iterations; i++) {
                fileOverWrite(file, level: writeLevel, autoDelete: false);
              }
              file.deleteSync();
            } else if (type == FileSystemEntityType.directory) {
              final dir = Directory(path);
              final entities = dir.listSync(recursive: true);
              for (var e in entities) {
                if (e is File) {
                  for (var i = 0; i < iterations; i++) {
                    fileOverWrite(e, level: writeLevel, autoDelete: false);
                  }
                  e.deleteSync();
                }
              }
              dir.deleteSync(recursive: true);
            }
            deleted.add((path, ''));
          } catch (e) {
            errors.add((path, e.toString()));
          }
        }

        if (errors.isNotEmpty) {
          throw CleanupException('Cleanup partially failed.', errors, deleted);
        }
        return deleted;
      },
      initialValue: <(String, String)>[],
      debugName: 'cleanupCommand',
    );
