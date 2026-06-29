/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

/*
 * Copied from [patching] (Repo: https://github.com/huanguan1978/patching)
 * Methods: Tmpl.
 * Update: Replace the implementation below with latest code from repo.
 */

// --- Implementation ---

class Tmpl {
  final Map<String, String> variables;
  Tmpl(this.variables);

  /// Evaluates variables within a string template.
  ///
  /// ```dart
  /// var template = 'Hello {{name}}! You are {{age}} years old.';
  /// var variables = {'name': 'John','age': '25'};
  /// var result = Tmpl(variables).tmpl(template);
  /// print(result); // Hello John! You are 25 years old.
  /// ```
  String tmpl(String template) {
    // Valid Dart variable names, typically composed of letters, numbers, and underscores, starting with a letter or underscore.
    const pattern = r'\{\{([a-zA-Z_]\w*)}}';
    return template.replaceAllMapped(RegExp(pattern), (match) {
      final variableName = match.group(1);
      if (variables.containsKey(variableName)) {
        return variables[variableName]!;
      }
      return match.input;
    });
  }

  /// Finds all variable names within a string template.
  ///
  /// Use cases:
  /// 1. Find all variable names in the template.
  /// 2. Check which variables are missing/unprocessed after evaluation.
  ///
  /// ```dart
  /// var template = 'Hello {{name}}! You are {{age}} years old.';
  /// var variables = {'name': 'John','age': '25'};
  /// var result = Tmpl(variables).vars(template);
  /// print(result); // [name, age].
  /// ```
  List<String?> vars(String template) {
    const pattern = r'\{\{([a-zA-Z_]\w*)}}';
    return RegExp(pattern)
        .allMatches(template)
        .map((match) => match.group(1))
        .where((elem) => elem != null)
        .toList();
  }

  /// Evaluates variables in a key-value Map.
  ///
  /// ```dart
  /// var header = {'Authorization': 'Basic {{apikey}}'};
  /// var variables = {'apikey': 'QWxhZGRpbjpvcGVuIHNlc2FtZQ==', 'age': '25'};
  /// final headerNew = Tmpl(variables).vals(header);
  /// print(headerNew); // {Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==}
  /// ```
  Map<String, String> vals(Map<String, String> param) {
    return Map.fromEntries(
      param.entries.map((entry) => MapEntry(entry.key, tmpl(entry.value))),
    );
  }

  /// Evaluates a URL template.
  ///
  /// ```dart
  /// var urltmpl = '{{apiaddr}}/product';
  /// var urlparam = {'limit': '10', 'offset': '{{offset}}'};
  /// var variables = {'apiaddr': 'http://localhost:8080/v1', 'offset': '30'};
  /// final url = Tmpl(variables).url(urltmpl, urlparam);
  /// print(url); // http://localhost:8080/v1/product?limit=10&offset=30
  /// ```
  String url(String url, [Map<String, String>? param]) {
    final urltext = tmpl(url);
    if (param != null) {
      final paramNew = vals(param);
      final qs = Uri(queryParameters: paramNew).query;
      return Uri.parse(urltext).resolve('?$qs').toString();
    }
    return urltext;
  }

  // cls_lastline
}
