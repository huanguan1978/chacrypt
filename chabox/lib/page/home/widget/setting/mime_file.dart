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

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:path/path.dart' as p;

import '../../../../thirdparty/ft_textmime.dart'
    show doTextMimeAdd, parseMimeTypes;
import '../../../../utils/file_helper.dart';
import '../../../../utils/responsive.dart' show SnackBarContext;
import '../../../../message/definition.dart';

class SpecMimeTypes extends StatelessWidget with WatchItMixin {
  const SpecMimeTypes({super.key});

  void _pickFile(BuildContext context) {
    final tooltip = ME.tr(MD.stSettingMimeTooltip);

    openFile().then((xfile) {
      if (xfile != null) {
        final mimetype = xfile.mimeType ?? '';
        if (mimetype.startsWith('text/')) {
          xfile.readAsString().then((contents) {
            final mimemap = parseMimeTypes(contents);
            if (mimemap.isNotEmpty) {
              mimemap.forEach((key, value) => doTextMimeAdd(key, value));
              sl<Map>(instanceName: 'mimeMap').addAll(mimemap);
              sl<File>(instanceName: 'mimeFile')
                ..createSync(recursive: true)
                ..writeAsStringSync(contents);
              if (context.mounted) {
                context.showSnackBar(
                  ME.tr(
                    MD.cdSettingMime,
                    args: {'status': 'success', 'tooltip': tooltip},
                  ),
                );
              }
            } else {
              if (context.mounted) {
                context.showSnackBar(
                  ME.tr(
                    MD.cdSettingMime,
                    args: {'status': 'empty', 'tooltip': tooltip},
                  ),
                );
              }
            }
          });
        } else {
          if (context.mounted) {
            context.showSnackBar(
              ME.tr(
                MD.cdSettingMime,
                args: {'status': 'nottext', 'tooltip': tooltip},
              ),
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tooltip = ME.tr(MD.stSettingMimeTooltip);
    final mimefile = abbreviatePath(
      sl<File>(instanceName: 'mimeFile').path,
      keepFirstSegments: 1,
      keepLastSegments: 2,
    );

    return ListTile(
      title: Text(ME.tr(MD.stHomeDrawerSettingTitle, args: {'title': 'mime'})),
      subtitle: Tooltip(
        message: tooltip,
        child: Text(mimefile, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      leading: IconButton(
        icon: const Icon(Icons.file_open),
        onPressed: () => _pickFile(context),
      ),
      onTap: () {
        final directory = p.dirname(mimefile);
        Clipboard.setData(ClipboardData(text: directory)).then((value) {
          if (!context.mounted) return;
          context.showSnackBar(ME.tr(MD.rsCommonGlobalActionCopied));
        });
      },
    );
  }
}
