/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 *
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

// This page allows the user to define up to 15 custom template variables
// (key-value pairs) that can be referenced in the Markdown editor via {{varName}}.
// It also displays 5 read-only system path variables derived from Caching.
// All path values are presented and stored using POSIX separators (/).

import 'package:chabox/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';

import '../../utils/caching.dart';
import '../../utils/file_helper.dart';
import '../../widget/enum_button_entity.dart';
import '../../message/definition.dart';
import '../../widget/enum_menu_entity.dart';

class TextVariablePage extends StatefulWidget {
  const TextVariablePage({super.key});

  @override
  State<TextVariablePage> createState() => _TextVariablePageState();
}

class _TextVariablePageState extends State<TextVariablePage> {
  static const int _maxCustomVars = 15;

  final List<TextEditingController> _keyControllers = List.generate(
    _maxCustomVars,
    (_) => TextEditingController(),
  );
  final List<TextEditingController> _valueControllers = List.generate(
    _maxCustomVars,
    (_) => TextEditingController(),
  );

  bool _isDirty = false;

  @override
  void initState() {
    super.initState();
    _loadVariables();
  }

  /// Converts a native filesystem path to POSIX format (forward slashes).
  String _toPosix(String path) => path.replaceAll(r'\', '/');

  void _loadVariables() {
    final vars = sl<Caching>().textvars.value;
    int index = 0;
    for (final entry in vars.entries) {
      if (index >= _maxCustomVars) break;
      _keyControllers[index].text = entry.key;
      _valueControllers[index].text = entry.value;
      index++;
    }
  }

  Future<void> _saveVariables() async {
    // Valid Dart identifier: starts with letter or underscore, followed by word chars.
    final keyPattern = RegExp(r'^[a-zA-Z_]\w*$');
    final map = <String, String>{};
    final List<int> invalidRows = [];

    for (int i = 0; i < _maxCustomVars; i++) {
      final key = _keyControllers[i].text.trim();
      final val = _valueControllers[i].text.trim();
      if (key.isEmpty) continue;
      if (!keyPattern.hasMatch(key)) {
        invalidRows.add(i + 1);
        continue;
      }
      map[key] = val;
    }

    if (invalidRows.isNotEmpty && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Rows ${invalidRows.join(', ')}: invalid name(s) skipped. '
            'Names must start with a letter or underscore.',
          ),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 3),
        ),
      );
    }

    sl<Caching>().textvars = map;
    _isDirty = false;
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    context.showSnackBar(ME.tr(MD.rsCommonGlobalActionCopied));
  }

  @override
  void dispose() {
    for (final c in _keyControllers) {
      c.dispose();
    }
    for (final c in _valueControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final caching = sl<Caching>();

    // System read-only variables, paths displayed in POSIX format.
    final readOnlyVars = <String, String>{
      'noteDir': _toPosix(caching.noteDir.path),
      'encDir': _toPosix(caching.encDir.path),
      'decDir': _toPosix(caching.decDir.path),
      'enaDir': _toPosix(caching.enaDir.path),
      'deaDir': _toPosix(caching.deaDir.path),
    };

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;
        if (_isDirty) await _saveVariables();
        if (context.mounted) Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          // title: const Text('Template Variables'),
          actions: [
            IconButton(
              icon: ButtonEntity.save.getIcon(),
              tooltip: ME.tr(
                MD.stCommonGlobalButtonActionLabel,
                args: {'action': ButtonEntity.save.toString()},
              ),
              onPressed: () async {
                await _saveVariables();
                if (context.mounted) Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // --- App Read-Only Variables ---
              Text(
                ME.tr(
                  MD.stCommonVariablesBodyLabel,
                  args: {'label': 'appVarsTitle'},
                ),
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                ME.tr(
                  MD.stCommonVariablesBodyLabel,
                  args: {'label': 'appVarsDesc'},
                ),
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: readOnlyVars.entries.map((entry) {
                      final placeholder = '{{${entry.key}}}';
                      // Abbreviate the POSIX path for compact display.
                      final abbreviated = abbreviatePath(
                        entry.value,
                      ).replaceAll(r'\', '/');
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 2,
                        ),
                        child: Row(
                          children: [
                            SelectableText(placeholder),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Tooltip(
                                message: entry.value,
                                child: Text(
                                  abbreviated,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: MenuEntity.copy.getIcon(size: 16),
                              tooltip: ME.tr(
                                MD.stCommonGlobalPopupActionLabel,
                                args: {'action': MenuEntity.copy.toString()},
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 28,
                                minHeight: 28,
                              ),
                              onPressed: () => _copyToClipboard(placeholder),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // --- Custom Variables ---
              Text(
                ME.tr(
                  MD.stCommonVariablesBodyLabel,
                  args: {'label': 'custVarsTitle'},
                ),

                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                ME.tr(
                  MD.stCommonVariablesBodyLabel,
                  args: {'label': 'custVarsDesc'},
                ),

                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 8),

              ...List.generate(_maxCustomVars, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        child: Text(
                          '${index + 1}',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _keyControllers[index],
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            hintText: 'myVar',
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 10,
                            ),
                          ),
                          onChanged: (_) => setState(() {
                            _isDirty = true;
                          }),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: _valueControllers[index],
                          decoration: const InputDecoration(
                            labelText: 'Value',
                            hintText: '/path/or/text',
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 10,
                            ),
                          ),
                          onChanged: (_) => _isDirty = true,
                        ),
                      ),
                      const SizedBox(width: 2),
                      IconButton(
                        icon: MenuEntity.copy.getIcon(size: 18),
                        tooltip: ME.tr(
                          MD.stCommonGlobalPopupActionLabel,
                          args: {'action': MenuEntity.copy.toString()},
                        ),
                        onPressed: _keyControllers[index].text.trim().isNotEmpty
                            ? () => _copyToClipboard(
                                '{{${_keyControllers[index].text.trim()}}}',
                              )
                            : null,
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
