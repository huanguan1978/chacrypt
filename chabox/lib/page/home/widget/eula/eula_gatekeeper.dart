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
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_it/flutter_it.dart';
import 'package:file/memory.dart';
import 'package:path/path.dart' as p;

import '../../../../core/constant.dart' show LangEnum;
import '../../../../utils/caching.dart';
import '../../../../widget/enum_button_entity.dart';
import '../../../../widget/enum_menu_action.dart';
import '../../../view/text_plain_page.dart';

import '../../../../message/definition.dart';
import '../../helper/security_briefing.dart';

class EulaGatekeeper extends StatefulWidget with WatchItStatefulWidgetMixin {
  final Widget child;
  const EulaGatekeeper({super.key, required this.child});

  @override
  State<EulaGatekeeper> createState() => _EulaGatekeeperState();
}

class _EulaGatekeeperState extends State<EulaGatekeeper> {
  dynamic _eulaFile;

  @override
  void initState() {
    super.initState();

    final lang = GetIt.I<Caching>().lang.value;
    _prepareEula(lang);
  }

  void _prepareEula(String langCode) {
    /*
    final lang = GetIt.I<Caching>().lang.value;
    final supported = LangEnum.values.map((e) => e.name);
    final langCode = supported.contains(lang) ? lang : 'en';
    */
    final path = 'assets/eula/eula_$langCode.md';

    rootBundle.loadString(path).then((content) {
      final fs = MemoryFileSystem();
      final file = fs.file(p.basename(path));
      file.writeAsStringSync(content);

      if (mounted) {
        setState(() => _eulaFile = file);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final eulaAccepted = watchValue((Caching c) => c.eula);
    if (eulaAccepted) return widget.child;
    if (_eulaFile == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    String langName = watchValue((Caching c) => c.lang);
    final langEnum = LangEnum.values.firstWhere(
      (e) => e.name == langName,
      orElse: () => LangEnum.en,
    );

    return TextPlainViewPage(
      _eulaFile,
      bottomAction: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MenuAction<LangEnum>(
            menuType: MenuType.dropdownButton,
            menuItems: LangEnum.values,
            menuSelected: langEnum,
            buttonIcon: const Icon(Icons.language),
            localized: (label) =>
                ME.tr(MD.stHomeDrawerSettingLangLabel, args: {'lang': label}),

            onSelectedAction: (action, _) {
              if (action != null) {
                // debugPrint(action.name);
                langName = action.name;
                di<Caching>().lang = langName;
                _prepareEula(langName);
              }
            },
          ),

          ElevatedButton(
            onPressed: () {
              GetIt.I<Caching>().eula = true;

              sl<BriefingService>().loadDatabase(
                langName,
                onLoaded: (_) => sl<Caching>().briefingUpdated.value++,
              );
            },
            child: Text(
              ME.tr(
                MD.stCommonGlobalButtonActionLabel,
                args: {'action': ButtonEntity.accept.toString()},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
