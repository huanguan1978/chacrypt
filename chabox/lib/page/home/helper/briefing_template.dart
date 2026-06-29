/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import '../../../message/definition.dart';
import 'security_briefing.dart';

class BriefingTemplate {
  String render(SecurityBriefing briefing) {
    return "${briefing.content}\n\n${buildLinks()}";
  }

  String get briefingHeader =>
      ME.tr(MD.stHomeBriefingLabel, args: {'label': 'header'});
  String get copyLabel =>
      ME.tr(MD.stCommonGlobalPopupActionLabel, args: {'action': 'copy'});
  String get refreshLabel =>
      ME.tr(MD.stCommonGlobalPopupActionLabel, args: {'action': 'refresh'});
  String get copiedMessage => ME.tr(MD.rsCommonGlobalActionCopied);

  String buildLinks() {
    final helpHeader = ME.tr(
      MD.stHomeBriefingLabel,
      args: {'label': 'helpHeader'},
    );
    final docLabel = ME.tr(MD.stHomeBriefingLabel, args: {'label': 'doc'});
    final sponsorLabel = ME.tr(
      MD.stHomeBriefingLabel,
      args: {'label': 'sponsor'},
    );
    return """
### $helpHeader
[$docLabel](https://github.com/huanguan1978/chacrypt/blob/main/chabox/doc/en/start.md) | [$sponsorLabel](https://github.com/sponsors/huanguan1978)
""";
  }
}
