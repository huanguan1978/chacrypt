import 'package:chabox/page/list/notes_page.dart';
import 'package:chabox/page/list/vault_page.dart';
import 'package:chabox/core/action_registry.dart';
import 'package:chabox/page/action/layout/archive.dart';
import 'package:chabox/page/action/layout/encrypt.dart';
import 'package:chabox/page/action/layout/decrypt.dart';
import 'package:chabox/page/action/layout/unarchive.dart';
import 'package:chabox/page/action/layout/wipe.dart';
import 'package:chabox/page/edit/text_clipher_page.dart';
import 'package:chabox/page/edit/text_plain_page.dart';
import 'package:chabox/page/view/image_cipher_page.dart';
import 'package:chabox/page/view/image_plain_page.dart';
import 'package:chabox/page/view/text_cipher_page.dart';
import 'package:chabox/page/view/text_plain_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:chabox/utils/obfuscator.dart';
import 'package:chabox/core/metrics.dart';
import 'dart:io';

Widget _secureWrap(Widget child, Object? params) {
  final obfuscator = di<Obfuscator>();
  final path = params is File ? params.absolute.path : 'system_route';

  // Use Obfuscator as a behavioral admission gate
  final result = obfuscator.normalize(path, SystemMetrics.bufferSeed);

  if (result.verify((d) => d != null && d.length >= SystemMetrics.blockAlign)) {
    return child;
  }

  return Scaffold(
    body: Center(
      child: Text("Security Access Denied for: ${path.split('/').last}"),
    ),
  );
}

void registerActionRoutes() {
  ActionRouter.register(
    ActionRoute.archive,
    (context, params) => _secureWrap(const Archive(), params),
  );
  ActionRouter.register(
    ActionRoute.encrypt,
    (context, params) => _secureWrap(const Encrypt(), params),
  );
  ActionRouter.register(
    ActionRoute.decrypt,
    (context, params) => _secureWrap(const Decrypt(), params),
  );
  ActionRouter.register(
    ActionRoute.unarchive,
    (context, params) => _secureWrap(const Unarchive(), params),
  );
  ActionRouter.register(
    ActionRoute.wipe,
    (context, params) => _secureWrap(const Wipe(), params),
  );

  ActionRouter.register(
    ActionRoute.editCipher,
    (context, params) =>
        _secureWrap(TextClipherEditPage(chaFile: params as File?), params),
  );
  ActionRouter.register(
    ActionRoute.editPlain,
    (context, params) =>
        _secureWrap(TextPlainEditPage(txtFile: params as File?), params),
  );
  ActionRouter.register(
    ActionRoute.viewImageCipher,
    (context, params) =>
        _secureWrap(ImageCipherViewPage(params as File), params),
  );
  ActionRouter.register(
    ActionRoute.viewImagePlain,
    (context, params) =>
        _secureWrap(ImagePlainViewPage(params as File), params),
  );
  ActionRouter.register(
    ActionRoute.viewTextCipher,
    (context, params) =>
        _secureWrap(TextCipherViewPage(params as File), params),
  );
  ActionRouter.register(
    ActionRoute.viewTextPlain,
    (context, params) => _secureWrap(TextPlainViewPage(params as File), params),
  );
  ActionRouter.register(
    ActionRoute.notesList,
    (context, params) => _secureWrap(const NoteListPage(), params),
  );
  ActionRouter.register(
    ActionRoute.vaultList,
    (context, params) => _secureWrap(const VaultListPage(), params),
  );
}
