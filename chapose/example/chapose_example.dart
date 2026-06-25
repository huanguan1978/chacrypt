import 'dart:io' as io;
import 'dart:typed_data' show Uint8List;

import 'package:chapose/chapose.dart';

void main() {
  final sectxt = 'YourStrongPassword#1';
  final seckey = deriveKey(sectxt);

  testFileEncrypt(seckey);
  // testFileDecrypt(seckey);
}

void testFileEncrypt(Uint8List key) {
  final inputFile = io.File('README_zh.md');
  final outputFile = io.File('README_zh.md.cha');

  fileEncrypt(key, inputFile, outputFile)
      .then((result) => print('Encryption completed.'))
      .catchError((error) {
    print('Encryption failed: $error');
  }).whenComplete(() => print('Operation finished'));
}

void testFileDecrypt(Uint8List key) {
  final inputFile = io.File('README_zh.md.cha');
  final outputFile = io.File('README_zh.txt');

  fileDecrypt(key, inputFile, outputFile)
      .then((result) => print('Decryption completed.'))
      .catchError((error) {
    print('Decryption failed: $error');
  }).whenComplete(() => print('Operation finished'));
}
