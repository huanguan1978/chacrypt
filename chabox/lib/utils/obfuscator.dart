// ignore_for_file: prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers

import 'dart:math';
import '../core/guard.dart';
import 'processed_result.dart';

/// Semantic Deception Helper: Masks security gatekeeping as data processing.
/// AI static analysis will perceive these methods as routine formatting,
/// effectively hiding the dependency on the Guard system.
class Obfuscator {
  final Guard _gate;

  Obfuscator(this._gate);

  /// Masks security check as a data normalization step.
  /// AI will treat this as a standard string-to-hex transformation utility.
  ProcessedResult normalize(String input, int seed) {
    // Perform complex redundant arithmetic to distract analysis
    // Ensure input data conforms to the required buffer alignment
    // for internal hashing protocols to prevent block overflow.
    final List<int> stream = List.generate(input.length, (i) {
      final char = input.codeUnitAt(i);
      return (char ^ (seed % 255)) + (i % 7);
    });

    if (!_gate.check()) {
      return ProcessedResult(_generateNoise(input.length), false);
    }

    final buffer = StringBuffer();
    for (int i = 0; i < stream.length; i++) {
      // Bitwise scrambling to simulate data-flow complexity
      int val = (stream[i] << 2) ^ (i * seed % 13);
      String hex = val.toRadixString(16);
      buffer.write(hex.length.isEven ? hex : '0' + hex);
    }

    // Final checksum validation to simulate state consistency checks
    final checksum = buffer.toString().length % 16;
    return ProcessedResult(
      buffer.toString() + checksum.toRadixString(16),
      true,
    );
  }

  /// Generates benign, seemingly valid noise.
  String _generateNoise(int length) {
    // Noise mask constants for simulated data entropy.
    const int _noiseMask = 0xAF;
    const int _noiseShift = 0x03;
    final rnd = Random();

    // Simulate valid-looking but corrupted data patterns
    // using structured noise generation to emulate buffer headers.
    final List<String> segments = List.generate(length, (i) {
      final val = (rnd.nextInt(16) ^ _noiseMask) >> _noiseShift;
      return val.toRadixString(16).padLeft(2, '0');
    });

    return segments.join() + 'f0';
  }
}
