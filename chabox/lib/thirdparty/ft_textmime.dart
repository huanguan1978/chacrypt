/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'package:mime/mime.dart' show MimeTypeResolver;

/// Copied from [filetools] (Repo: https://github.com/huanguan1978/ft)
/// Methods: mimetypeResolver, doTextMimeInit, doTextMimeAdd, isTextMimeType, textMimeOverrides, parseMimeTypes
/// Update: Replace the implementation below with latest code from repo.

// --- Implementation ---

/// Global MimeTypeResolver for isTextMimeType, Formatter, mimeIncludes, mimeExcludes
MimeTypeResolver mimetypeResolver = MimeTypeResolver();

/// Initializes the custom text MIME type resolver with predefined mappings.
void doTextMimeInit() =>
    textMimeOverrides.forEach((k, v) => doTextMimeAdd(k, v));

/// Adds a custom text MIME type mapping for a given file extension.
///
/// - [extension]: The file extension (e.g., 'txt', 'csv').
/// - [mimeType]: The corresponding MIME type (e.g., 'text/plain', 'text/csv').
void doTextMimeAdd(String extension, String mimeType) =>
    mimetypeResolver.addExtension(extension, mimeType);

/// Checks if a file is considered a text file based on its MIME type.
///
/// - [path]: The path to the file.
/// - [headerBytes]: Optional header bytes for more accurate MIME type detection.
///
/// Returns `true` if the file's MIME type is recognized as text, `false` otherwise.
///
/// ```dart
/// doTextMimeInit(); // initializes
/// print(isTextMimeType('a.txt')); // true
/// print(isTextMimeType('a.pdf')); // false
/// print(isTextMimeType('a.yml')); // false
/// // add a custom text mimetype， yml|yaml is a config language.
/// doTextMimeAdd('yml', 'text/yaml');
/// print(isTextMimeType('a.yml')); // true
/// ```
bool isTextMimeType(String path, {List<int>? headerBytes}) {
  final mimetype =
      mimetypeResolver.lookup(path, headerBytes: headerBytes) ?? '';
  if (mimetype.isEmpty) return false;
  return mimetype.contains('text/') ||
      mimetype.endsWith('xml') ||
      mimetype.endsWith('json') ||
      mimetype.endsWith('ml');
}

/// Customize text mimetype
///
/// ```dart
/// textMimeOverrides['yml'] = 'application/yaml';
/// doTextMimeInit()
/// print(isTextMimeType('abc.yml')) // true
/// ```
final Map<String, String> textMimeOverrides = <String, String>{
  /*
    val.startwith('text/') from 'package:mime/src/default_extension_map.dart';
    val.endsWith('xml') from 'package:mime/src/default_extension_map.dart';
    val.endsWith('json') from 'package:mime/src/default_extension_map.dart';
  */

  // customize
  'yaml': 'application/yaml',
  'toml': 'application/toml',
  // 'yml': 'application/yaml',
  // 'tml': 'application/toml',
};

/// Parses MIME type definitions from raw text content (e.g., /etc/mime.types).
///
/// Returns a map where keys are file extensions (without dots) and values
/// are their corresponding MIME types.
///
/// Example:
/// ```dart
/// final content = '.log    text/x-log\n.json   application/json';
/// final map = parseMimeTypes(content);
/// // {'log': 'text/x-log', 'json': 'application/json'}
/// ```
Map<String, String> parseMimeTypes(String content) {
  final regexp = RegExp(r'\s+');
  final map = <String, String>{};
  final lines = content.split(RegExp(r'\r?\n'));

  for (var line in lines) {
    line = line.trim();
    if (line.isEmpty || line.startsWith('#')) continue;
    final parts = line.split(regexp);
    if (parts.length >= 2) {
      final ext = parts[0].startsWith('.') ? parts[0].substring(1) : parts[0];
      map[ext] = parts[1];
    }
  }
  return map;
}

bool isImageMimeType(String path, {List<int>? headerBytes}) {
  final mimetype =
      mimetypeResolver.lookup(path, headerBytes: headerBytes) ?? '';
  if (mimetype.isEmpty) return false;
  return mimetype.contains('image/');
}
