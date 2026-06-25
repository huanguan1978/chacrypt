part of '../../../chapose.dart';

class DecryptCommand extends Command {
  @override
  final String name = 'decrypt';

  @override
  final String description = 'Decrypt a file using a password or a keyfile.\n\n'
      "e.g. decrypt using a password input. \n"
      "  chapose decrypt secret.data.cha -p \"Strong@Password#1\" \n\n"
      "e.g. decrypt using a keyfile. \n"
      "  chapose decrypt secret.data.cha -k chapose.key \n\n"
      "e.g. decrypt using the environment variable CHAPOSE_KEYFILE. \n"
      "  chapose decrypt secret.data.cha \n\n"
      "e.g. delete original ciphertext after decryption, force overwrite \n"
      "  chapose decrypt config.ini.cha -D -w \n\n"
      "e.g. Output to a spec directory \n"
      "  chapose decrypt client_info.csv.cha -d ./csvdata/";

  DecryptCommand() {
    argParser
      ..addOption('password', abbr: 'p', help: 'Password for decryption')
      ..addOption(
        'keyfile',
        abbr: 'k',
        help: 'Keyfile for decryption',
        valueHelp: 'file',
      )
      ..addOption('source', abbr: 's', help: 'Source file', valueHelp: 'file')
      ..addOption(
        'dest',
        abbr: 'd',
        help: 'Directory to save the output file (default: same as source)',
        valueHelp: 'dir',
      )
      ..addOption(
        'rename',
        abbr: 'n',
        help: 'Name for the decrypted file (default: source name without .cha)',
        valueHelp: 'file',
      )
      ..addFlag(
        'overwrite',
        abbr: 'w',
        help: 'toggle overwrite existing decrypted file',
        negatable: false,
        defaultsTo: false,
      )
      ..addFlag(
        'delete',
        abbr: 'D',
        help: 'Delete the original file after decryption',
        negatable: false,
        defaultsTo: false,
      );
  }

  @override
  String get invocation {
    var parents = [name];
    for (var command = parent; command != null; command = command.parent) {
      parents.add(command.name);
    }
    parents.add(runner!.executableName);

    var invocation = parents.reversed.join(' ');
    return subcommands.isNotEmpty
        ? '$invocation <subcommand> [arguments]'
        : '$invocation -p <password> | -k <keyfile> <source> [-d <dir>] [--name <file>] [-D| --delete]';
  }

  /// Validates the command-line arguments and returns a tuple indicating whether they are valid and an error message or the output location if valid.
  (bool, String) _checkOutput(ArgResults results) {
    String source = argResults?['source'] ?? argResults?.rest.first ?? '';
    final outputLocation = getOutputLocation(
      source,
      destDir: results['dest'] ?? '',
      destName: results['rename'] ?? '',
      isDecrypt: true,
    );

    final (outputOk, outputErr) = checkOutputLocation(
      outputLocation,
      outputOverwrite: results['overwrite'] ?? false,
      sourceLocation: source,
    );
    if (!outputOk) return (outputOk, outputErr);

    return (true, outputLocation);
  }

  @override
  void run() {
    final rest = argResults?.rest ?? [];
    String source = argResults?['source'] ?? '';
    if (source.isEmpty && rest.isNotEmpty) source = rest.first;

    final (sourceOk, sourceRes) = checkInputFile(source, isDecrypt: true);
    if (!sourceOk) die('Error: $sourceRes');

    final (outputOk, outputRes) = _checkOutput(argResults!);
    if (!outputOk) die('Error: $outputRes');

    final (keyOk, keyRes) = checkInputKey(argResults!);
    if (!keyOk) die('Error: $keyRes');

    final autoClean = argResults?['delete'] ?? false;
    // Proceed with encryption using the validated outputLocation

    final input = File(sourceRes);
    final output = File(outputRes);
    fileDecrypt(deriveKey(keyRes), input, output).then((result) {
      if (autoClean) {
        try {
          input.deleteSync();
        } on FileSystemException catch (e) {
          die('Error: ${e.osError?.message ?? e.message}"');
        }
      }
    }).catchError((error) {
      die('Error: decryption failed: $error');
    });
  }

  // cls_lastline
}
