part of '../chapose.dart';

// Wrapper Constants used in the ChaCha20-Poly1305 cipher.
class ChaContant {
  /// 32 bytes for ChaCha20 key
  static const int keyLength = FastCryptContants.keyLength;

  /// 12 bytes for ChaCha20 nonce
  static const int nonceLength = FastCryptContants.nonceLength;

  /// 16 bytes for Poly1305 tag
  static const int tagLength = FastCryptContants.tagLength;

  /// AAD field length in bytes (4 bytes for little-endian uint32)
  static const int addLength = 4;

  /// Length of the schema identifier in bytes (4 bytes for "CHA1").
  static const int verLength = 4;

  /// Schema identifier for the file format: "CHA1" (4 bytes).
  ///
  /// "CHA" denotes the custom format, "1" indicates major version 1.
  ///
  /// This schema is included at the beginning of the encrypted file to allow future format upgrades while maintaining backward compatibility.
  static const String verSchema = 'CHA1';

  /// File extension for encrypted files using this format.
  static const String extName = '.cha';

  /// Minimum length for user-provided keys (passwords).
  static const int userKeyMinLength = 8;

  /// Default length for user-provided keys (passwords) if not specified.
  static const int userKeyDefaultLength = 32;
}

/// Returns `true` when [file] is a Chapose encrypted file.
///
/// This function first checks the file extension. If the file path ends with
/// `.cha` it returns `true` immediately. Otherwise it reads the first four
/// bytes of the file and verifies the magic header format:
/// - first three bytes are `CHA`
/// - fourth byte is a digit (`0`-`9`)
///
/// If the file is unreadable, too short, or the header does not match,
/// this returns `false`.
bool isChaFile(File file) {
  if (file.path.toLowerCase().endsWith(ChaContant.extName)) {
    return true;
  }

  try {
    final raf = file.openSync(mode: FileMode.read);
    try {
      final header = raf.readSync(4);
      if (header.length < 4) return false;
      return header[0] == 0x43 &&
          header[1] == 0x48 &&
          header[2] == 0x41 &&
          header[3] >= 0x30 &&
          header[3] <= 0x39;
    } finally {
      raf.closeSync();
    }
  } catch (_) {
    return false;
  }
}

/// global variable keyfile from environment
final envKeyfile = Platform.environment['CHAPOSE_KEYFILE'] ??
    Platform.environment['chapose_keyfile'] ??
    '';

/// Encrypts the file at [input] to [output] using a ChaCha20-Poly1305 stream.
Future<void> fileEncrypt(Uint8List key, File input, File output) => input
    .openRead()
    .transform(
      ChaCha20Poly1305FileEncryptor(key: key, nonce: FastCrypt.generateNonce()),
    )
    .pipe(output.openWrite());

/// Decrypts the file at [input] to [output] using a ChaCha20-Poly1305 stream.
Future<void> fileDecrypt(Uint8List key, File input, File output) => input
    .openRead()
    .transform(ChaCha20Poly1305FileDecryptor(key: key))
    .pipe(output.openWrite());
