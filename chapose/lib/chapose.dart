/// Support for doing something awesome.
///
/// More dartdocs go here.
// ignore_for_file: implementation_imports

library;

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:intl/intl.dart';

import 'package:fastcrypt/src/core/constants.dart' show FastCryptContants;
import 'package:fastcrypt/src/core/utils.dart'
    show poly1305KeyGen, chacha20Encrypt, padding, constantTimeCompare;
import 'package:fastcrypt/src/algorithms/poly1305_mac.dart' show Poly1305Mac;
// import 'package:fastcrypt/src/exceptions/authentication_exception.dart';
import 'package:fastcrypt/fastcrypt.dart';

import 'package:basic_message/basic_message.dart';
import 'package:path/path.dart' as p;

part 'src/message/provider.dart';
part 'src/message/definition.dart';
part 'src/thirdparty/patching.dart';
part 'src/thirdparty/filetool.dart';

part 'src/utils.dart';

part 'src/chapose_base.dart';
part 'src/exceptions/invalid_aad_exception.dart';
part 'src/streams/file_encryptor.dart';
part 'src/streams/file_decryptor.dart';

part 'src/cli/command/encrypt_command.dart';
part 'src/cli/command/decrypt_command.dart';
part 'src/cli/command/keyfile_command.dart';
part 'src/cli/chapose_command_runner.dart';

// export 'src/chapose_base.dart';
