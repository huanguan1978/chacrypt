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

/// Copied from [patching] (Repo: https://github.com/huanguan1978/patching)
/// Methods: compressFile, decompressFile.
/// Update: Replace the implementation below with latest code from repo.

// --- Implementation ---

/// Compresses [source] file to [target] using [zLibEncoder].
///
/// Returns [target] on success. If [onSuccess] is provided, it's executed upon success.
/// If an error occurs:
/// - If [onError] is provided, it handles the error and returns null.
/// - If [onError] is null, the error is routed to the current zone's uncaught error handler.
Future<File?> compressFile(
  File source,
  File target, {
  Function(File)? onSuccess,
  Function(Object, StackTrace)? onError,
  ZLibEncoder? zLibEncoder,
}) async {
  try {
    await source
        .openRead()
        .transform(zLibEncoder ?? gzip.encoder)
        .pipe(target.openWrite());

    onSuccess?.call(target);
    return target;
  } catch (e, stack) {
    if (onError != null) {
      onError(e, stack);
      // If onError is provided, we treat the error as handled
      // and return null to indicate failure without crashing.
      return null;
    } else {
      // No handler provided: escalate to the current zone.
      Zone.current.handleUncaughtError(e, stack);
      return null;
    }
  }
}

/// Decompresses [source] file to [target] using [zLibDecoder].
///
/// Returns [target] on success. If [onSuccess] is provided, it's executed upon success.
/// If an error occurs:
/// - If [onError] is provided, it handles the error and returns null.
/// - If [onError] is null, the error is routed to the current zone's uncaught error handler.
Future<File?> decompressFile(
  File source,
  File target, {
  Function(File)? onSuccess,
  Function(Object, StackTrace)? onError,
  ZLibDecoder? zLibDecoder,
}) async {
  try {
    await source
        .openRead()
        .transform(zLibDecoder ?? gzip.decoder)
        .pipe(target.openWrite());

    onSuccess?.call(target);
    return target;
  } catch (e, stack) {
    if (onError != null) {
      onError(e, stack);
      return null;
    } else {
      // Escalates to the current zone if no handler is provided
      Zone.current.handleUncaughtError(e, stack);
      return null;
    }
  }
}
