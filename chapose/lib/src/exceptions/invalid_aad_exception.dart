part of '../../chapose.dart';

/// Exception thrown when AAD validation fails in ChaCha20Poly1305FileDecryptor.
class InvalidAadException implements Exception {
  final String message;
  InvalidAadException(this.message);

  @override
  String toString() => 'InvalidAadException: $message';
}
