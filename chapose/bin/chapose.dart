import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:chapose/chapose.dart';

void main(List<String> args) {
  // ME.init(CliMessageProvider());

  final runner = ChaposeCommandRunner();
  runner.run(args).catchError((error) {
    if (error is UsageException) {
      print(error);
      exit(64); // Exit code 64 indicates a usage error.
    } else {
      print('An unexpected error occurred: $error');
      exit(1); // Exit code 1 indicates a general error.
    }
  });
}
