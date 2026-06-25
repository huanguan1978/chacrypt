part of '../../chapose.dart';

/// Decrypts data from a file encrypted by ChaCha20Poly1305FileEncryptor.
/// Reads schema, nonce and aad from the input stream, validates schema and aad via callback, then decrypts.
/// Throws InvalidAadException if aadValidator returns false.
class ChaCha20Poly1305FileDecryptor
    extends StreamTransformerBase<List<int>, List<int>> {
  // Constants for ChaCha20-Poly1305 parameters
  static const int _verLength = ChaContant.verLength;
  static const int _nonceLength = ChaContant.nonceLength;
  static const int _addLength = ChaContant.addLength;
  static const int _tagLength = ChaContant.tagLength;
  static const int _minHeaderLength =
      _verLength + _nonceLength + _addLength + _tagLength;

  static final Uint8List _schema = Uint8List.fromList(
    ChaContant.verSchema.codeUnits,
  );

  final Uint8List key;
  final bool Function(Uint8List aad)? aadValidator; // aad校验回调
  final int chunkSize;

  const ChaCha20Poly1305FileDecryptor({
    required this.key,
    this.aadValidator,
    this.chunkSize = 64 * 1024, // 64KB
  });

  @override
  Stream<List<int>> bind(Stream<List<int>> stream) async* {
    // Buffer to accumulate incoming data
    final List<List<int>> dataChunks = [];
    int totalDataLength = 0;

    // Read all chunks from the stream
    await for (List<int> chunk in stream) {
      dataChunks.add(chunk);
      totalDataLength += chunk.length;
    }

    // Concatenate all chunks
    final allData = List.filled(totalDataLength, 0);
    int offset = 0;
    for (var chunk in dataChunks) {
      allData.setRange(offset, offset + chunk.length, chunk);
      offset += chunk.length;
    }

    // Minimum data length: schema (4) + nonce (12) + aad_length (4) + tag (16) = 36 bytes
    if (allData.length < _minHeaderLength) {
      throw ArgumentError(
        'Insufficient data: data length ${allData.length} is less than the minimum required length of $_minHeaderLength bytes.',
      );
    }

    // Read schema (first 4 bytes)
    final schemaBytes = allData.sublist(0, _verLength);
    for (int i = 0; i < _verLength; i++) {
      if (schemaBytes[i] != _schema[i]) {
        throw ArgumentError(
          'Invalid file format: schema does not match ${ChaContant.verSchema}.',
        );
      }
    }
    int currentOffset = _verLength;

    // Read nonce (next 12 bytes)
    Uint8List nonce = Uint8List.fromList(
      allData.sublist(currentOffset, currentOffset + _nonceLength),
    );
    currentOffset += _nonceLength;

    // Read aad length (next 4 bytes, little-endian)
    ByteData aadLengthBlock = ByteData.sublistView(
      Uint8List.fromList(
        allData.sublist(currentOffset, currentOffset + _addLength),
      ),
    );
    int aadLength = aadLengthBlock.getUint32(0, Endian.little);
    currentOffset += _addLength;

    // Validate aad length, 16 bytes for tag, so at least 16 bytes should remain after reading aad
    if (currentOffset + aadLength + _tagLength > allData.length) {
      throw ArgumentError('Invalid aad length: exceeds remaining data.');
    }

    // Read aad data
    Uint8List aad = Uint8List.fromList(
      allData.sublist(currentOffset, currentOffset + aadLength),
    );
    currentOffset += aadLength;

    // Validate aad via callback
    if (aadValidator != null && !aadValidator!(aad)) {
      throw InvalidAadException(
        'AAD validation failed. The file may not be encrypted by ChaCha20Poly1305FileEncryptor or is invalid.',
      );
    }

    // Remaining data: ciphertext + tag
    int remainingLength = allData.length - currentOffset;
    if (remainingLength < _tagLength) {
      throw ArgumentError('Insufficient data for ciphertext and tag.');
    }
    List<int> ciphertextWithTag = allData.sublist(currentOffset);
    int ciphertextLength = ciphertextWithTag.length - _tagLength;
    List<int> ciphertext = ciphertextWithTag.sublist(0, ciphertextLength);
    List<int> tag = ciphertextWithTag.sublist(ciphertextLength);

    // Initialize Poly1305 MAC
    Uint8List polyKey = poly1305KeyGen(key, nonce);
    Poly1305Mac mac = Poly1305Mac(polyKey);

    // Process AAD
    if (aad.isNotEmpty) {
      mac.update(aad);
      mac.update(padding(aad.length));
    }

    // Update MAC with ciphertext
    mac.update(ciphertext);

    // Process padding for ciphertext
    int ciphertextPaddingLength =
        (_tagLength - (ciphertext.length % _tagLength)) % _tagLength;
    if (ciphertextPaddingLength > 0) {
      mac.update(Uint8List(ciphertextPaddingLength));
    }

    // Process lengths
    ByteData lengthBlock = ByteData(_tagLength)
      ..setUint64(0, aad.length, Endian.little)
      ..setUint64(8, ciphertext.length, Endian.little);

    mac.update(lengthBlock.buffer.asUint8List());

    // Compute expected tag
    Uint8List expectedTag = mac.finish();

    // Verify the authentication tag
    if (!constantTimeCompare(tag, expectedTag)) {
      throw AuthenticationException('Invalid authentication tag');
    }

    // Decrypt the ciphertext
    int counter = 1; // Starts from 1 as per specification
    List<int> plaintext = chacha20Encrypt(key, counter, nonce, ciphertext);

    // Yield decrypted data in chunks
    int offsetPlaintext = 0;
    int length = plaintext.length;

    while (offsetPlaintext < length) {
      int end = (offsetPlaintext + chunkSize <= length)
          ? offsetPlaintext + chunkSize
          : length;
      yield plaintext.sublist(offsetPlaintext, end);
      offsetPlaintext = end;
    }
  }
}
