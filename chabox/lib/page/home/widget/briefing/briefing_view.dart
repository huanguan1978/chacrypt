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
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../message/definition.dart';
import '../../../../utils/caching.dart';
import '../../../../utils/responsive.dart';
import '../../../../widget/enum_menu_action.dart';
import '../../../../widget/enum_menu_entity.dart';
import '../../helper/briefing_template.dart';
import '../../helper/security_briefing.dart';
import '../../helper/vault_stats_service.dart';
import '../../helper/vault_scanner.dart';
import 'briefing_footer.dart';
import 'vault_stats_widget.dart';

class BriefingView extends StatefulWidget with WatchItStatefulWidgetMixin {
  final BriefingService service;
  const BriefingView({super.key, required this.service});

  @override
  State<BriefingView> createState() => _BriefingViewState();
}

class _BriefingViewState extends State<BriefingView> {
  SecurityBriefing? _briefing;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadBriefing();
    sl<VaultStatsService>().scan();
  }

  MarkdownStyleSheet _buildMarkdownStyle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MarkdownStyleSheet(
      blockquoteDecoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[200],
        border: Border(
          left: BorderSide(
            color: isDark ? Colors.blueAccent : Colors.blue,
            width: 4,
          ),
        ),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  void _loadBriefing({bool daily = true, bool refresh = false}) {
    setState(() => _loading = true);
    final briefing = widget.service.get(daily: daily);
    if (refresh) {
      sl<VaultStatsService>().refresh();
    }

    if (mounted) {
      setState(() {
        _briefing = briefing;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    registerHandler(
      select: (Caching c) => c.briefingUpdated,
      handler: (context, _, _) => _loadBriefing(),
    );

    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_briefing == null) {
      return const Center(child: Text("No briefing available"));
    }

    final template = BriefingTemplate();
    final String fullMarkdown = template.render(_briefing!);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListenableBuilder(
                  listenable: sl<VaultStatsService>(),
                  builder: (context, _) => sl<VaultStatsService>().enabled
                      ? (sl<VaultStatsService>().loading
                            ? const SizedBox(
                                height: 50,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : VaultStatsWidget(
                                stats:
                                    sl<VaultStatsService>().stats ??
                                    VaultStats.zero(),
                              ))
                      : const SizedBox.shrink(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      template.briefingHeader,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    MenuAction<MenuEntity>(
                      menuItems: const [MenuEntity.copy, MenuEntity.refresh],
                      menuType: MenuType.popupMenuButton,

                      localized: (key) => ME.tr(
                        MD.stCommonGlobalPopupActionLabel,
                        args: {'action': key},
                      ),
                      onSelectedAction: (value, _) {
                        if (value == MenuEntity.copy) {
                          Clipboard.setData(ClipboardData(text: fullMarkdown));
                          context.showSnackBar(template.copiedMessage);
                        } else if (value == MenuEntity.refresh) {
                          _loadBriefing(daily: false, refresh: true);
                        }
                      },
                    ),
                  ],
                ),
                Markdown(
                  data: fullMarkdown,
                  styleSheet: _buildMarkdownStyle(context),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  onTapLink: (text, href, title) {
                    if (href != null) launchUrl(Uri.parse(href));
                  },
                ),
              ],
            ),
          ),
        ),
        const BriefingFooter(),
      ],
    );
  }
}
