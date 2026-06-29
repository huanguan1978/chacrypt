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
import 'package:flutter_it/flutter_it.dart';

import '../../core/constant.dart';
import '../../message/definition.dart';
import '../../utils/caching.dart';

import '../../utils/responsive.dart' show NavigationContext;
import '../../widget/enum_button_entity.dart';
import '../../widget/enum_menu_action.dart';
import '../../widget/enum_menu_entity.dart';
import 'file_list_widget.dart';
import '../edit/text_clipher_page.dart';
import 'action_common.dart';

class NoteListPage extends StatefulWidget with WatchItStatefulWidgetMixin {
  const NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  final GlobalKey<FileListViewState> _fileListKey =
      GlobalKey<FileListViewState>();

  @override
  Widget build(BuildContext context) {
    final isDesktop = sl<bool>(instanceName: 'isDesktop');
    final os = sl<String>(instanceName: 'os');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        elevation: 1,
        actions: <Widget>[
          IconButton(
            onPressed: () => context.push(TextClipherEditPage()),
            icon: ButtonEntity.new_.getIcon(),
            tooltip: ME.tr(
              MD.stCommonGlobalButtonActionLabel,
              args: {'action': ButtonEntity.new_.toString()},
            ),
          ),
        ],
      ),
      body: FileListView(
        key: _fileListKey,
        directory: sl<Caching>().noteDir,
        pattern: "**$chaNoteExtName",
        trailingMenuAction: (context, file) => MenuAction<MenuEntity>(
          menuType: MenuType.popupMenuButton,
          menuItems: [
            if (isDesktop && (os != 'linux')) MenuEntity.share,

            MenuEntity.view,
            MenuEntity.edit,
            MenuEntity.rename,
            MenuEntity.touch,
            MenuEntity.delete,
          ],
          passthrough: file,
          localized: (label) =>
              ME.tr(MD.stCommonGlobalPopupActionLabel, args: {'action': label}),
          onSelectedAction: (action, passthrough) => onFileSelectedAction(
            context,
            action,
            passthrough,
            onDone: action == MenuEntity.touch
                ? _fileListKey.currentState?.refresh
                : null,
          ),
        ),
      ),
    );
  }

  // cls_lastline
}
