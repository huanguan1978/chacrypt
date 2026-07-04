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
import 'package:path/path.dart' as p;

/// Specialized file categories for UI display.
enum FileSpecCate {
  archive,
  pdf,
  security,
  spreadsheet,
  presentation,
  document,
  code,
  ebook,
  none,
}

/// Detects the specialized category of a file based on its name and MIME type.
FileSpecCate getFileSpecCate(String fileName, String mimeType) {
  final lowerName = fileName.toLowerCase();
  final extension = lowerName.split('.').last;
  final lowerMime = mimeType.toLowerCase();

  // 1. Archive & Compressed
  const archiveExtensions = {
    'zip',
    '7z',
    'rar',
    'tar',
    'gz',
    'tgz',
    'xz',
    'bz2',
    'lz',
    'lzma',
    'apk',
    'iso',
    'cab',
    'deb',
    'rpm',
    'dmg',
  };
  if (archiveExtensions.contains(extension)) return FileSpecCate.archive;
  if (lowerMime.contains('zip') ||
      lowerMime.contains('compressed') ||
      lowerMime.contains('tar') ||
      lowerMime.contains('archive') ||
      [
        'application/x-gzip',
        'application/x-xz',
        'application/x-bzip2',
      ].contains(lowerMime)) {
    return FileSpecCate.archive;
  }

  // 2. PDF
  if (extension == 'pdf' || lowerMime == 'application/pdf') {
    return FileSpecCate.pdf;
  }

  // 3. Security (Keys, Certificates, GPG)
  const securityExtensions = {
    'key',
    'pem',
    'pub',
    'asc',
    'gpg',
    'ssh',
    'crt',
    'cer',
    'p12',
    'pfx',
    'der',
  };
  if (securityExtensions.contains(extension)) return FileSpecCate.security;
  if (lowerMime.contains('pkcs') ||
      lowerMime.contains('x509') ||
      lowerMime.contains('pgp')) {
    return FileSpecCate.security;
  }

  // 4. Spreadsheets
  const spreadsheetExtensions = {'xlsx', 'xls', 'xlsm', 'csv', 'tsv', 'ods'};
  if (spreadsheetExtensions.contains(extension)) {
    return FileSpecCate.spreadsheet;
  }
  if (lowerMime.contains('spreadsheet') ||
      lowerMime.contains('excel') ||
      lowerMime == 'text/csv') {
    return FileSpecCate.spreadsheet;
  }

  // 5. Presentations
  const presentationExtensions = {'pptx', 'ppt', 'ppsx', 'odp', 'key'};
  if (presentationExtensions.contains(extension)) {
    return FileSpecCate.presentation;
  }
  if (lowerMime.contains('presentation') || lowerMime.contains('powerpoint')) {
    return FileSpecCate.presentation;
  }

  // 6. Documents (Word processing)
  const documentExtensions = {'docx', 'doc', 'odt', 'rtf', 'pages'};
  if (documentExtensions.contains(extension)) return FileSpecCate.document;
  if (lowerMime.contains('word') ||
      lowerMime.contains('officedocument.wordprocessingml')) {
    return FileSpecCate.document;
  }

  // 7. Code & Configuration
  const codeExtensions = {
    'json',
    'yaml',
    'yml',
    'xml',
    'toml',
    'sql',
    'md',
    'html',
    'css',
    'js',
    'ts',
    'py',
    'java',
    'c',
    'cpp',
    'h',
    'go',
    'rs',
    'sh',
    'bat',
  };
  if (codeExtensions.contains(extension)) return FileSpecCate.code;
  if (lowerMime.contains('javascript') ||
      lowerMime.contains('json') ||
      lowerMime.contains('xml') ||
      lowerMime.startsWith('text/x-')) {
    return FileSpecCate.code;
  }

  // 8. Ebooks
  const ebookExtensions = {'epub', 'mobi', 'azw3', 'kfx', 'fb2'};
  if (ebookExtensions.contains(extension)) return FileSpecCate.ebook;
  if (lowerMime.contains('epub') || lowerMime.contains('amazon.mobi')) {
    return FileSpecCate.ebook;
  }

  return FileSpecCate.none;
}

/// Extracts the base filename (first two segments) and the remaining extensions from a path.
///
/// Example: For a path like 'file.tar.gz.cha', it returns ('file.tar', ['gz', 'cha']).
(String, List<String>) fileNameWithExts(String path) {
  final baseName = p.basename(path);
  final fileParts = baseName.split('.');
  final fileName = fileParts.removeAt(0);
  final extName = fileParts.removeAt(0);
  final realName = '$fileName.$extName';
  return (realName, fileParts);
}

/// Removes the last line from the given [content], handling both CRLF and LF.
String removeLastLine(String content) {
  if (content.isEmpty) return content;
  List<String> lines = content.trimRight().split(RegExp(r'\r?\n'));
  if (lines.isNotEmpty) lines.removeLast();
  return lines.join('\n');
}

/// Abbreviates a long path for display by keeping the first and last
/// segments and replacing the middle with an ellipsis.
///
/// Example:
///   /Users/me/Library/Containers/.../Documents
String abbreviatePath(
  String path, {
  int keepFirstSegments = 1,
  int keepLastSegments = 2,
  String ellipsis = '...',
}) {
  if (path.isEmpty) return path;

  final normalizedPath = p.normalize(path);
  final segments = p.split(normalizedPath);
  if (segments.length <= keepFirstSegments + keepLastSegments + 1) {
    return normalizedPath;
  }

  final left = segments.take(keepFirstSegments).toList();
  final right = segments.skip(segments.length - keepLastSegments).toList();
  return p.joinAll([...left, ellipsis, ...right]);
}

/// Returns true if [child] is the same as [parent] or located within [parent].
///
/// Unlike the standard [p.isWithin], this check is inclusive, meaning it
/// returns true if the paths are identical.
bool isWithinPath(String parent, String child) {
  return p.equals(parent, child) || p.isWithin(parent, child);
}

/// Safely converts a [Uri] to a platform file system path.
///
/// This function:
/// - Attempts robust conversions in a small number of steps and returns as
///   soon as a reasonable path is obtained.
/// - First tries `path.fromUri` for standard file:// URIs.
/// - Then tries `uri.toFilePath(...)` with a platform hint.
/// - If the URI looks like a drive-letter-as-scheme (e.g. `e:/...`) it treats
///   the scheme as a Windows drive letter and constructs a path accordingly.
/// - As a final fallback it uses the URI string, normalizes separators for
///   the current platform, strips `file://` prefix when present, and returns
///   a normalized path.
///
/// The function never throws; it always returns a normalized non-empty string.
String safeFilePath(Uri u) {
  final bool isWindows = Platform.isWindows;

  // Use decoded textual form early to handle percent-encoded path parts like "%5C"
  // but avoid altering scheme separators — decodeFull is acceptable here because
  // we're only interested in file-path text that may have been percent-encoded.
  final String rawDecoded = Uri.decodeFull(u.toString());

  // ignore: no_leading_underscores_for_local_identifiers
  String _norm(String? s) {
    if (s == null || s.isEmpty) return '';
    return p.normalize(s);
  }

  // 0) Quick textual sanitization: strip file:// and normalize separators once.
  String sanitized = rawDecoded;
  if (sanitized.startsWith('file://')) {
    sanitized = sanitized.replaceFirst(RegExp(r'^file:///*'), '');
  }

  // Normalize separators according to platform when obvious mismatch exists.
  if (isWindows) {
    if (sanitized.contains('/') && !sanitized.contains(r'\')) {
      sanitized = sanitized.replaceAll('/', Platform.pathSeparator);
    }
  } else {
    if (sanitized.contains(r'\') && !sanitized.contains('/')) {
      sanitized = sanitized.replaceAll(r'\', Platform.pathSeparator);
    }
  }

  // If sanitized already looks like an absolute path for the current platform,
  // return it immediately.
  if (sanitized.isNotEmpty) {
    if (isWindows) {
      if (RegExp(r'^[A-Za-z]:[\\/]').hasMatch(sanitized) ||
          sanitized.startsWith(r'\\')) {
        return _norm(sanitized);
      }
    } else {
      if (sanitized.startsWith('/')) return _norm(sanitized);
    }
  }

  // 1) Prefer path.fromUri for standard file:// URIs (may throw on exotic URIs).
  try {
    final fromPath = p.fromUri(u);
    final n = _norm(fromPath);
    if (n.isNotEmpty) return n;
  } catch (_) {}

  // 2) Try Uri.toFilePath with platform hint.
  try {
    final fp = u.toFilePath(windows: isWindows);
    final n = _norm(fp);
    if (n.isNotEmpty) return n;
  } catch (_) {}

  // 3) Handle drive-letter-as-scheme like "e:/..." where scheme == 'e'
  if (u.scheme.length == 1 && RegExp(r'^[A-Za-z]$').hasMatch(u.scheme)) {
    var candidate = '${u.scheme}:${u.path}';
    if (isWindows) {
      candidate = candidate.replaceAll('/', Platform.pathSeparator);
    }
    final n = _norm(candidate);
    if (n.isNotEmpty) return n;
  }

  // 4) Final fallback: return normalized sanitized text or rawDecoded.
  final finalNorm = _norm(sanitized);
  if (finalNorm.isNotEmpty) return finalNorm;

  return _norm(rawDecoded);
}
