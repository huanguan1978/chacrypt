/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'dart:math';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:yaml/yaml.dart';

class SecurityBriefing {
  final String category;
  final String content;

  SecurityBriefing({required this.category, required this.content});
}

/*
class YamlErrorListener implements ErrorListener {
  @override
  void onError(YamlException error) {
    print('message: ${error.message}');
    print('location: ${error.span?.start.line}:${error.span?.start.column}');
  }
}
*/

class BriefingService {
  Logger? logger;

  final Map<String, List<String>> _database = {};
  final List<String> _categories = [
    'app_usage_tips',
    'physical_security',
    'crypto_lore',
    'wisdom_quotes',
    'security_incidents',
  ];

  void loadDatabase(String lang, {Function(String)? onLoaded}) {
    final dbf = 'assets/security/security_database_$lang.yaml';

    rootBundle
        .loadString(dbf)
        .then((yamlString) {
          final dynamic yamlData = loadYaml(yamlString);
          if (yamlData is! Map) {
            logger?.warning(
              'BriefingService, loadDatabase, ignore, invalid yaml.',
            );
            return;
          }

          _database.clear();
          for (var category in _categories) {
            if (yamlData.containsKey(category)) {
              final dynamic list = yamlData[category];
              if (list is List) {
                _database[category] = list.map((e) => e.toString()).toList();
              }
            }
          }
          onLoaded?.call(yamlString);
        })
        .catchError((e) {
          logger?.severe('BriefingService, loadDatabase, err:$e.');
        });
  }

  SecurityBriefing get({bool daily = true}) {
    // In this model, _database should be pre-loaded at startup.
    // If empty, we are in an error state.
    if (_database.isEmpty) {
      return SecurityBriefing(category: 'error', content: 'No data loaded');
    }

    final Random random = daily ? Random(_getDailySeed()) : Random();
    final String category = _categories[random.nextInt(_categories.length)];
    final List<String>? items = _database[category];

    if (items == null || items.isEmpty) {
      for (var cat in _categories) {
        if (_database[cat]?.isNotEmpty ?? false) {
          final String content =
              _database[cat]![random.nextInt(_database[cat]!.length)];
          return SecurityBriefing(category: cat, content: content);
        }
      }
      return SecurityBriefing(category: 'error', content: 'No data found');
    }

    String content = items[random.nextInt(items.length)];

    return SecurityBriefing(category: category, content: content);
  }

  int _getDailySeed() {
    final DateTime now = DateTime.now();
    return now.year * 10000 + now.month * 100 + now.day;
  }
}
