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
import 'package:file_selector/file_selector.dart';
import 'package:desktop_drop/desktop_drop.dart';
import '../../../../message/definition.dart';
import '../../../../widget/enum_menu_action.dart';
import '../../../../widget/enum_menu_entity.dart';

class SinglePath extends StatefulWidget {
  final TextEditingController controller;
  final bool readonly;
  final Function(String)? onChanged;
  final String? os;

  const SinglePath({
    super.key,
    required this.controller,
    required this.readonly,
    this.onChanged,
    this.os,
  });

  @override
  State<SinglePath> createState() => _SinglePathState();
}

class _SinglePathState extends State<SinglePath> {
  // final TextEditingController _controller = TextEditingController();
  bool _isDragging = false;

  Future<void> _pickFile() async {
    final XFile? file = await openFile();
    if (file != null) {
      if (widget.onChanged != null) widget.onChanged?.call(file.path);
      setState(() => widget.controller.text = file.path);
    }
  }

  Future<void> _pickDirectory() async {
    final String? path = await getDirectoryPath();
    if (path != null) {
      if (widget.onChanged != null) widget.onChanged?.call(path);
      setState(() => widget.controller.text = path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragEntered: (_) => setState(() => _isDragging = true),
      onDragExited: (_) => setState(() => _isDragging = false),
      onDragDone: (details) {
        setState(() => _isDragging = false);
        if (details.files.isNotEmpty) {
          final path = details.files.first.path;
          widget.controller.text = path;
          if (widget.onChanged != null) widget.onChanged?.call(path);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: _isDragging ? Colors.blue : Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: TextField(
          controller: widget.controller,
          readOnly: widget.readonly,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: InputBorder.none,
            hintText: ME.tr(MD.stSinglePathEmptyHint),
            suffixIcon: MenuAction<MenuEntity>(
              menuType: MenuType.popupMenuButton,
              menuItems: [
                MenuEntity.pickfile,
                if (widget.os case String os when (os != 'ios' || os != 'web'))
                  MenuEntity.pickfolder,
                MenuEntity.reset,
              ],
              localized: (key) => ME.tr(
                MD.stCommonGlobalPopupActionLabel,
                args: {'action': key},
              ),
              onSelectedAction: (action, _) {
                switch (action) {
                  case MenuEntity.pickfile:
                    _pickFile();
                    break;
                  case MenuEntity.pickfolder:
                    _pickDirectory();
                    break;
                  case MenuEntity.reset:
                    widget.controller.clear();
                    break;
                  default:
                    break;
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
