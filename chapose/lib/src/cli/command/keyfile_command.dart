part of '../../../chapose.dart';

class KeyfileCommand extends Command {
  @override
  final String name = 'keyfile';

  @override
  final String description =
      'Keyfile generate for encryption | decryption.\n\n'
      "e.g. generate a default keyfile (chapose.key). \n"
      "  chapose keyfile \n\n"
      "e.g. custom output and force overwrite. \n"
      "  chapose keyfile -p \"Strong@Password#1\" -o ~/.ssh/chapose.key";

  KeyfileCommand() {
    argParser
      ..addOption(
        'password',
        abbr: 'p',
        help: 'Password to generate the keyfile',
        valueHelp: 'PASSWORD',
      )
      ..addOption(
        'output',
        abbr: 'o',
        help: 'Output location for keyfile',
        defaultsTo: 'chapose.key',
        valueHelp: 'file',
      )
      ..addFlag(
        'overwrite',
        abbr: 'w',
        help: 'toggle overwrite existing keyfile',
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
        : '$invocation [-p| --password <PASSWORD>] [-o| --output <file>] [-w| --overwrite]';
  }

  @override
  void run() {
    var password = argResults?['password'] ?? '';
    final output = argResults?['output'] ?? 'chapose.key';
    final overwrite = argResults?['overwrite'] ?? false;

    if (password.isNotEmpty) {
      final (passwordOk, passwordErr) = checkInputPassword(password);
      if (!passwordOk) die(passwordErr);
    }

    final (outputOk, outputErr) = checkOutputLocation(
      output,
      outputOverwrite: overwrite,
    );
    if (!outputOk) die(outputErr);

    final generated = generateKeyfile(output, password);
    if (!generated) die('Failed to generate keyfile at: $output');

    // print('Keyfile generated successfully at: $output');
  }

  // cls_lastline
}
