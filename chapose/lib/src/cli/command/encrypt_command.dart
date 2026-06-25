part of '../../../chapose.dart';

class EncryptCommand extends Command {
  @override
  final String name = 'encrypt';

  @override
  final String description = 'Encrypt a file using a password or a keyfile.\n\n'
      "e.g. encrypt using a password input. \n"
      "  chapose encrypt secret.data -p \"Strong@Password#1\" \n\n"
      "e.g. encrypt using a keyfile. \n"
      "  chapose encrypt secret.data -k chapose.key \n\n"
      "e.g. encrypt using the environment variable CHAPOSE_KEYFILE. \n"
      "  chapose encrypt secret.data \n\n"
      "e.g. delete original plaintext after encryption, force overwrite \n"
      "  chapose encrypt raw.log -D -w \n\n"
      "e.g. Output to a secure vault directory \n"
      "  chapose encrypt client_info.csv -d ./vault/";

  EncryptCommand() {
    argParser
      ..addOption('password', abbr: 'p', help: 'Password for encryption')
      ..addOption(
        'keyfile',
        abbr: 'k',
        help:
            'Keyfile for encryption. Overrides password if both are provided.',
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
        help: 'Name for the encrypted file (default: source name + .cha)',
        valueHelp: 'file',
      )
      ..addFlag(
        'overwrite',
        abbr: 'w',
        help: 'toggle overwrite existing encrypted file',
        negatable: false,
        defaultsTo: false,
      )
      ..addFlag(
        'delete',
        abbr: 'D',
        help: 'Delete the original file after encryption',
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
        : '$invocation -p <password> | -k <keyfile> <source> [-d <dir>] [--name <file>] [-w] [-D]';
  }

  /// Validates the command-line arguments and returns a tuple indicating whether they are valid and an error message or the output location if valid.
  (bool, String) _checkOutput(ArgResults results) {
    String source = argResults?['source'] ?? argResults?.rest.first ?? '';
    final outputLocation = getOutputLocation(
      source,
      destDir: results['dest'] ?? '',
      destName: results['rename'] ?? '',
      isEncrypt: true,
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

    final (sourceOk, sourceRes) = checkInputFile(source, isEncrypt: true);
    if (!sourceOk) die('Error: $sourceRes');

    final (outputOk, outputRes) = _checkOutput(argResults!);
    if (!outputOk) die('Error: $outputRes');

    final (keyOk, keyRes) = checkInputKey(argResults!);
    if (!keyOk) die('Error: $keyRes');

    final autoClean = argResults?['delete'] ?? false;
    // Proceed with encryption using the validated outputLocation

    final input = File(sourceRes);
    final output = File(outputRes);

    fileEncrypt(deriveKey(keyRes), input, output).then((result) {
      if (autoClean) {
        try {
          input.deleteSync();
        } on FileSystemException catch (e) {
          die('Error: ${e.osError?.message ?? e.message}"');
        }
      }
    }).catchError((error) {
      die('Error: encryption failed, $error');
    });
  }

  // cls_lastline
}
