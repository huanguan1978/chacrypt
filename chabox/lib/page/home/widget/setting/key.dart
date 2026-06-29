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

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:file_selector/file_selector.dart';
import 'package:logging/logging.dart';
import 'package:chapose/chapose.dart' hide ME, MD;

import '../../../../core/constant.dart' show ClipDelay;
import '../../../../message/definition.dart';
import '../../../../utils/caching.dart';
import '../../../../utils/clipborad_helper.dart' show SecureClipboardManager;
import '../../../../utils/responsive.dart';
import '../../../../widget/enum_menu_action.dart';
import '../../../../widget/enum_menu_entity.dart';

class SettingKey extends StatefulWidget with WatchItStatefulWidgetMixin {
  const SettingKey({super.key});

  @override
  State<SettingKey> createState() => _SettingKeyState();
}

class _SettingKeyState extends State<SettingKey> {
  final _autocc = sl<Caching>().autocc.value;
  int get _secs => ClipDelay.values.byName(_autocc).s;
  SecureClipboardManager get _clipboardManager => SecureClipboardManager(
    seconds: _secs,
    onCompleted: () =>
        sl<Logger>().finer('SecureClipboard, AutoClean, secs:$_secs'),
  );

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  bool _isObscure = true;

  @override
  void initState() {
    super.initState();

    _controller.text = sl<Caching>().password.value;

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) _clipboardManager.startAutoClear();
    });
    _controller.addListener(() {
      if (_controller.text.isNotEmpty) _clipboardManager.startAutoClear();
    });
  }

  @override
  void dispose() {
    _clipboardManager.dispose();
    _focusNode.dispose();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = sl<bool>(instanceName: 'isDesktop');

    return TextFormField(
      focusNode: _focusNode,
      controller: _controller,
      obscureText: _isObscure,
      decoration: InputDecoration(
        labelText: ME.tr(
          MD.stHomeDrawerSettingTitle,
          args: {'title': 'secret'},
        ),

        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        border: InputBorder.none,
        prefixIcon: MenuAction<MenuEntity>(
          menuType: MenuType.popupMenuButton,
          menuItems: [
            // Load from file
            MenuEntity.pickfile,
            // Load from environment
            MenuEntity.pickenv,
            // Regenerate
            MenuEntity.regen,
            // Save to file
            if (isDesktop) MenuEntity.saveto,
            // Save secret
            MenuEntity.save,
          ],

          localized: (key) =>
              ME.tr(MD.stCommonGlobalPopupActionLabel, args: {'action': key}),
          onSelectedAction: _menuAction,
        ),
        suffixIcon: IconButton(
          icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() => _isObscure = !_isObscure),
        ),
      ),
      validator: (value) {
        final password = value ?? '';
        final (passwordOk, passwordErr) = checkInputPassword(password);
        if (!passwordOk) return passwordErr;

        return null;
      },
    );
  }

  void _menuAction(MenuEntity? entity, Object? param) {
    if (entity == null) return;
    sl<Logger>().info("menu selected: ${entity.name}");

    switch (entity) {
      case MenuEntity.regen: // Regenerate
        sl<Caching>().password.value = generatePassword(
          ChaContant.userKeyDefaultLength,
        );
        context.showSnackBar(
          ME.tr(MD.rsKeyActionSuccess, args: {'action': 'regenerate'}),
        );
        break;

      case MenuEntity.save: // Save secret
        final password = _controller.text;
        final (passwordOk, passwordErr) = checkInputPassword(password);
        if (!passwordOk) {
          context.showSnackBar(
            ME.tr(MD.cdKeyActionFileInvalid, args: {'error': passwordErr}),
          );
        } else {
          sl<Caching>().passwd = password;
          context.showSnackBar(
            ME.tr(MD.rsKeyActionSuccess, args: {'action': 'save'}),
          );
        }
        break;

      case MenuEntity.saveto: // Save to file
        const String fileName = 'chabox.key.txt';
        getSaveLocation(
          suggestedName: fileName,
          initialDirectory: sl<Directory>(instanceName: 'docDir').path,
        ).then((location) {
          if (location != null) {
            try {
              File(
                location.path,
              ).writeAsStringSync(sl<Caching>().password.value);
              if (mounted) {
                context.showSnackBar(
                  ME.tr(
                    MD.rsKeyActionSuccess,
                    args: {'action': 'saveto', 'path': location.path},
                  ),
                );
              }
            } catch (e) {
              if (mounted) {
                context.showSnackBar(
                  ME.tr(MD.rsCommonActionFileError, args: {'error': '$e'}),
                );
              }
            }
          }
        });
        break;

      case MenuEntity.pickfile: // Load from file
        openFile(
          initialDirectory: sl<Directory>(instanceName: 'docDir').path,
        ).then((xfile) {
          if (xfile != null) {
            xfile.readAsString().then((password) {
              final (passwordOk, passwordErr) = checkInputPassword(password);
              if (!passwordOk) {
                if (mounted) {
                  context.showSnackBar(
                    ME.tr(
                      MD.cdKeyActionFileInvalid,
                      args: {'error': passwordErr},
                    ),
                  );
                }
              } else {
                sl<Caching>().password.value = password;
                if (mounted) {
                  context.showSnackBar(
                    ME.tr(MD.rsKeyActionSuccess, args: {'action': 'load'}),
                  );
                }
              }
            });
          }
        });
        break;

      case MenuEntity.pickenv: // Load from environment
        final keyfile = envKeyfile;
        final (keyfileOk, keyfileErr) = checkInputFile(keyfile);
        if (!keyfileOk) {
          context.showSnackBar(
            ME.tr(MD.cdKeyActionFileInvalid, args: {'error': keyfileErr}),
          );
        } else {
          try {
            sl<Caching>().password.value = File(keyfile).readAsStringSync();
            context.showSnackBar(
              ME.tr(
                MD.rsKeyActionSuccess,
                args: {'action': 'loadenv', 'path': keyfile},
              ),
            );
          } catch (e) {
            context.showSnackBar(
              ME.tr(MD.rsCommonActionFileError, args: {'error': '$e'}),
            );
          }
        }
        break;

      default:
        break;
    }
  }
}
