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
import 'package:flutter/material.dart';
import 'package:logging/logging.dart' show Level;
import '../message/definition.dart';
import 'enum_menu_action.dart';

class LogStreamView<T> extends StatefulWidget {
  final Stream<(Level, String)> logStream;
  final List<T> menuItems;
  final Function(T, (Level, String)) onMenuSelected;
  final bool autoScroll;
  final double? height;
  final double? maxHeight;

  const LogStreamView({
    super.key,
    required this.logStream,
    required this.menuItems,
    required this.onMenuSelected,
    this.autoScroll = true,
    this.height,
    this.maxHeight,
  });

  @override
  State<LogStreamView<T>> createState() => _LogStreamViewState<T>();
}

class _LogStreamViewState<T> extends State<LogStreamView<T>> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<(Level, String)>(
      stream: widget.logStream,
      builder: (context, snapshot) {
        final curlog = snapshot.data ?? (Level.FINEST, '');
        final curlogtxt = curlog.$2;

        if (widget.autoScroll) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => _scrollToBottom(),
          );
        }

        final child = Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              child: SelectableText(curlogtxt),
            ),

            Visibility(
              visible: curlogtxt.isNotEmpty,
              child: Align(
                alignment: Alignment.topRight,
                child: MenuAction<T>(
                  menuItems: widget.menuItems,
                  menuType: MenuType.popupMenuButton,
                  localized: (key) => ME.tr(
                    MD.stCommonGlobalPopupActionLabel,
                    args: {'action': key},
                  ),
                  onSelectedAction: (val, _) {
                    if (val != null) widget.onMenuSelected(val, curlog);
                  },
                ),
              ),
            ),
          ],
        );

        if (widget.height != null) {
          return SizedBox(height: widget.height, child: child);
        } else if (widget.maxHeight != null) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: widget.maxHeight!),
            child: child,
          );
        }
        return child;
      },
    );
  }
}
