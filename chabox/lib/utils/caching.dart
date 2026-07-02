/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'dart:convert';
import 'dart:io';

import 'package:basic_logger/basic_logger.dart';
import 'package:flutter/foundation.dart' show ValueNotifier;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_it/flutter_it.dart';

import 'package:chapose/chapose.dart' show ChaContant, generatePassword;
import 'package:chabox/thirdparty/unstaged_secret.dart';

class Caching {
  /// Directory for Secure Notes (.md.cha) - UI Label: 'Notes'
  var noteDir = GetIt.I<Directory>(instanceName: 'noteDir');

  /// Directory for Encrypted Vault files (.cha) - UI Label: 'Encrypt'
  var encDir = GetIt.I<Directory>(instanceName: 'encDir');

  /// Directory for Decrypted plaintext results - UI Label: 'Decrypt'
  var decDir = GetIt.I<Directory>(instanceName: 'decDir');

  /// Directory for Archived packages (.tgz) - UI Label: 'Archive'
  var enaDir = GetIt.I<Directory>(instanceName: 'enaDir');

  /// Directory for Unarchived/Extracted content - UI Label: 'Unarchive'
  var deaDir = GetIt.I<Directory>(instanceName: 'deaDir');

  /// system locale languageCode
  var langCode = GetIt.I<String>(instanceName: 'langCode');

  /// App is kDebugMode ?
  var kDebugMode = GetIt.I<bool>(instanceName: 'kDebugMode');

  final prefs = GetIt.I<SharedPreferences>();
  final secret = GetIt.I<Secret>();
  final logger = GetIt.I<BasicLogger>();

  // Immediately Invoked Function Expression, IIFE
  late final ValueNotifier<String> password = () {
    final rawValue = prefs.getString('secret');
    final curValue = (rawValue != null && rawValue.isNotEmpty)
        ? ValueNotifier(secret.desixteen(rawValue))
        : ValueNotifier(generatePassword(ChaContant.userKeyDefaultLength));
    if (rawValue == null || rawValue.isEmpty) {
      prefs.setString('secret', secret.ensixteen(curValue.value)).then((ok) {
        if (kDebugMode) {
          logger.warning(
            'ValueNotifier, init password.value: ${curValue.value}',
          );
        }
      });
    }

    if (kDebugMode) {
      logger.warning('ValueNotifier, curr password.value: ${curValue.value}');
    }

    return curValue;
  }();

  set password(String password) => this.password.value = password;
  set passwd(String password) => prefs
      .setString('secret', secret.ensixteen(password))
      .then((value) => value ? this.password.value = password : null);

  // required local auth type for app launcher?
  late final applock = ValueNotifier(prefs.getString('applock') ?? 'none');
  set applock(String lock) => prefs
      .setString('applock', lock)
      .then((value) => value ? applock.value = lock : null);

  // Auto Lock Screen Delay
  late final autolock = ValueNotifier(prefs.getString('autolock') ?? 'm1');
  set autolock(String delay) => prefs
      .setString('autolock', delay)
      .then((value) => value ? autolock.value = delay : null);

  // Auto Clipboard Clear Delay
  late final autocc = ValueNotifier(prefs.getString('autocc') ?? 's10');
  set autocc(String delay) => prefs
      .setString('autocc', delay)
      .then((value) => value ? autolock.value = delay : null);

  late final lang = ValueNotifier(prefs.getString('lang') ?? langCode);
  set lang(String languageCode) => prefs
      .setString('lang', languageCode)
      .then((value) => value ? lang.value = languageCode : null);

  late final theme = ValueNotifier(prefs.getString('theme') ?? 'system');
  set theme(String themeModeName) => prefs
      .setString('theme', themeModeName)
      .then((value) => value ? theme.value = themeModeName : null);

  // change note autosave secs.
  late final autosave = ValueNotifier(prefs.getInt('autosave') ?? 0);
  set autosave(int secs) => prefs
      .setInt('autosave', secs)
      .then((value) => value ? autosave.value = secs : null);

  // secret notes to directory
  late final ValueNotifier<String> notepath = () {
    final rawValue = prefs.getString('notepath') ?? noteDir.path;
    noteDir = Directory(rawValue);
    return ValueNotifier(rawValue);
  }();
  set notepath(String abspath) =>
      prefs.setString('notepath', abspath).then((value) {
        noteDir = Directory(abspath);
        return value ? notepath.value = abspath : null;
      });

  // encrypt to directory
  late final ValueNotifier<String> encpath = () {
    final rawValue = prefs.getString('encpath') ?? encDir.path;
    encDir = Directory(rawValue);
    return ValueNotifier(rawValue);
  }();
  set encpath(String abspath) =>
      prefs.setString('encpath', abspath).then((value) {
        encDir = Directory(abspath);
        return value ? encpath.value = abspath : null;
      });

  // decrypt to directory
  late final ValueNotifier<String> decpath = () {
    final rawValue = prefs.getString('decpath') ?? decDir.path;
    decDir = Directory(rawValue);
    return ValueNotifier(rawValue);
  }();
  set decpath(String abspath) =>
      prefs.setString('decpath', abspath).then((value) {
        decDir = Directory(abspath);
        return value ? decpath.value = abspath : null;
      });

  // archive to directory
  late final ValueNotifier<String> enapath = () {
    final rawValue = prefs.getString('enapath') ?? enaDir.path;
    enaDir = Directory(rawValue);
    return ValueNotifier(rawValue);
  }();
  set enapath(String abspath) =>
      prefs.setString('enapath', abspath).then((value) {
        enaDir = Directory(abspath);
        return value ? enapath.value = abspath : null;
      });

  // uarchive to directory
  late final ValueNotifier<String> deapath = () {
    final rawValue = prefs.getString('deapath') ?? deaDir.path;
    deaDir = Directory(rawValue);
    return ValueNotifier(rawValue);
  }();
  set deapath(String abspath) =>
      prefs.setString('deapath', abspath).then((value) {
        deaDir = Directory(abspath);
        return value ? deapath.value = abspath : null;
      });

  // source cleanup, keep, delete, wipe
  late final cleanup = ValueNotifier(prefs.getString('cleanup') ?? 'keep');
  set cleanup(String clean) => prefs
      .setString('cleanup', clean)
      .then((value) => value ? cleanup.value = clean : null);

  // same target overwrite?
  late final overwrited = ValueNotifier(prefs.getBool('overwrited') ?? true);
  set overwrited(bool isOverwrited) => prefs
      .setBool('overwrited', isOverwrited)
      .then((value) => value ? overwrited.value = isOverwrited : null);

  // eula accepted?
  late final eula = ValueNotifier(prefs.getBool('eula') ?? false);
  set eula(bool isAccepted) => prefs
      .setBool('eula', isAccepted)
      .then((value) => value ? eula.value = isAccepted : null);

  // show vault stats?
  late final stats = ValueNotifier(prefs.getBool('stats') ?? true);
  set stats(bool isShow) => prefs
      .setBool('stats', isShow)
      .then((value) => value ? stats.value = isShow : null);

  /// Signal to notify that the briefing database has been updated
  /// (e.g., after a language change or manual refresh).
  final briefingUpdated = ValueNotifier(0);

  /// User-defined template variables, stored as JSON (Map\<String,String>) in SharedPreferences.
  /// Values intended as paths must use POSIX separators (forward slash `/`).
  late final ValueNotifier<Map<String, String>> textvars = () {
    final raw = prefs.getString('textvars');
    Map<String, String> initial = {};
    if (raw != null) {
      try {
        final decoded = jsonDecode(raw) as Map<String, dynamic>;
        initial = decoded.map((k, v) => MapEntry(k, v.toString()));
      } catch (_) {}
    }
    return ValueNotifier(initial);
  }();

  set textvars(Map<String, String> vars) =>
      prefs.setString('textvars', jsonEncode(vars)).then((success) {
        if (success) textvars.value = vars;
      });

  // cls_lastline
}
