/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'package:app_lifecycle_protector/app_lifecycle_protector.dart' as alp;
import 'package:chabox/core/applock_types.dart';
import 'package:chabox/page/home/widget/eula/eula_gatekeeper.dart';
import 'package:chabox/utils/biometric_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:flutter_it/flutter_it.dart';
import 'package:basic_message/basic_message.dart';

import 'lifecycle.dart';
import 'core/app_global.dart';
import 'message/provider.dart';
import 'message/definition.dart';
import 'l10n/app_localizations.dart';
import 'utils/locale_helper.dart';
import 'utils/caching.dart';
import 'core/action_initializer.dart';

import 'page/home/home_page.dart';

final alp.ScreenSecure screenSecure = alp.ScreenSecure();

class MyApp extends StatefulWidget with WatchItStatefulWidgetMixin {
  final String title;
  const MyApp({super.key, required this.title});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late alp.AppLifecycleScheduler _appLifecycleScheduler;

  @override
  void initState() {
    super.initState();
    registerActionRoutes();

    final appLockName = GetIt.I<Caching>().applock.value;
    final appLock = AppLock.values.byName(appLockName);
    if (appLock != AppLock.none) {
      screenSecure.setLocked(true);
    } else {
      screenSecure.setLocked(false);
    }

    final autoLockName = GetIt.I<Caching>().autolock.value;
    final autoLock = AutoLock.values.byName(autoLockName);

    final aliveDuration = Duration(seconds: autoLock.s);
    alp.AppLifecycleScheduler.initialize(
      interval: const Duration(seconds: 10),
      event: MyLifecycleEvent(),
      // logger: sl<Logger>(),
    );
    _appLifecycleScheduler = alp.AppLifecycleScheduler.instance
      ..aliveDuration = aliveDuration;
    _appLifecycleScheduler.aliveAtNow();
  }

  @override
  void dispose() {
    _appLifecycleScheduler.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = watchValue((Caching c) => c.lang);
    final theme = watchValue((Caching c) => c.theme);
    final password = watchValue((Caching c) => c.password);
    final appLockName = watchValue((Caching c) => c.applock);
    final appLock = AppLock.values.byName(appLockName);

    final locale = switch (lang) {
      // 'cn' => Locale('zh', 'Hans'),
      'hk' => Locale('zh', 'HK'),
      _ => Locale(lang),
    };

    return Listener(
      onPointerDown: (event) {
        // sl<Logger>().finest('onPointerDown, $event');
        _appLifecycleScheduler.aliveAtNow();
      },
      child: MaterialApp(
        scaffoldMessengerKey: AppGlobal.scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,

        title: widget.title,

        themeMode: switch (theme) {
          'light' => ThemeMode.light,
          'dark' => ThemeMode.dark,
          _ => ThemeMode.system,
        },

        theme: localeTheme(locale, const ColorScheme.light()),
        darkTheme: localeTheme(locale, const ColorScheme.dark()),
        builder: (context, child) {
          ME.init(GuiMessageProvider(context));

          void onUnlocked() {
            screenSecure.setLocked(false);
            _appLifecycleScheduler.aliveAtNow();
            Clipboard.setData(const ClipboardData(text: ''));
          }

          Widget lockWidget;
          final passwordLock = alp.PassphraseLockScreen(
            onValidate: (input, _) =>
                input == password ? null : "Invalid Secret Key",
            onUnlocked: onUnlocked,
          );
          if (appLock == AppLock.biometrics) {
            lockWidget = alp.BiometricLockScreen(
              validator: _BiometricValidatorImpl(),
              fallback: passwordLock,
              onUnlocked: onUnlocked,
            );
          } else {
            lockWidget = passwordLock;
          }

          // NOTE: EulaGatekeeper is intentionally placed inside `home` (via
          // Builder) rather than here in `builder`, because MaterialApp.builder
          // receives a context that sits *above* the Navigator in the widget
          // tree. Widgets that rely on Navigator (e.g. DropdownButton on
          // Android) would throw "Navigator operation requested with a context
          // that does not include a Navigator" if placed here.
          return alp.ScreenProtector(
            screenSecure: screenSecure,
            lockWidget: lockWidget,
            child: child!,
          );
        },

        home: Builder(
          builder: (context) {
            final title = MessageEngine.tr(MD.stHomeIndexHeaderDefaultTitle);
            return EulaGatekeeper(child: HomePage(title: title));
          },
        ),
      ),
    );
  }
}

class _BiometricValidatorImpl implements alp.BiometricValidator {
  @override
  Future<bool> canAuthenticate() => BiometricHelper.canAuthenticate();

  @override
  Future<bool> authenticate({required String localizedReason}) =>
      BiometricHelper.authenticate(localizedReason: localizedReason);
}
