/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'dart:math' show Random;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform, kIsWeb;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

String platformName() {
  if (kIsWeb) {
    return 'web';
  }
  return switch (defaultTargetPlatform) {
    TargetPlatform.android => 'android',
    TargetPlatform.iOS => 'ios',
    TargetPlatform.linux => 'linux',
    TargetPlatform.windows => 'windows',
    TargetPlatform.macOS => 'macos',
    TargetPlatform.fuchsia => 'fuchsia',
    // ignore: unreachable_switch_case
    _ => 'unknown',
  };
}

bool isDesktop() {
  if (kIsWeb) {
    return false;
  }
  return switch (defaultTargetPlatform) {
    TargetPlatform.android => false,
    TargetPlatform.iOS => false,
    TargetPlatform.linux => true,
    TargetPlatform.windows => true,
    TargetPlatform.macOS => true,
    TargetPlatform.fuchsia => false,
    // ignore: unreachable_switch_case
    _ => false,
  };
}

String devId(Map<String, dynamic> devInfo) {
  final devDat = devInfo;
  if (kIsWeb) {
    final randInt = Random.secure().nextInt(999);
    final msts = DateTime.timestamp().microsecondsSinceEpoch + randInt;
    return msts.toString();
  }
  return switch (defaultTargetPlatform) {
    TargetPlatform.android => devDat['id'] ?? '',
    TargetPlatform.iOS => devDat['identifierForVendor'] ?? '',
    TargetPlatform.linux => devDat['machineId'] ?? '',
    TargetPlatform.windows => devDat['deviceId'] ?? '',
    TargetPlatform.macOS => devDat['systemGUID'] ?? '',
    // TargetPlatform.fuchsia => '',
    // ignore: unreachable_switch_case
    _ => '',
  };
}

String devMfr(Map<String, dynamic> devInfo) {
  final devDat = devInfo;
  if (kIsWeb) {
    return devDat['browserName'] ?? '';
  }
  return switch (defaultTargetPlatform) {
    TargetPlatform.android => devDat['manufacturer'] ?? '',
    TargetPlatform.iOS => devDat['name'] ?? '',
    TargetPlatform.linux => devDat['prettyName'] ?? '',
    TargetPlatform.windows => devDat['productName'],
    TargetPlatform.macOS => devDat['model'],
    // TargetPlatform.fuchsia => '',
    // ignore: unreachable_switch_case
    _ => '',
  };
}

(String, String) devArch(
  Map<String, dynamic> devInfo, {
  Map<String, dynamic> env = const {},
  String unixarch = '',
}) {
  // arm, arm64, ia32, riscv32, riscv64, x64
  final devDat = devInfo;
  var rawArch = '', newArch = '';

  if (kIsWeb) {
    rawArch = devDat['platform'] ?? ''; // MacIntel,Linux x86_64
  } else {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        // arm64-v8a,armeabi-v7a,armeabi,x86
        rawArch = devDat['supportedAbis']?.first;
        newArch = switch (rawArch) {
          'arm64-v8a' => 'arm64',
          'armeabi-v7a' => 'arm',
          'armeabi' => 'arm',
          'x86_64' => 'x64',
          'x86' => 'x86',
          _ => '',
        };
        break;
      case TargetPlatform.iOS:
        // Darwin Kernel Version 21.6.0: Wed Apr 24 06:02:02 PDT 2024; root:xnu-8020.240.18.708.4~1/RELEASE_X86_64
        final utsnameMap = Map<String, String>.from(devDat['utsname'] ?? {});
        if (utsnameMap.isEmpty) {
          newArch = 'arm64';
        } else {
          rawArch = utsnameMap['version'] ?? '';
          newArch = rawArch.contains('86_64') ? 'x64' : 'arm64';
        }
        break;
      case TargetPlatform.windows:
        // 19041.1.adm64fre.vb_release.191206-1406
        rawArch = devDat['buildLabEx'];
        if (rawArch.contains('amd64')) newArch = 'x64';
        if (rawArch.contains('arm64')) newArch = 'arm64';
        if (rawArch.contains('x86')) newArch = 'x86';
        if (newArch.isEmpty && env.isNotEmpty) {
          if (env case {
            'PROCESSOR_ARCHITECTURE': String arch_,
          } when arch_.isEmpty) {
            rawArch = arch_; // x86, AMD64, ARM64
            arch_ = arch_.toLowerCase();
            if (arch_ == 'x86') newArch = 'x86';
            if (arch_ == 'amd64') newArch = 'x64';
            if (arch_ == 'arm64') newArch = 'arm64';
          }
        }

        if (newArch.isEmpty) newArch = 'x64'; //default
        break;
      case TargetPlatform.macOS:
        // i386, x86_64,x86_64h, arm64,arm64e
        rawArch = devDat['arch'];
        if (rawArch.isEmpty && unixarch.isNotEmpty) rawArch = unixarch;
        if (rawArch.startsWith('i386')) newArch = 'x86';
        if (rawArch.startsWith('x86_64')) newArch = 'x64';
        if (rawArch.startsWith('arm64')) newArch = 'arm64';

        if (newArch.isEmpty) newArch = 'arm64'; //default
        break;
      case TargetPlatform.linux:
        // Fedora Linux 40 (Workstation Edition), Freedesktop SDK 24.08 (Flatpak runtime), Ubuntu Core 24
        final arms = ['arm', 'armv6l', 'armv7l']; // 32bit arm
        final x86s = ['i386', 'i486', 'i586', 'i686']; // 32bit intel
        rawArch = '';
        if (rawArch.isEmpty && unixarch.isNotEmpty) rawArch = unixarch;
        newArch = switch (rawArch) {
          String s when x86s.contains(s) => 'x86',
          String s when arms.contains(s) => 'arm',
          String s when s.startsWith('x86_64') => 'x64',
          'aarch64' => 'arm64',
          'riscv64' => 'riscv64',
          _ => '',
        };
        break;
      default:
    }
  }

  return (newArch, rawArch);
}

abstract class SysinfoProvider {
  Future<Map<String, dynamic>> devInfo() async {
    var deviceData = <String, dynamic>{};
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (kIsWeb) {
        deviceData = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      } else {
        deviceData = switch (defaultTargetPlatform) {
          TargetPlatform.android => _readAndroidBuildData(
            await deviceInfoPlugin.androidInfo,
          ),
          TargetPlatform.iOS => _readIosDeviceInfo(
            await deviceInfoPlugin.iosInfo,
          ),
          TargetPlatform.linux => _readLinuxDeviceInfo(
            await deviceInfoPlugin.linuxInfo,
          ),
          TargetPlatform.windows => _readWindowsDeviceInfo(
            await deviceInfoPlugin.windowsInfo,
          ),
          TargetPlatform.macOS => _readMacOsDeviceInfo(
            await deviceInfoPlugin.macOsInfo,
          ),
          TargetPlatform.fuchsia => <String, dynamic>{
            'Error:': 'Fuchsia platform isn\'t supported',
          },
        };
      }
    } catch (e) {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.',
      };
    }
    return deviceData;
  }

  Future<Map<String, dynamic>> pkgInfo() async {
    return _readPackageInfo(await PackageInfo.fromPlatform());
  }

  Map<String, dynamic> _readPackageInfo(PackageInfo data) {
    return <String, dynamic>{
      'appName': data.appName,
      'packageName': data.packageName,
      'version': data.version,
      'buildNumber': data.buildNumber,
      'buildSignature': data.buildSignature,
      'installerStore': data.installerStore,
    };
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return build.data;
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return data.data;
  }

  Map<String, dynamic> _readLinuxDeviceInfo(LinuxDeviceInfo data) {
    return data.data;
  }

  Map<String, dynamic> _readWebBrowserInfo(WebBrowserInfo data) {
    return data.data;
  }

  Map<String, dynamic> _readMacOsDeviceInfo(MacOsDeviceInfo data) {
    return data.data;
  }

  Map<String, dynamic> _readWindowsDeviceInfo(WindowsDeviceInfo data) {
    final info = data.data;
    if (info case {'installDate': DateTime installDate}) {
      info['installDate'] = installDate.toIso8601String();
    }
    return info;
  }

  // cls_lastline
}

class LocalSysinfoProvider extends SysinfoProvider {}

class SysinfoRepository {
  SysinfoRepository(this._sysinfoProvider);
  final SysinfoProvider _sysinfoProvider;

  Future<Map<String, dynamic>> getDevInfo() {
    return _sysinfoProvider.devInfo();
  }

  Future<Map<String, dynamic>> getPkgInfo() {
    return _sysinfoProvider.pkgInfo();
  }
}
