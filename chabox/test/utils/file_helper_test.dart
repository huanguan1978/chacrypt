import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:test/test.dart';
import 'package:path/path.dart' as p;
import 'package:chabox/utils/file_helper.dart';

void main() {
  test('safeFilePath handles drive-letter-as-scheme without throwing', () {
    final uri = Uri.parse(
      'e:/14714/Documents/ChaBox/archived/260617_MidnightDeadline.png',
    );
    final res = safeFilePath(uri);
    expect(res, isNotEmpty);
    if (Platform.isWindows) {
      expect(p.isAbsolute(res), isTrue);
      expect(RegExp(r'^[A-Za-z]:[\\/]').hasMatch(res), isTrue);
    }
  });

  test('safeFilePath preserves Uri.file produced paths', () {
    final path = Platform.isWindows ? r'C:\temp\test.png' : '/tmp/test.png';
    final uri = Uri.file(path);
    final res = safeFilePath(uri);
    expect(res, equals(p.normalize(path)));
  });

  test(
    'safeFilePath returns a normalized non-empty string for absolute URIs',
    () {
      final uri = Platform.isWindows
          ? Uri.parse(r'E:\some\path\img.png')
          : Uri.parse('/some/path/img.png');
      final res = safeFilePath(uri);
      expect(res, isNotEmpty);
    },
  );
}
