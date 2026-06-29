import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_it/flutter_it.dart';
import 'package:file/memory.dart';
import 'package:path/path.dart' as p;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import '../../../../core/constant.dart' show LangEnum, appName, appRepo;
import '../../../../utils/file_helper.dart' show removeLastLine;
import '../../../../widget/enum_button_entity.dart';
import '../../../../message/definition.dart';
import '../../../../utils/caching.dart';
import '../../../view/text_plain_page.dart';

class AboutInfoDialog extends StatefulWidget {
  const AboutInfoDialog({super.key});

  @override
  State<AboutInfoDialog> createState() => _AboutInfoDialogState();
}

class _AboutInfoDialogState extends State<AboutInfoDialog> {
  String _markdownContent = '';
  late String _langCode;
  late Map<String, dynamic> _pkgInfo;

  @override
  void initState() {
    super.initState();

    final lang = sl<Caching>().lang.value;
    final supported = LangEnum.values.map((e) => e.name);
    _langCode = supported.contains(lang) ? lang : 'en';
    _pkgInfo = sl<Map>(instanceName: 'pkgInfo') as Map<String, dynamic>;

    _loadEcosystem();
  }

  void _loadEcosystem() {
    final ecos = 'assets/ecos/ecos_$_langCode.md';

    rootBundle.loadString(ecos).then((content) {
      if (mounted) {
        setState(() {
          _markdownContent = content;
        });
      }
    });
  }

  void _openMarkdown(BuildContext context, String assetPath, String title) {
    final isEula = assetPath.contains('eula');
    rootBundle.loadString(assetPath).then((content) {
      if (isEula) content = removeLastLine(content);
      final fs = MemoryFileSystem();
      final file = fs.file(p.basename(assetPath));
      file.writeAsStringSync(content);

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TextPlainViewPage(file)),
        ).whenComplete(() {
          if (file.existsSync()) file.deleteSync();
        });
      } else {
        if (file.existsSync()) file.deleteSync();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _buildTitle(),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppInfo(),
          const SizedBox(height: 15),
          _buildLinks(context),
          const Divider(height: 30),
          _buildEcosystem(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            ME.tr(
              MD.stCommonGlobalButtonActionLabel,
              args: {'action': ButtonEntity.close.toString()},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    final pkgAppName = _pkgInfo['appName'] ?? appName;
    return Row(
      children: [
        Image.asset(
          'assets/chabox_icon_square_512x512.png',
          width: 40,
          height: 40,
        ),
        const SizedBox(width: 15),
        Text(pkgAppName),
      ],
    );
  }

  Widget _buildAppInfo() {
    final version = _pkgInfo['version'] ?? '';
    final pkgName = _pkgInfo['packageName'] ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Package: $pkgName'),
        Text(
          'Version: $version',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('Copyright © 2026 ${(_pkgInfo['appName'] ?? appName)} Team.'),
      ],
    );
  }

  Widget _buildLinks(BuildContext context) {
    final repo = Uri.parse(appRepo);

    final eula = 'assets/eula/eula_$_langCode.md';
    final noti = 'assets/license/notices_$_langCode.md';

    return Wrap(
      spacing: 15,
      runSpacing: 10,
      children: [
        InkWell(
          onTap: () => canLaunchUrl(repo).then((ok) {
            if (ok) launchUrl(repo);
          }),
          child: const Text(
            "Support",
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        _linkButton(context, eula, 'Terms'),
        _linkButton(context, noti, 'License'),
      ],
    );
  }

  Widget _buildEcosystem() {
    return MarkdownBody(
      data: _markdownContent,
      onTapLink: (text, href, title) {
        if (href != null) {
          final uri = Uri.parse(href);
          canLaunchUrl(uri).then((ok) {
            if (ok) launchUrl(uri);
          });
        }
      },
    );
  }

  Widget _linkButton(BuildContext context, String path, String label) {
    return InkWell(
      onTap: () => _openMarkdown(context, path, label),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
