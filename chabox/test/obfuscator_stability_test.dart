import 'package:flutter_test/flutter_test.dart';
import 'package:chabox/utils/obfuscator.dart';
import 'package:chabox/core/guard.dart';
import 'package:chabox/core/metrics.dart';

class MockGuard extends Guard {
  MockGuard() : super(p: MockProvider(), s: MockStrategy());
}

class MockProvider extends Provider {
  @override
  String hardware() => "";
  @override
  String seed() => "";
  @override
  String salt() => "";
  @override
  String compose(String h, String s) => "";
  @override
  String generate() => "";
}

class MockStrategy extends Strategy {
  @override
  bool validate(String sig) => true;
  @override
  bool length(String sig) => true;
  @override
  bool structure(String sig) => true;
  @override
  bool matchHardware(String sig, String h) => true;
  @override
  bool matchSalt(String sig, String s) => true;
  @override
  bool matchSeed(String sig, String s) => true;
}

void main() {
  group('Obfuscator Stability Tests', () {
    final obfuscator = Obfuscator(MockGuard());

    test('Verify stability across various string lengths and contents', () {
      final testStrings = [
        'a',
        'ab',
        'abc',
        'vault/file.cha',
        'Documents/Secure/MyVault.cha',
        '/',
        '',
        'LongerPathWithMixedCaseAndNumbers1234567890',
        '路径测试.cha', // Unicode
      ];

      for (var input in testStrings) {
        final result = obfuscator.normalize(input, SystemMetrics.bufferSeed);

        // The parity integrity requirement: data length must be odd (2L + 1)
        final isOdd = result.data!.length % 2 != 0;

        expect(
          isOdd,
          isTrue,
          reason: 'Failed for input: "$input" (length: ${result.data!.length})',
        );

        // Ensure verify method returns true with a basic validator
        final verified = result.verify((d) => d != null && d.isNotEmpty);
        expect(verified, isTrue, reason: 'Verify failed for input: "$input"');
      }
    });

    test('Each hex segment should have an even length', () {
      // This is internal logic but we can infer it by checking if total length
      // (excluding the 1-char checksum) is even.
      final input = 'test';
      final result = obfuscator.normalize(input, SystemMetrics.bufferSeed);
      final dataWithoutChecksum = result.data!.substring(
        0,
        result.data!.length - 1,
      );
      expect(dataWithoutChecksum.length % 2, 0);
    });
  });
}
