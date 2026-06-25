part of '../../chapose.dart';

/// Copied from [patching] (Repo: https://github.com/huanguan1978/patching)
/// Methods: isPasswordSecure, generatePassword.
/// Update: Replace the implementation below with latest code from repo.

// --- Implementation ---

/// secure password check
///
/// the password must be eight characters and contain at least one uppercase character, at least one lowercase character and at least one number and at least one punctuation (!@#\$&*~).
///
///```dart
/// isPasswordSecure('Vignesh123!'); // true
/// isPasswordSecure('vignesh123'); // false
/// isPasswordSecure('VIGNESH123!'); // false
/// isPasswordSecure('vignesh@'); // false
/// isPasswordSecure('12345678?'); // false
///```
bool isPasswordSecure(String password, [int length = 8]) {
  const pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  final regexPassword = RegExp(pattern);
  return regexPassword.hasMatch(password);
}

/// generates a strong, random password
///
/// the password must be min eight characters and contain at least one uppercase character, at least one lowercase character and at least one number and at least one punctuation (!@#\$&*~).
///```dart
/// generatePassword(8); // C1$yRz!Y
///```
String generatePassword([int length = 8]) {
  const lowercase = 'abcdefghijklmnopqrstuvwxyz';
  const uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const numbers = '0123456789';
  const symbols = '!@#\$&*~'; // '!@#%^&*()_+-=[]{}|;:<>,.?/~';

  final lowerChars = lowercase.split('');
  final upperChars = uppercase.split('');
  final numberChars = numbers.split('');
  final symbolChars = symbols.split('');

  var passwdChars = <String>[];
  passwdChars.add((lowerChars..shuffle()).first);
  passwdChars.add((upperChars..shuffle()).first);
  passwdChars.add((numberChars..shuffle()).first);
  passwdChars.add((symbolChars..shuffle()).first);

  final allChars = [
    ...lowerChars,
    ...upperChars,
    ...numberChars,
    ...symbolChars,
  ];

  final random = Random.secure();
  allChars.shuffle(random);
  passwdChars.addAll(allChars.getRange(0, length - 4));
  passwdChars.shuffle(random);

  return passwdChars.join();
}
