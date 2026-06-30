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
import 'package:flutter/foundation.dart' show kDebugMode, PlatformDispatcher;
import 'package:flutter/services.dart' show rootBundle, MethodChannel;
import 'package:flutter_it/flutter_it.dart';

import 'package:logging/logging.dart';
import 'package:basic_logger/basic_logger.dart';
import 'package:mime/mime.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

import 'core/constant.dart' show appName, LangEnum;
import 'core/guard.dart';
import 'guard/guard_impl.dart';
import 'page/home/helper/security_briefing.dart';
import 'page/home/helper/vault_stats_service.dart';
import 'thirdparty/ft_textmime.dart';
import 'thirdparty/unstaged_secret.dart';
import 'utils/locale_helper.dart' show supportLanguage;
import 'utils/logger_stream_controller.dart';
import 'utils/obfuscator.dart';
import 'utils/sysinfo.dart';
import 'utils/caching.dart';
import 'utils/window.dart';
import 'chabox_app.dart';

void main(List<String> args) {
  Logger.root.level = Level.ALL;
  final basicLogger = BasicLogger(appName);
  final logger = basicLogger.logger;

  final outputLogger = OutputLogger(basicLogger.name, selfonly: false);
  final outLogger = basicLogger.attachLogger(
    outputLogger
      ..record = debugPrint
      ..format = (logRec) => '[${logRec.time}] $logRec',
  );

  final devOutputLogger = DevOutputLogger(basicLogger.name, selfonly: true);
  final devLogger = basicLogger.attachLogger(devOutputLogger);

  logger.warning('---main---, basicLogger.');
  // outLogger.warning('---main---, outLogger.');
  // devLogger.warning('---main---, devLogger.');

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    logger.severe('FlutterError', details.exception, details.stack);
  };

  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    logger.severe('UnhandledError', error, stack);
    return true;
  };

  _initCommandIt(logger);
  GetIt.instance.registerSingleton<Logger>(logger);
  GetIt.instance.registerSingleton<Logger>(outLogger, instanceName: 'out');
  GetIt.instance.registerSingleton<Logger>(devLogger, instanceName: 'dev');
  GetIt.instance.registerSingleton<BasicLogger>(basicLogger);

  GetIt.instance.registerSingleton<String>('', instanceName: 'sourcePath');

  if (args.isNotEmpty) {
    final rawPath = args.first;
    if (rawPath.isNotEmpty &&
        (File(rawPath).existsSync() || Directory(rawPath).existsSync())) {
      GetIt.instance.unregister<String>(instanceName: 'sourcePath');
      GetIt.instance.registerSingleton<String>(
        rawPath,
        instanceName: 'sourcePath',
      );
    }
  }

  final langCodes = LangEnum.values.map((e) => e.name);
  final langCode = supportLanguage(langCodes);
  GetIt.instance.registerSingleton<String>(langCode, instanceName: 'langCode');

  WidgetsFlutterBinding.ensureInitialized();
  if (!kDebugMode) {
    NoScreenshot.instance.screenshotOff().then(
      (ok) => basicLogger.error('NoScreenshot, screenshotOff: $ok.'),
    );
  }

  runApp(
    FutureBuilder(
      future: _setupLocator(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          basicLogger.error('runAppError', snapshot.error, snapshot.stackTrace);
          return _runAppError(snapshot.error);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const WindowManagerWidget(
            title: appName,
            init: _initWM,
            child: MyApp(title: appName),
          );
        }
        return const CircularProgressIndicator();
      },
    ),
  );

  // end_main
}

Widget _runAppError(Object? error) {
  return MaterialApp(
    home: Scaffold(body: Center(child: Text('$error'))),
  );
}

void _initCommandIt(Logger logger) {
  // Configure global command_it settings before runApp

  // 1. Global exception handler - called based on ErrorFilter configuration
  Command.globalExceptionHandler = (error, stackTrace) {
    /*
    debugPrint('Command error: ${error.error}');
    debugPrint('Command: ${error.command}');
    debugPrint('Parameter: ${error.paramData}');
    */
    logger.severe(
      'Command.globalExceptionHandler',
      error,
      kDebugMode ? stackTrace : null,
    );

    // In production, send to Sentry
    // Sentry.captureException(error.error, stackTrace: stackTrace);
  };

  // 2. Default error filter - determines error handling strategy
  Command.errorFilterDefault = const GlobalIfNoLocalErrorFilter();

  // 3. Logging handler - log all command executions
  Command.loggingHandler = (commandName, result) {
    if (kDebugMode) {
      logger.finest(
        'Command.loggingHandler, Command executed: ${result.isRunning ? "started" : "completed"}',
      );
      if (result.hasError) {
        logger.severe('Command.loggingHandler, Command error: ${result.error}');
      }
    }
  };

  // 4. Detailed stack traces - strip framework noise (default: true)
  Command.detailedStackTraces = true;

  // 5. Assertions always throw - bypass error filters for assertions (default: true)
  Command.assertionsAlwaysThrow = true;

  // 6. Report all exceptions - ensure all errors reach global handler (for debugging)
  Command.reportAllExceptions = kDebugMode;

  // 7. Report error handler exceptions - if local error handler throws
  Command.reportErrorHandlerExceptionsToGlobalHandler = true;
}

void _initWM() {
  final siRepo = SysinfoRepository(LocalSysinfoProvider());
  Future.wait([siRepo.getDevInfo(), siRepo.getPkgInfo()]).then((values) {
    di.registerSingleton<Map>(values[0], instanceName: 'devInfo');
    di.registerSingleton<Map>(values[1], instanceName: 'pkgInfo');
  });
  di.registerSingleton<bool>(isDesktop(), instanceName: 'isDesktop');
  di.registerSingleton<String>(platformName(), instanceName: 'os');

  doTextMimeInit();
  final mimeMap = <String, String>{};
  if (di.isRegistered<File>(instanceName: 'mimeFile')) {
    final mimeFile = di<File>(instanceName: 'mimeFile');
    if (mimeFile.existsSync() && mimeFile.lengthSync() > 0) {
      final content = mimeFile.readAsStringSync();
      mimeMap.addAll(parseMimeTypes(content));
      if (mimeMap.isNotEmpty) {
        mimeMap.forEach((key, value) => doTextMimeAdd(key, value));
      }
    }
  }
  di.registerSingleton<Map>(mimeMap, instanceName: 'mimeMap');
  di.registerSingleton<MimeTypeResolver>(mimetypeResolver);

  di.registerSingleton<LogStreamController>(.new());

  if (!di.isRegistered<Caching>()) di.registerSingleton<Caching>(.new());
  di.registerSingleton<VaultStatsService>(
    VaultStatsService()
      ..setEnabled(di<Caching>().stats.value)
      ..scan(),
  );

  // Register Guard and Obfuscator singletons
  di.registerSingleton<Guard>(Guard(p: DefProvider(), s: DefStrategy()));
  di.registerSingleton<Obfuscator>(Obfuscator(di<Guard>()));
}

Future<void> _setupLocator() async {
  final results = await Future.wait([
    SharedPreferences.getInstance(),
    rootBundle.loadString('assets/unstaged/secret.b64'),
    getApplicationDocumentsDirectory(),
    getTemporaryDirectory(),
  ]);

  final pref = results[0] as SharedPreferences;
  di.registerSingleton<SharedPreferences>(pref);
  di.registerSingleton<Secret>(Secret(results[1] as String));

  final baseDir = results[2] as Directory;
  final tempDir = results[3] as Directory;
  final appDocDir = Directory(p.join(baseDir.path, appName));
  if (!appDocDir.existsSync()) appDocDir.createSync(recursive: true);
  if (!tempDir.existsSync()) tempDir.createSync(recursive: true);
  di.registerSingleton<Directory>(appDocDir, instanceName: 'docDir');
  di.registerSingleton<Directory>(tempDir, instanceName: 'tempDir');

  final dirName = {
    'noteDir': 'notes',
    'encDir': 'encrypted',
    'decDir': 'decrypted',
    'enaDir': 'archived',
    'deaDir': 'unarchived',
  };

  for (var entry in dirName.entries) {
    var dir = Directory(p.join(p.join(baseDir.path, appName, entry.value)));
    if (!dir.existsSync()) dir.createSync(recursive: true);
    di.registerSingleton<Directory>(dir, instanceName: entry.key);
  }

  final mimeFile = File(p.join(appDocDir.path, 'mime.types'));
  di.registerSingleton<File>(mimeFile, instanceName: 'mimeFile');

  final lang = pref.getString('lang') ?? di<String>(instanceName: 'langCode');
  di.registerSingleton<BriefingService>(
    BriefingService()
      ..logger = di<Logger>()
      ..loadDatabase(lang),
  );

  if (Platform.isMacOS) {
    try {
      const channel = MethodChannel('com.iche2.chabox/launch_params');
      final String? path = await channel.invokeMethod<String>('getSourcePath');
      if (path != null &&
          path.isNotEmpty &&
          (File(path).existsSync() || Directory(path).existsSync())) {
        if (!di.isRegistered<String>(instanceName: 'sourcePath')) {
          di.registerSingleton<String>(path, instanceName: 'sourcePath');
        }
      }
    } catch (e) {
      // Ignore errors in non-macos platforms or failed channel invocations
    }
  }
}
