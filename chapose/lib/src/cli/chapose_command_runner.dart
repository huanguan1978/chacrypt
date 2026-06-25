part of '../../chapose.dart';

class ChaposeCommandRunner extends CommandRunner {
  ChaposeCommandRunner()
      : super(
          'chapose',
          'A high-performance CLI tool for secure file encryption/decryption. \npowered by ChaCha20-Poly1305, \nit provides robust, efficient, and reliable protection for professional users.',
        ) {
    addCommand(EncryptCommand());
    addCommand(DecryptCommand());
    addCommand(KeyfileCommand());
  }
}
