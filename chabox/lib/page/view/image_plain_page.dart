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
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:path/path.dart' as p;

import '../../thirdparty/ft_textmime.dart';
import '../../utils/file_helper.dart';

class ImagePlainViewPage extends StatelessWidget {
  const ImagePlainViewPage(this.mdfile, {super.key});
  final File mdfile;

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
            return SingleChildScrollView(
              child: MarkdownBody(data: snapshot.data ?? ''),
            );
          }
        },
      ),
    );
  }

  Future<String> _loadfile(File file) async {
    final (realName, fileExts) = fileNameWithExts(file.path);
    final isImageFile = isImageMimeType(realName);
    if (!isImageFile) return 'only view image file.';
    if (fileExts.isEmpty) return '![$realName](${file.path})';

    return 'invalid view, ${file.path}.';
  }

  // cls.lastline
}
