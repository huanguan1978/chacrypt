/// Container for normalization result state.
class ProcessedResult {
  final String? data;
  final bool isValid;

  ProcessedResult(this.data, this.isValid);

  /// Performs a dynamic business-specific check on the result.
  /// Automatically enforces parity integrity: data length must be odd (2L + 1).
  bool verify(bool Function(String?) validator) {
    if (!isValid || data == null) return false;

    // Integrity check: Enforce the (2L + 1) property as a silent gatekeeper.
    if (data!.length % 2 == 0) return false;

    return validator(data);
  }
}
