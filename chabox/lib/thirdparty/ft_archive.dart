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
import 'package:path/path.dart' as p;
import 'package:tar/tar.dart';

/// Copied from [filetools] (Repo: https://github.com/huanguan1978/ft)
/// Methods: ArchiveOptions, UnArchiveOptions, TarHelper
/// Update: Replace the implementation below with latest code from repo.

// --- Implementation ---

/// Options for the archive operation.
class ArchiveOptions {
  final List<FileSystemEntity> entities;
  final String basePath;
  final File outputFile;
  final bool useGzip;
  final StringBuffer? logBuffer;
  final void Function()? onSuccess;
  final void Function(Object, StackTrace?)? onError;
  final StreamController<TarEntry>? controller;
  final bool autoFillEntities;

  ArchiveOptions({
    required this.entities,
    required this.basePath,
    required this.outputFile,
    this.useGzip = true,
    this.logBuffer,
    this.onSuccess,
    this.onError,
    this.controller,
    this.autoFillEntities = true,
  });
}

/// Options for the unarchive operation.
class UnArchiveOptions {
  final File file;
  final Directory targetDir;
  final StringBuffer? logBuffer;
  final void Function()? onSuccess;
  final void Function(Object, StackTrace?)? onError;
  final void Function(File extractedFile)? onFileExtracted;

  UnArchiveOptions({
    required this.file,
    required this.targetDir,
    this.logBuffer,
    this.onSuccess,
    this.onError,
    this.onFileExtracted,
  });
}

/// tar archive | unarchive helper
class TarHelper {
  static void _log(StringBuffer? buffer, String message) {
    buffer?.writeln(message);
  }

  /// Archives entities into a tar file with trace logging.
  ///
  /// Use [ArchiveOptions] to configure the operation.
  static void archive(ArchiveOptions options) {
    _log(options.logBuffer, '--- Archive Started at ${DateTime.now()} ---');
    _log(options.logBuffer, 'Base path: ${options.basePath}');

    final isExternalController = options.controller != null;
    final tarController =
        options.controller ?? StreamController<TarEntry>(sync: true);
    final outputSink = options.outputFile.openWrite();

    final archiveStream = options.useGzip
        ? tarController.stream.transform(tarWriter).transform(gzip.encoder)
        : tarController.stream.transform(tarWriter);

    archiveStream
        .pipe(outputSink)
        .then((_) {
          _log(options.logBuffer, '--- Archive Successfully Completed ---');
          options.onSuccess?.call();
        })
        .catchError((e, st) {
          _log(options.logBuffer, '!!! Archive Error: $e');
          if (!isExternalController) {
            tarController.close();
          }
          outputSink.close();
          options.onError?.call(e, st);
        });

    // Only auto-fill if controller is internal and autoFillEntities is true
    if (!isExternalController && options.autoFillEntities) {
      _fillController(
        options.entities,
        options.basePath,
        tarController,
        options.logBuffer,
      );
    }
  }

  static void _fillController(
    List<FileSystemEntity> entities,
    String basePath,
    StreamController<TarEntry> controller,
    StringBuffer? logBuffer,
  ) {
    try {
      for (final entity in entities) {
        if (!entity.existsSync()) {
          logBuffer?.writeln('Warning: Path not found: ${entity.path}');
          continue;
        }

        if (entity is File) {
          addFileToTarEntry(entity, basePath, controller, logBuffer);
        } else if (entity is Directory) {
          final files = entity.listSync(recursive: true, followLinks: false);
          for (final file in files) {
            if (file is File) {
              addFileToTarEntry(file, basePath, controller, logBuffer);
            }
          }
        }
      }
      controller.close();
    } catch (e, s) {
      logBuffer?.writeln('Critical error during scan: $e');
      controller.addError(e, s);
      controller.close();
    }
  }

  /// Adds a single file to the tar archive controller.
  ///
  /// This method can be called externally to dynamically add files to an archive
  /// when using an external [StreamController<TarEntry>].
  ///
  /// Parameters:
  /// - [file]: The file to add to the archive.
  /// - [basePath]: The base path for computing relative paths.
  /// - [controller]: The tar entry stream controller.
  /// - [logBuffer]: Optional buffer for logging.
  static void addFileToTarEntry(
    File file,
    String basePath,
    StreamController<TarEntry> controller,
    StringBuffer? logBuffer,
  ) {
    final relativePath = p.relative(file.path, from: basePath);
    logBuffer?.writeln('Adding: $relativePath');

    controller.add(
      TarEntry(
        TarHeader(
          name: relativePath,
          size: file.lengthSync(),
          mode: int.parse('644', radix: 8),
        ),
        file.openRead(),
      ),
    );
  }

  /// Adds all files from a directory to the tar archive controller.
  ///
  /// This method recursively adds all files from the specified directory
  /// to the archive. It can be called externally for dynamic archive building.
  ///
  /// Parameters:
  /// - [directory]: The directory to add to the archive.
  /// - [basePath]: The base path for computing relative paths.
  /// - [controller]: The tar entry stream controller.
  /// - [logBuffer]: Optional buffer for logging.
  /// - [recursive]: If true (default), recursively adds files from subdirectories.
  static void addDirectoryToTarEntry(
    Directory directory,
    String basePath,
    StreamController<TarEntry> controller,
    StringBuffer? logBuffer, {
    bool recursive = true,
  }) {
    try {
      final files = directory.listSync(
        recursive: recursive,
        followLinks: false,
      );
      for (final file in files) {
        if (file is File) {
          addFileToTarEntry(file, basePath, controller, logBuffer);
        }
      }
    } catch (e) {
      logBuffer?.writeln('Error scanning directory ${directory.path}: $e');
    }
  }

  /// Unarchives [file] to [targetDir].
  /// Symmetric to [archive] method.
  static void unArchive(UnArchiveOptions options) {
    _log(
      options.logBuffer,
      '--- Unarchive Started: ${p.basename(options.file.path)} ---',
    );

    final extName = p.extension(options.file.path);
    final isCompressed =
        extName.endsWith('.gz') ||
        extName.endsWith('.tgz') ||
        extName.endsWith('.tar.gz');

    final inputStream = options.file.openRead();
    final input = isCompressed
        ? inputStream.transform(gzip.decoder)
        : inputStream;

    TarReader.forEach(input, (tarEntry) async {
          final location = p.normalize(
            p.join(options.targetDir.path, tarEntry.name),
          );

          if (!p.isWithin(options.targetDir.path, location)) {
            _log(
              options.logBuffer,
              'Warning: Skipping insecure entry: ${tarEntry.name}',
            );
            return;
          }

          if (tarEntry.type == TypeFlag.dir) {
            _log(options.logBuffer, 'Creating dir: ${tarEntry.name}');
            Directory(location).createSync(recursive: true);
            return;
          }

          if (tarEntry.type == TypeFlag.reg) {
            final targetFile = File(location);
            targetFile.parent.createSync(recursive: true);
            _log(options.logBuffer, 'Extracting file: ${tarEntry.name}');
            try {
              await tarEntry.contents.pipe(targetFile.openWrite());
              options.onFileExtracted?.call(targetFile);
            } catch (e) {
              _log(options.logBuffer, 'Pipe failed for ${tarEntry.name}: $e');
              rethrow;
            }
          }
        })
        .then((_) {
          _log(options.logBuffer, '--- Unarchive Completed Successfully ---');
          options.onSuccess?.call();
        })
        .catchError((e, st) {
          _log(options.logBuffer, '!!! Unarchive Failed: $e');
          options.onError?.call(e, st);
        });
  }

  // cls.lastline
}
