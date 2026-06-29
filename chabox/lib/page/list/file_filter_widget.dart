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
import 'package:flutter/services.dart' show PlatformException;
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';

import '../../core/constant.dart'
    show chaNoteExtName, chaFileExtName, anyFileExtName;
import '../../../../utils/responsive.dart';
import '../../../../widget/enum_menu_action.dart';
import '../../../../message/definition.dart';
import '../../utils/caching.dart';
import '../../widget/directory.dart';
import '../../widget/enum_menu_entity.dart';

/// A form widget for configuring file filters.
class FileFilterForm extends StatefulWidget {
  final Map<String, dynamic> initialData;
  final Map<String, String>? extraPaths;

  const FileFilterForm({super.key, required this.initialData, this.extraPaths});

  @override
  State<FileFilterForm> createState() => FileFilterFormState();
}

class FileFilterFormState extends State<FileFilterForm> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, dynamic> _data;

  late TextEditingController _patternController;
  late TextEditingController _mimeController;
  late TextEditingController _minSizeController;
  late TextEditingController _maxSizeController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;

  @override
  void initState() {
    super.initState();
    _data = Map<String, dynamic>.from(widget.initialData);
    _data['sortBy'] ??= 'date';
    _data['sortOrder'] ??= 'desc';

    _patternController = TextEditingController(text: _data['pattern'] ?? '**');
    _mimeController = TextEditingController(text: _data['mimetype'] ?? '');
    _minSizeController = TextEditingController(
      text: _data['minSize']?.toString() ?? '',
    );
    _maxSizeController = TextEditingController(
      text: _data['maxSize']?.toString() ?? '',
    );
    _startDateController = TextEditingController(
      text: _data['startDate'] != null
          ? (_data['startDate'] as DateTime).toString().split(' ')[0]
          : '',
    );
    _endDateController = TextEditingController(
      text: _data['endDate'] != null
          ? (_data['endDate'] as DateTime).toString().split(' ')[0]
          : '',
    );
  }

  @override
  void dispose() {
    _patternController.dispose();
    _mimeController.dispose();
    _minSizeController.dispose();
    _maxSizeController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  void reset() {
    _formKey.currentState?.reset();
    setState(() {
      _patternController.text = '**';
      _mimeController.clear();
      _minSizeController.clear();
      _maxSizeController.clear();
      _startDateController.clear();
      _endDateController.clear();
      _data = {
        'directory': widget.initialData['directory'],
        'pattern': '**',
        'sortBy': 'date',
        'sortOrder': 'desc',
      };
    });
  }

  Future<Map<String, dynamic>?> submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return null;
    _formKey.currentState?.save();
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = sl<bool>(instanceName: 'isDesktop');
    final os = sl<String>(instanceName: 'os');

    final cache = sl<Caching>();
    final knownPaths = {
      'Notes': cache.noteDir.path,
      'Encrypt': cache.encDir.path,
      'Decrypt': cache.decDir.path,
      'Archive': cache.enaDir.path,
      'Unarchive': cache.deaDir.path,
    };

    final knownPattern = {
      'Notes': '**$chaNoteExtName',
      'Encrypt': '**$chaFileExtName',
      'Decrypt': anyFileExtName,
      'Archive': anyFileExtName,
      'Unarchive': anyFileExtName,
    };

    if (widget.extraPaths != null) {
      knownPaths.addAll(widget.extraPaths!);
    }

    // local error handler so static helpers can reuse the same callback
    void dirOnError(Object err, StackTrace st) {
      var message = err.toString();
      if (err case PlatformException _) {
        message = err.message ?? err.code;
      }
      sl<Logger>().severe('DirectorySelector, onError, $message');
      context.showSnackBar(message);
    }

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DirectorySelector(
              title: ME.tr(MD.stCommonFormFieldLabel, args: {'field': 'dir'}),
              directory: _data['directory'] ?? '',
              onError: dirOnError,

              onChanged: (path, pattern) {
                if (pattern != null) _patternController.text = pattern;
                setState(() => _data['directory'] = path);
              },
              options: [
                if (isDesktop || (os == 'android'))
                  DirectoryOption(
                    label: ME.tr(
                      MD.stCommonGlobalPopupActionLabel,
                      args: {'action': MenuEntity.pickfolder.toString()},
                    ),
                    icon: MenuEntity.pickfolder.getIcon(size: 16),
                    onAction: () => DirectorySelector.pickDirectory(
                      _data['directory'] ?? '',
                      (path) => setState(() {
                        _data['directory'] = path;
                      }),
                      onError: dirOnError,
                    ),
                  ),
                if (isDesktop)
                  DirectoryOption(
                    label: ME.tr(
                      MD.stCommonGlobalPopupActionLabel,
                      args: {'action': MenuEntity.openfolder.toString()},
                    ),
                    icon: MenuEntity.openfolder.getIcon(size: 16),
                    onAction: () => DirectorySelector.openDirectory(
                      _data['directory'] ?? '',
                      onError: dirOnError,
                    ),
                  ),
                ...knownPaths.entries.map((entry) {
                  return DirectoryOption(
                    label: ME.tr(
                      MD.stHomeDrawerDirectoryTitle,
                      args: {'title': entry.key.toLowerCase()},
                    ),
                    icon: const Icon(Icons.folder_outlined, size: 16),
                    path: entry.value,
                    pattern: knownPattern[entry.key],
                  );
                }),
              ],
            ),
            const Divider(),
            TextFormField(
              controller: _patternController,
              decoration: InputDecoration(
                labelText: ME.tr(
                  MD.stCommonFormFieldLabel,
                  args: {'field': 'pattern'},
                ),
                hintText: "**/*.txt",
                prefixIcon: const Icon(Icons.search),
              ),
              onSaved: (v) => _data['pattern'] = v,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _mimeController,
              decoration: InputDecoration(
                labelText: ME.tr(
                  MD.stCommonFormFieldLabel,
                  args: {'field': 'mime'},
                ),
                hintText: "image/, text/plain",
                prefixIcon: const Icon(Icons.type_specimen_outlined),
              ),
              onSaved: (v) => _data['mimetype'] = v,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: ME.tr(
                        MD.stCommonFormFieldLabel,
                        args: {'field': 'sortBy'},
                      ),
                      prefixIcon: const Icon(Icons.sort),
                    ),
                    child: MenuAction<String>(
                      menuType: MenuType.dropdownButton,
                      menuItems: const ['name', 'size', 'date'],
                      menuSelected: _data['sortBy'],
                      onSelectedAction: (v, _) =>
                          setState(() => _data['sortBy'] = v),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: ME.tr(
                        MD.stCommonFormFieldLabel,
                        args: {'field': 'sortOrder'},
                      ),
                      prefixIcon: const Icon(Icons.swap_vert),
                    ),
                    child: MenuAction<String>(
                      menuType: MenuType.dropdownButton,
                      menuItems: const ['asc', 'desc'],
                      menuSelected: _data['sortOrder'],
                      onSelectedAction: (v, _) =>
                          setState(() => _data['sortOrder'] = v),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _minSizeController,
                    decoration: InputDecoration(
                      labelText: ME.tr(
                        MD.stCommonFormFieldLabel,
                        args: {'field': 'minSize'},
                      ),
                      prefixIcon: const Icon(Icons.arrow_downward),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (v) => _data['minSize'] = int.tryParse(v ?? ''),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _maxSizeController,
                    decoration: InputDecoration(
                      labelText: ME.tr(
                        MD.stCommonFormFieldLabel,
                        args: {'field': 'maxSize'},
                      ),
                      prefixIcon: const Icon(Icons.arrow_upward),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (v) => _data['maxSize'] = int.tryParse(v ?? ''),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _startDateController,
                    decoration: InputDecoration(
                      labelText: ME.tr(
                        MD.stCommonFormFieldLabel,
                        args: {'field': 'startDate'},
                      ),
                      prefixIcon: const Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _data['startDate'] ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        setState(() {
                          _data['startDate'] = date;
                          _startDateController.text = date.toString().split(
                            ' ',
                          )[0];
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _endDateController,
                    decoration: InputDecoration(
                      labelText: ME.tr(
                        MD.stCommonFormFieldLabel,
                        args: {'field': 'endDate'},
                      ),
                      prefixIcon: const Icon(Icons.calendar_month),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _data['endDate'] ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        setState(() {
                          _data['endDate'] = date;
                          _endDateController.text = date.toString().split(
                            ' ',
                          )[0];
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
