/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, PlatformDispatcher;
import 'package:flutter/material.dart' show Locale, ThemeData, ColorScheme;

ThemeData localeTheme(Locale locale, ColorScheme scheme) => ThemeData(
  useMaterial3: true,
  colorScheme: scheme,
  fontFamilyFallback: localeFonts(locale),
);

List<String> localeFonts(Locale locale) {
  var fallbacks = ['sans-serif'];

  final os = kIsWeb ? 'web' : defaultTargetPlatform.name.toLowerCase();
  final lang = locale.languageCode.toLowerCase();
  final script = (locale.scriptCode ?? '').toLowerCase();

  // dart format off
  switch (os) {
    case 'web':
      fallbacks = ['system-ui', '-apple-system', 'Segoe UI', 'Roboto', 'Helvetica', 'Arial', 'sans-serif'];
      break;

    case 'linux':
      fallbacks = ['Noto Sans CJK SC', 'Noto Sans CJK JP', 'Noto Sans CJK KR', 'sans-serif'];
      break;

    case 'ios':
      if (lang == 'zh') {
        fallbacks = ['.AppleSystemUIFont', 'PingFang SC', 'sans-serif'];
      }
      break;

    case 'windows':
      if (lang == 'zh') {
        if(script == 'hant'){
          fallbacks = ['Microsoft JhengHei', 'MingLiU', 'sans-serif'];
        }else{
          fallbacks = ['Microsoft YaHei', 'SimHei', 'sans-serif'];
        }
      }

      if (lang == 'ja') {
        fallbacks = ['Meiryo', 'Yu Gothic', 'MS Gothic', 'sans-serif'];
      }
      if (lang == 'ko') {
        fallbacks = ['Malgun Gothic', 'Dotum', 'sans-serif'];
      }

      break;
    case 'macos':
      if (lang == 'zh') {
        if(script == 'hant'){
          fallbacks = ['PingFang TC', 'Heiti TC', 'sans-serif'];
        }else{
          fallbacks = ['PingFang SC', 'Hiragino Sans GB', 'Heiti SC', 'sans-serif'];
        }
      }

      if (lang == 'ja') {
        fallbacks = ['Hiragino Kaku Gothic ProN', 'HiraKakuProN-W3', 'sans-serif'];
      }
      if (lang == 'ko') {
        fallbacks = ['Apple SD Gothic Neo', 'NanumGothic', 'sans-serif'];
      }

      break;

    case 'android':
      if (lang == 'zh') {
        if(script == 'hant'){
          fallbacks = ['Noto Sans TC', 'Roboto', 'sans-serif'];
        }else{
          fallbacks = ['Noto Sans SC', 'Roboto', 'sans-serif'];
        }
      }

      if (lang == 'ja') {
        fallbacks = ['Noto Sans JP', 'Roboto', 'sans-serif'];
      }
      if (lang == 'ko') {
        fallbacks = ['Noto Sans KR', 'Roboto', 'sans-serif'];
      }

      break;



    default:
  }

  return fallbacks;
}


Locale get currentLocale => PlatformDispatcher.instance.locale;

String supportLanguage(Iterable<String> supports, [String defaultLanguage='en']
){
  final locale = currentLocale;
  var language = locale.languageCode;
  if(!supports.contains(language))  return defaultLanguage;
  if(language == 'zh'){
    final scriptCode = locale.scriptCode??'';
    if(scriptCode == 'Hans') language = 'hk';
    if(scriptCode.isEmpty){
      final hansCities = ['TW','HK','MO'];
      if(hansCities.contains(locale.countryCode??'')) language = 'hk';
    }
  }

  return language;
}