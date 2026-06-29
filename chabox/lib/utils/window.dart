/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'sysinfo.dart' as sysinfo;

class WindowManagerWidget extends StatefulWidget {
  final String title;
  final Widget child;
  final VoidCallback? init;

  const WindowManagerWidget({
    super.key,
    required this.child,
    required this.title,
    this.init,
  });

  @override
  State<WindowManagerWidget> createState() => _WindowManagerWidgetState();
}

class _WindowManagerWidgetState extends State<WindowManagerWidget> {
  @override
  void initState() {
    super.initState();
    _initWM();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _initWM() {
    /*
    final caching = Caching();
    caching.initAsync();
    GetIt.instance.registerSingleton<Caching>(caching);
    */
    if (widget.init != null) widget.init?.call();

    if (sysinfo.isDesktop()) {
      windowManager.ensureInitialized().then((onValue) {
        WindowOptions windowOptions = WindowOptions(
          title: widget.title,
          windowButtonVisibility: false,
          minimumSize: Size(768, 576),
          maximumSize: Size(1280, 720),
          size: Size(1024, 768),
          center: true,
          backgroundColor: Colors.transparent,
        );

        windowManager.waitUntilReadyToShow(windowOptions, () async {
          await windowManager.show();
          await windowManager.focus();
        });
      });
    }
  }
}
