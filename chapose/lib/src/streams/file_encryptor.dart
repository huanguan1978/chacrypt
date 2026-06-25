part of '../../chapose.dart';

/// Encrypts data using ChaCha20-Poly1305, including schema, nonce and aad in the output stream for file persistence.
/// Output format: [schema (4 bytes)] [nonce (12 bytes)] [aad_length (4 bytes, little-endian)] [aad data] [encrypted chunks] [tag (16 bytes)]
class ChaCha20Poly1305FileEncryptor
    extends StreamTransformerBase<List<int>, List<int>> {
  // Constants for ChaCha20-Poly1305 parameters
  static const int _addLength = ChaContant.addLength;
  static const int _tagLength = ChaContant.tagLength;

  static final Uint8List _schema = Uint8List.fromList(
    ChaContant.verSchema.codeUnits,
  );

  final Uint8List key;
  final Uint8List nonce;
  final Uint8List? aad;
  final int chunkSize;

  const ChaCha20Poly1305FileEncryptor({
    required this.key,
    required this.nonce,
    this.aad,
    this.chunkSize = 64 * 1024, // 64KB
  });

  @override
  Stream<List<int>> bind(Stream<List<int>> stream) async* {
    // Prepare aad (default to empty if null)
    final Uint8List aadData = aad ?? Uint8List(0);
    // Yield schema (4 bytes)
    yield _schema;
    // Yield nonce (12 bytes)
    yield nonce;

    // Yield aad length (4 bytes, little-endian)
    ByteData aadLengthBlock = ByteData(_addLength)
      ..setUint32(0, aadData.length, Endian.little);
    yield aadLengthBlock.buffer.asUint8List();

    // Yield aad data
    if (aadData.isNotEmpty) {
      yield aadData;
    }

    // Now proceed with original encryption logic
    // Initialize Poly1305
    Uint8List polyKey = poly1305KeyGen(key, nonce);
    Poly1305Mac mac = Poly1305Mac(polyKey);

    // Process AAD
    if (aadData.isNotEmpty) {
      mac.update(aadData);
      mac.update(padding(aadData.length));
    }

    // Initialize counter for ChaCha20
    int counter = 1; // Starts from 1 as per specification

    int totalDataLength = 0;

    // Stream processing
    await for (List<int> chunk in stream) {
      if (chunk.isEmpty) continue; // Skip empty chunks

      // Encrypt chunk
      List<int> encryptedChunk = chacha20Encrypt(key, counter, nonce, chunk);

      // Update counter
      int numberOfBlocks = (encryptedChunk.length + 63) ~/ 64;
      counter += numberOfBlocks;

      // Update MAC with encrypted data
      mac.update(encryptedChunk);

      totalDataLength += encryptedChunk.length;

      // Yield encrypted chunk
      yield encryptedChunk;
    }

    // Process padding for ciphertext
    int ciphertextPaddingLength =
        (_tagLength - (totalDataLength % _tagLength)) % _tagLength;
    if (ciphertextPaddingLength > 0) {
      mac.update(Uint8List(ciphertextPaddingLength));
    }

    // Process lengths
    ByteData lengthBlock = ByteData(_tagLength)
      ..setUint64(0, aadData.length, Endian.little)
      ..setUint64(8, totalDataLength, Endian.little);

    mac.update(lengthBlock.buffer.asUint8List());

    // Compute tag
    Uint8List tag = mac.finish();

    // Yield tag
    yield tag;
  }
}
