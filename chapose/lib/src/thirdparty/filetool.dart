part of '../../chapose.dart';

/// Copied from [filetools] (Repo: https://github.com/huanguan1978/ft)
/// Methods: resolvePath.
/// Update: Replace the implementation below with latest code from repo.

// --- Implementation ---

/// Resolves a [path] string into an absolute, normalized system path.
///
/// Expands `~` to the user's home directory and replaces environment
/// variables (e.g., `$VAR`) with their corresponding values, then
/// returns the absolute and normalized path.
String resolvePath(String path) {
  path = path.trim();
  if (path.isEmpty) return path;
  if (path.startsWith('~')) {
    final home =
        Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
    if (home != null) path = path.replaceFirst('~', home);
  }
  if (path.contains(r'$') || path.contains('%')) {
    if (Platform.isWindows) {
      // Windows: %VAR%
      path = path.replaceAllMapped(RegExp(r'%([^%]+)%'), (match) {
        return Platform.environment[match.group(1)!] ?? match.group(0)!;
      });
    } else {
      // POSIX: $VAR or ${VAR}
      path = path.replaceAllMapped(RegExp(r'\$(\w+|\{([^}]+)\})'), (match) {
        final varName = match.group(2) ?? match.group(1)!;
        return Platform.environment[varName] ?? match.group(0)!;
      });
    }
  }

  return p.normalize(p.absolute(path));
}
