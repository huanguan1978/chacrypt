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
import 'dart:typed_data';

import 'package:chapose/chapose.dart' hide ME, MD;
import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:path/path.dart' as p;

import '../../../core/constant.dart' show chaFileExtName;
import '../../../thirdparty/ft_textmime.dart';
import '../../../utils/caching.dart';

/// Builds the widget used by MarkdownBody to render image tags.
///
/// Rendering rules:
/// - Local files are rendered directly with [Image.file].
/// - Local `.cha` files are decrypted first and then rendered from memory.
/// - Plain `http` / `https` images are rendered with [Image.network].
/// - Remote `.cha` files are downloaded to a temporary file, decrypted, and
///   then rendered from memory.
/// - The temporary download directory is always removed after the decrypted
///   bytes have been produced, regardless of success or failure.
///
/// Any image loading failure falls back to a visible placeholder widget via
/// the image widget's own `errorBuilder` or the async preview fallback.
Widget markdownImageBuilder(Uri uri, String? title, String? alt) {
  final bool isLocal = uri.scheme.isEmpty || uri.scheme == 'file';

  if (isLocal) {
    final path = uri.toFilePath();

    if (p.extension(path) == chaFileExtName) {
      final baseName = p.withoutExtension(path);
      if (File(path).existsSync() && isImageMimeType(baseName)) {
        return _ChaMarkdownImage(path: path, alt: alt);
      }

      return _MarkdownImageFallback(
        label: alt ?? p.basename(path),
        message: 'Encrypted image is not available.',
      );
    }

    return Image.file(
      File(path),
      semanticLabel: alt,
      errorBuilder: (_, error, _) => _MarkdownImageFallback(
        label: alt ?? p.basename(path),
        message: error.toString(),
      ),
    );
  }

  if (_isHttpImageUri(uri) && _isChaImageUri(uri)) {
    return _RemoteChaMarkdownImage(uri: uri, alt: alt);
  }

  if (_isHttpImageUri(uri)) {
    return Image.network(
      uri.toString(),
      semanticLabel: alt,
      errorBuilder: (_, error, _) => _MarkdownImageFallback(
        label: alt ?? _uriDisplayName(uri),
        message: error.toString(),
      ),
    );
  }

  return Image.file(
    File(uri.toFilePath()),
    semanticLabel: alt,
    // ignore: unnecessary_underscores
    errorBuilder: (_, error, __) => _MarkdownImageFallback(
      label: alt ?? uri.toString(),
      message: error.toString(),
    ),
  );
}

bool _isHttpImageUri(Uri uri) => uri.scheme == 'http' || uri.scheme == 'https';

/// Returns true when the URI path ends with the encrypted image extension.
bool _isChaImageUri(Uri uri) => p.extension(uri.path) == chaFileExtName;

/// Produces a readable display name for a URI when a local filename is not
/// available.
String _uriDisplayName(Uri uri) {
  if (uri.pathSegments.isNotEmpty) {
    return uri.pathSegments.last;
  }
  return uri.toString();
}

/// Renders a local encrypted image file after decrypting it into memory.
class _ChaMarkdownImage extends StatefulWidget {
  const _ChaMarkdownImage({required this.path, this.alt});

  final String path;
  final String? alt;

  @override
  State<_ChaMarkdownImage> createState() => _ChaMarkdownImageState();
}

class _ChaMarkdownImageState extends State<_ChaMarkdownImage> {
  Future<Uint8List>? _imageFuture;

  @override
  void initState() {
    super.initState();
    _imageFuture = _decodeChaImageFile(widget.path);
  }

  Future<Uint8List> _decodeChaImageFile(String path) async {
    final memFile = MemoryFileSystem().file(p.basenameWithoutExtension(path));

    await fileDecrypt(
      deriveKey(sl<Caching>().password.value),
      File(path),
      memFile,
    );
    return memFile.readAsBytesSync();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _imageFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _MarkdownImageLoadingBox();
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return _MarkdownImageFallback(
            label: widget.alt ?? p.basename(widget.path),
            message: snapshot.hasError
                ? snapshot.error.toString()
                : 'Encrypted image is not available.',
          );
        }

        return Image.memory(snapshot.data!, semanticLabel: widget.alt);
      },
    );
  }
}

/// Renders a remote encrypted image by downloading it to a temporary file,
/// decrypting it, handing the bytes to [Image.memory], and finally deleting
/// the temporary directory that held the downloaded file.
class _RemoteChaMarkdownImage extends StatefulWidget {
  const _RemoteChaMarkdownImage({required this.uri, this.alt});

  final Uri uri;
  final String? alt;

  @override
  State<_RemoteChaMarkdownImage> createState() =>
      _RemoteChaMarkdownImageState();
}

class _RemoteChaMarkdownImageState extends State<_RemoteChaMarkdownImage> {
  Future<Uint8List>? _imageFuture;

  @override
  void initState() {
    super.initState();
    _imageFuture = _downloadAndDecodeChaImageFile(widget.uri);
  }

  Future<Uint8List> _downloadAndDecodeChaImageFile(Uri uri) async {
    final tempDir = di<Directory>(instanceName: 'tempDir');
    final tempFile = File(
      p.join(
        tempDir.path,
        '${DateTime.now().microsecondsSinceEpoch}_${p.basename(uri.path.isEmpty ? 'image.cha' : uri.path)}',
      ),
    );

    try {
      await _downloadChaImageToTempFile(uri, tempFile);
      return await _decryptChaImageFile(tempFile);
    } finally {
      // Only the downloaded temporary file is removed; the shared temp
      // directory is managed globally by the application.
      if (tempFile.existsSync()) {
        await tempFile.delete();
      }
    }
  }

  /// Downloads the remote encrypted image into the provided temporary file.
  Future<void> _downloadChaImageToTempFile(Uri uri, File tempFile) async {
    try {
      final client = HttpClient();
      try {
        final request = await client.getUrl(uri);
        final response = await request.close();
        if (response.statusCode < 200 || response.statusCode >= 300) {
          throw HttpException('HTTP ${response.statusCode}', uri: uri);
        }
        await response.pipe(tempFile.openWrite());
      } finally {
        client.close(force: true);
      }
    } catch (_) {
      rethrow;
    }
  }

  /// Decrypts the downloaded encrypted file into in-memory bytes.
  Future<Uint8List> _decryptChaImageFile(File file) async {
    final memFile = MemoryFileSystem().file(
      p.basenameWithoutExtension(file.path),
    );

    await fileDecrypt(deriveKey(sl<Caching>().password.value), file, memFile);
    return memFile.readAsBytesSync();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _imageFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _MarkdownImageLoadingBox();
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return _MarkdownImageFallback(
            label: widget.alt ?? _uriDisplayName(widget.uri),
            message: snapshot.hasError
                ? snapshot.error.toString()
                : 'Encrypted image is not available.',
          );
        }

        return Image.memory(snapshot.data!, semanticLabel: widget.alt);
      },
    );
  }
}

class _MarkdownImageLoadingBox extends StatelessWidget {
  const _MarkdownImageLoadingBox();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 50,
      height: 50,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class _MarkdownImageFallback extends StatelessWidget {
  const _MarkdownImageFallback({required this.label, required this.message});

  final String label;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 96, minHeight: 96),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(
            alpha: .35,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.dividerColor.withValues(alpha: .3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(
              message,
              style: theme.textTheme.bodySmall,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
