part of '../../chapose.dart';

enum CliMessageDefinition implements MessageEnum {
  passwordTooShort(
    10011,
    'common_auth_dialog_passwordTooShort_error',
    'Password is too short (must be at least {length} characters).',
    '',
    exit: 1,
    level: ML.WARNING,
    param: {'length': '8'},
  ),

  passwordInSecure(
    10012,
    'common_auth_dialog_passwordInSecure_error',
    'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character.',
    '',
    exit: 1,
    level: ML.WARNING,
  ),

  passwordRequired(
    10013,
    'common_auth_dialog_passwordRequired_error',
    'Must specify either a password or a keyfile.',
    '',
    exit: 1,
    level: ML.WARNING,
  ),

  fileNameIsSamed(
    10020,
    'common_auth_dialog_fileNameIsSamed_error',
    'file cannot be the same as the file: {file}',
    '',
    exit: 1,
    level: ML.WARNING,
    param: {'file': 'myfile'},
  ),

  fileNameIsEmpty(
    10021,
    'common_auth_dialog_fileNameIsEmpty_error',
    'file name is empty.',
    '',
    exit: 1,
    level: ML.WARNING,
  ),

  fileIsExist(
    10022,
    'common_auth_dialog_fileIsExist_error',
    'file already exist: {file} .',
    '',
    exit: 1,
    level: ML.WARNING,
    param: {'file': 'myfile'},
  ),

  fileIsNotExist(
    10023,
    'common_auth_dialog_fileIsNotExist_error',
    'file is not exist: {file} .',
    '',
    exit: 1,
    level: ML.WARNING,
    param: {'file': 'myfile'},
  ),

  fileIsNotReadable(
    10024,
    'common_auth_dialog_fileIsNotReadable_error',
    'file is not readable: {file} .',
    '',
    exit: 1,
    level: ML.WARNING,
    param: {'file': 'myfile'},
  ),

  fileIsNotWritable(
    10025,
    'common_auth_dialog_fileIsNotWritable_error',
    'file is not writable: {file} .',
    '',
    exit: 1,
    level: ML.WARNING,
    param: {'file': 'myfile'},
  ),
  filePathIsNotWritable(
    10026,
    'common_auth_dialog_PathIsNotWritable_error',
    'file path is not writable: {file} .',
    '',
    exit: 1,
    level: ML.WARNING,
    param: {'file': 'myfile'},
  ),

  fileIsEmpty(
    10027,
    'common_auth_dialog_fileIsEmpty_error',
    'file is empty: {file} .',
    '',
    exit: 1,
    level: ML.WARNING,
    param: {'file': 'myfile'},
  ),

  fileIsEncrypted(
    10028,
    'common_auth_dialog_fileIsEncrypted_error',
    'file is already encrypted: {file} .',
    '',
    exit: 1,
    level: ML.WARNING,
    param: {'file': 'myfile'},
  ),

  fileIsDecrypted(
    10029,
    'common_auth_dialog_fileIsDecrypted_error',
    'file type is not an decrypted file: {file} .',
    '',
    exit: 1,
    level: ML.WARNING,
    param: {'file': 'myfile'},
  );

  @override
  final int code;
  @override
  final String key;
  @override
  final String msg;
  @override
  final Map<String, Object> param;
  @override
  final String desc;
  @override
  final MessageLevel level;
  @override
  final int exit;

  const CliMessageDefinition(
    this.code,
    this.key,
    this.msg,
    this.desc, {
    this.param = const {},
    // ignore: unused_element_parameter
    this.level = MessageLevel.INFO,
    // ignore: unused_element_parameter
    this.exit = 0,
  });
}
