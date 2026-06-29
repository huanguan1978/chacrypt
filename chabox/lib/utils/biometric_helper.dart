/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'package:local_auth/local_auth.dart';
import 'package:logging/logging.dart';

class BiometricHelper {
  static final LocalAuthentication _auth = LocalAuthentication();
  static final Logger _logger = Logger('BiometricHelper');

  /// Checks if the device supports any biometric authentication.
  static Future<bool> canAuthenticate() async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
      return canAuthenticate;
    } catch (e) {
      _logger.severe('Error checking biometric support: $e');
      return false;
    }
  }

  /// Returns a list of available biometrics (e.g., face, fingerprint).
  static Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (e) {
      _logger.severe('Error getting available biometrics: $e');
      return <BiometricType>[];
    }
  }

  /// Triggers the biometric authentication prompt.
  static Future<bool> authenticate({
    required String localizedReason,
    bool stickyAuth = true,
    bool biometricOnly = false,
  }) async {
    try {
      return await _auth.authenticate(
        localizedReason: localizedReason,
        biometricOnly: biometricOnly,
      );
    } catch (e) {
      _logger.severe('Error during biometric authentication: $e');
      return false;
    }
  }
}
