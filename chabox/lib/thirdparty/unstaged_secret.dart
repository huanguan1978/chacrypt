/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'dart:convert' show base64, utf8;

import 'package:dart_eval/dart_eval.dart';
import 'package:dart_eval/stdlib/core.dart';

class Secret {
  final String b64secret;
  final Runtime runtime;

  final _library = 'package:unstaged/main.dart';
  Secret(this.b64secret)
    : runtime = Runtime(base64.decode(b64secret).buffer.asByteData());

  String _enthree(String secret) =>
      (runtime.executeLib(_library, 'enthree', [$String(secret)]) as $String)
          .$value;
  String _dethree(String secret) =>
      (runtime.executeLib(_library, 'dethree', [$String(secret)]) as $String)
          .$value;

  String _ensixteen(String secret) =>
      (runtime.executeLib(_library, 'ensixteen', [$String(secret)]) as $String)
          .$value;
  String _desixteen(String secret) =>
      (runtime.executeLib(_library, 'desixteen', [$String(secret)]) as $String)
          .$value;

  String ensixteen(String secret) =>
      base64.encode(utf8.encode(_ensixteen(secret)));

  String desixteen(String secret) =>
      _desixteen(utf8.decode(base64.decode(secret)));

  String enthree(String secret) => base64.encode(utf8.encode(_enthree(secret)));
  String dethree(String secret) => _dethree(utf8.decode(base64.decode(secret)));

  List<int> _xor(List<int> dat, List<int> key) =>
      (runtime.executeLib(_library, 'xor', [
                $List.wrap(dat.map((e) => $int(e)).toList()),
                $List.wrap(key.map((e) => $int(e)).toList()),
              ])
              as List)
          .map((e) => e.$value as int)
          .toList();

  String enxthree(String secret, String key) =>
      base64.encode(_xor(utf8.encode(_enthree(secret)), key.codeUnits));

  String dexthree(String secret, String key) =>
      _dethree(utf8.decode(_xor(base64.decode(secret), key.codeUnits)));

  String enxsixteen(String secret, String key) =>
      base64.encode(_xor(utf8.encode(_ensixteen(secret)), key.codeUnits));

  String dexsixteen(String secret, String key) =>
      _desixteen(utf8.decode(_xor(base64.decode(secret), key.codeUnits)));

  // cls_lastline
}
