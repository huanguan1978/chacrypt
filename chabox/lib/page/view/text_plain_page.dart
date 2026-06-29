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

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import 'package:path/path.dart' as p;
import 'package:file/memory.dart';

import '../../thirdparty/ft_textmime.dart';
import '../../thirdparty/patching_tmpl.dart';
import '../../thirdparty/patching_zlib.dart';
import '../../utils/caching.dart';
import '../../utils/file_helper.dart';
import 'widget/markdown_image_builder.dart';

class TextPlainViewPage extends StatelessWidget {
  const TextPlainViewPage(this.mdfile, {super.key, this.bottomAction});
  final File mdfile;
  final Widget? bottomAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(p.basename(mdfile.path))),
      body: FutureBuilder(
        future: _loadfile(mdfile),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            var text = snapshot.data ?? '';
            final pattern = RegExp(r'\{\{([a-zA-Z_]\w*)}}');
            // Apply template variable substitution before preview
            if (text.isNotEmpty && text.contains(pattern)) {
              final variables = _loadAllVariables();
              text = Tmpl(variables).tmpl(text);
            }

            return SingleChildScrollView(
              child: MarkdownBody(
                data: text,
                imageBuilder: markdownImageBuilder,
              ),
            );
          }
        },
      ),
      persistentFooterButtons: bottomAction != null ? [bottomAction!] : null,
    );
  }

  /// Builds the merged variable map for template rendering.
  /// System path variables are converted to POSIX format (forward slash).
  /// User-defined variables from [Caching.textvars] are merged in;
  /// system variables take priority and cannot be overridden.
  Map<String, String> _loadAllVariables() {
    final caching = sl<Caching>();
    String toPosix(String path) => path.replaceAll(r'\', '/');

    // Start with user-defined variables.
    final variables = Map<String, String>.from(caching.textvars.value);

    // System read-only variables always take priority.
    variables.addAll({
      'noteDir': toPosix(caching.noteDir.path),
      'encDir': toPosix(caching.encDir.path),
      'decDir': toPosix(caching.decDir.path),
      'enaDir': toPosix(caching.enaDir.path),
      'deaDir': toPosix(caching.deaDir.path),
    });

    return variables;
  }

  Future<String> _loadfile(File file) async {
    final (realName, fileExts) = fileNameWithExts(file.path);
    final isTextFile = isTextMimeType(realName);
    if (!isTextFile) return 'only view text file.';
    if (fileExts.isEmpty) return file.readAsString();

    final nextExt = fileExts.removeAt(0);
    if (fileExts.isEmpty && (nextExt.toLowerCase() == 'gz')) {
      final memFile = MemoryFileSystem().file(
        p.basenameWithoutExtension(file.path),
      );

      await decompressFile(file, memFile, onError: (e, _) => throw e);
      return memFile.readAsString();
    }

    return 'invalid view, ${file.path}.';
  }

  // cls.lastline
}
