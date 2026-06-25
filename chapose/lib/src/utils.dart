part of '../chapose.dart';

/// calculate SHA256 checksum
String sha256sum(String text) =>
    crypto.sha256.convert(text.codeUnits).toString();

/// Derives a 32-byte key from a user-provided string using SHA-256 hashing.
/// This allows users to use memorable passwords while ensuring the key is of the correct length for Cha20-Poly1305 encryption.
Uint8List deriveKey(String userKey) =>
    Uint8List.fromList(crypto.sha256.convert(userKey.codeUnits).bytes);

/// Prints an error message to stderr and exits the program with the specified exit code (default is 1).
Never die(String message, [int exitCode = 1]) {
  stderr.writeln(message);
  exit(exitCode);
}

/// generate a keyfile with the given password and save it to the specified location.
///
/// If the password is null or empty, a random password will be generated.
/// Returns true if the keyfile was successfully generated.
bool generateKeyfile(String keyfile, String? password) {
  if (password == null || password.isEmpty) {
    password = generatePassword(ChaContant.userKeyDefaultLength);
  }

  keyfile = resolvePath(keyfile);
  final file = File(keyfile);
  file.writeAsStringSync(password, flush: true);
  return true;
}

/// validates the password argument and returns a tuple indicating whether it is valid and an error message if not.
(bool, String) checkInputPassword(String password) {
  if (password.isNotEmpty) {
    if (password.length < ChaContant.userKeyMinLength) {
      return (false, ME.tr(MD.passwordTooShort));
    }

    if (!isPasswordSecure(password, password.length)) {
      return (false, ME.tr(MD.passwordInSecure));
    }
  }

  return (true, password);
}

/// Validates the password and keyfile arguments and returns a tuple indicating whether they are valid and an error message or the resolved password if valid.
(bool, String) checkInputKey(ArgResults results) {
  String password = results['password'] ?? '';
  String keyfile = results['keyfile'] ?? '';
  if (keyfile.isEmpty) keyfile = envKeyfile;

  if (password.isEmpty && keyfile.isEmpty) {
    return (false, ME.tr(MD.passwordRequired));
  }
  if (password.isNotEmpty) {
    final (passwordOk, passwordErr) = checkInputPassword(password);
    if (!passwordOk) return (passwordOk, passwordErr);
  } else {
    if (keyfile.isNotEmpty) {
      final (keyfileOk, keyfileRes) = checkInputFile(keyfile);
      if (!keyfileOk) return (keyfileOk, keyfileRes);

      keyfile = keyfileRes;
      final key = File(keyfile).readAsStringSync().trim();
      if (key.isEmpty) {
        return (false, ME.tr(MD.fileIsEmpty, args: {'file': keyfile}));
      }

      password = key;
    }
  }

  password = password.trim();
  if (password.length < ChaContant.userKeyMinLength) {
    return (false, ME.tr(MD.passwordTooShort));
  }

  if (!isPasswordSecure(password, password.length)) {
    return (false, ME.tr(MD.passwordInSecure));
  }

  return (true, password);
}

/// Validates the input file path and returns a tuple indicating whether it is valid and an error message if not.
(bool, String) checkInputFile(
  String path, {
  bool isEncrypt = false,
  bool isDecrypt = false,
}) {
  if (path.isEmpty) return (false, ME.tr(MD.fileNameIsEmpty));
  path = resolvePath(path);

  final file = File(path);
  if (!file.existsSync()) {
    return (false, ME.tr(MD.fileIsNotExist, args: {'file': path}));
  }
  if (!file.statSync().modeString().contains('r')) {
    return (false, ME.tr(MD.fileIsNotReadable, args: {'file': path}));
  }

  if (file.statSync().size == 0) {
    return (false, ME.tr(MD.fileIsEmpty, args: {'file': path}));
  }

  if (isEncrypt && file.path.endsWith(ChaContant.extName)) {
    return (false, ME.tr(MD.fileIsEncrypted, args: {'file': path}));
  }

  if (isDecrypt && !file.path.endsWith(ChaContant.extName)) {
    return (false, ME.tr(MD.fileIsDecrypted, args: {'file': path}));
  }

  return (true, path);
}

/// Generates the output file path based on the source file path and provided options.
String getOutputLocation(
  String sourceFile, {
  String destDir = '',
  String destName = '',
  bool isEncrypt = false,
  bool isDecrypt = false,
}) {
  sourceFile = resolvePath(sourceFile);
  destDir = resolvePath(destDir);

  final sourceFileName = sourceFile.split(Platform.pathSeparator).last;
  var outputFilename = destName;
  if (outputFilename.isEmpty) outputFilename = sourceFileName;

  if (isEncrypt || isDecrypt) {
    if (isEncrypt && !outputFilename.endsWith(ChaContant.extName)) {
      outputFilename += ChaContant.extName;
    }
    if (isDecrypt && outputFilename.endsWith(ChaContant.extName)) {
      outputFilename = outputFilename.substring(
        0,
        outputFilename.length - ChaContant.extName.length,
      );
    }
  }

  if (destDir.isEmpty) {
    destDir = Directory(sourceFile).parent.path;
  }
  final location = '$destDir${Platform.pathSeparator}$outputFilename';
  return location;
}

/// Validates the output file path and returns a tuple indicating whether it is valid and an error message if not.
(bool, String) checkOutputLocation(
  String outputLocation, {

  bool outputOverwrite = false,
  String sourceLocation = '',
}) {
  outputLocation = resolvePath(outputLocation);
  sourceLocation = resolvePath(sourceLocation);

  if (sourceLocation == outputLocation) {
    return (false, ME.tr(MD.fileNameIsSamed, args: {'file': outputLocation}));
  }
  final file = File(outputLocation);
  if (file.existsSync()) {
    if (!outputOverwrite) {
      return (false, ME.tr(MD.fileIsExist, args: {'file': outputLocation}));
    }
    if (!file.statSync().modeString().contains('w')) {
      return (
        false,
        ME.tr(MD.fileIsNotWritable, args: {'file': outputLocation}),
      );
    }
  } else {
    try {
      file.createSync(recursive: true);
      file.deleteSync();
    } on IOException {
      return (
        false,
        ME.tr(MD.filePathIsNotWritable, args: {'file': outputLocation}),
      );
    }
  }
  return (true, outputLocation);
}
