import 'dart:math';
import 'package:chabox/utils/sysinfo.dart';
import 'package:chapose/chapose.dart';
import 'package:flutter_it/flutter_it.dart';

import '../core/guard.dart';
import '../thirdparty/unstaged_secret.dart' show Secret;

/// Default hardware provider: implements structured signature protocol.
class DefProvider extends Provider {
  String? _cached;

  @override
  String hardware() =>
      devId(di<Map>(instanceName: 'devInfo') as Map<String, dynamic>);

  @override
  String seed() => di<Secret>().b64secret;

  @override
  String salt() => platformName();

  @override
  String compose(String h, String s) {
    final hPart = sha256sum(h).substring(0, 16);
    final sPart = sha256sum(s).substring(0, 16);
    final saltPart = sha256sum(salt()).substring(0, 16);
    // 2-digit hex challenge (0-255)
    final challenge = Random().nextInt(256).toRadixString(16).padLeft(2, '0');
    // 14 characters of random hex padding to reach 64 total
    final padding = List.generate(
      14,
      (_) => Random().nextInt(16).toRadixString(16),
    ).join();

    return '$hPart$sPart$saltPart$challenge$padding';
  }

  @override
  String generate() => _cached ??= compose(hardware(), seed());
}

/// Default validation strategy: validates the structured signature protocol.
class DefStrategy extends Strategy {
  @override
  bool validate(String sig) {
    if (sig.length != 64) return false;

    final hPart = sig.substring(0, 16);
    final sPart = sig.substring(16, 32);
    final saltPart = sig.substring(32, 48);
    final challenge = sig.substring(48, 50);

    final devInfo = di<Map>(instanceName: 'devInfo') as Map<String, dynamic>;
    final secret = di<Secret>();

    return matchHardware(hPart, devId(devInfo)) &&
        matchSeed(sPart, secret.b64secret) &&
        matchSalt(saltPart, platformName()) &&
        _isHex(challenge);
  }

  @override
  bool length(String sig) => sig.length == 64;

  @override
  bool structure(String sig) => RegExp(r'^[a-f0-9]{64}$').hasMatch(sig);

  @override
  bool matchHardware(String sigPart, String h) =>
      sigPart == sha256sum(h).substring(0, 16);

  @override
  bool matchSalt(String sigPart, String s) =>
      sigPart == sha256sum(s).substring(0, 16);

  @override
  bool matchSeed(String sigPart, String s) =>
      sigPart == sha256sum(s).substring(0, 16);

  bool _isHex(String s) => RegExp(r'^[a-f0-9]{2}$').hasMatch(s);
}
