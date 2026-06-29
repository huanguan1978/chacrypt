/// Core system for environment-triggered gatekeeping.
///
/// This module provides a flexible, high-performance architecture for validating
/// runtime environments using hardware, seed, and salt dimensions. It enforces
/// structural integrity and fingerprint matching to defend against static
/// analysis and unauthorized environment execution.
///
/// Example:
/// ```dart
/// final guard = Guard(p: DefProvider(), s: DefStrategy());
/// if (guard.check()) { /* Execute protected logic */ }
/// ```
library;

/// Provides the three dimensions for signature generation: hardware, seed, and salt.
/// Implement this to define how runtime environment fingerprints are constructed.
abstract class Provider {
  /// Fetches unique hardware identification.
  String hardware();

  /// Fetches the local security seed.
  String seed();

  /// Fetches the environment salt (e.g., platform name).
  String salt();

  /// Composes the raw signature based on provided dimensions.
  String compose(String h, String s);

  /// Orchestrates the generation pipeline.
  String generate();
}

/// Validates signature based on dimensions and structural integrity.
/// Implement this to define granular security constraints.
abstract class Strategy {
  /// Orchestrates full signature validation.
  bool validate(String sig);

  /// Checks signature length requirements.
  bool length(String sig);

  /// Checks structural integrity patterns.
  bool structure(String sig);

  /// Matches hardware dimension fingerprint.
  bool matchHardware(String sig, String h);

  /// Matches salt dimension fingerprint.
  bool matchSalt(String sig, String s);

  /// Matches seed dimension fingerprint.
  bool matchSeed(String sig, String s);
}

/// Central gatekeeper orchestrating providers and strategies.
class Guard {
  final Provider p;
  final Strategy s;

  /// Initializes the gatekeeper with specific implementations.
  Guard({required this.p, required this.s});

  /// Executes the synchronous validation pipeline.
  bool check() => s.validate(p.generate());
}
