// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String st_home_drawer_setting_cleanupLabel(String cleanup) {
    String _temp0 = intl.Intl.selectLogic(cleanup, {
      'keep': 'Keep',
      'delete': 'Delete',
      'wipelow': 'Erase(fill zeros)',
      'wipemedium': 'Erase(fill bits)',
      'wipehigh': 'Erase(fill rnds)',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_cleanupParam(String param) {
    String _temp0 = intl.Intl.selectLogic(param, {
      'level': 'Erase Level',
      'iter': 'Iterations',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_themeLabel(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'system': 'Auto',
      'light': 'Light',
      'dark': 'Dark',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_langLabel(String lang) {
    String _temp0 = intl.Intl.selectLogic(lang, {
      'en': 'English',
      'zh': 'Simplified Chinese',
      'hk': 'Traditional Chinese',
      'de': 'German',
      'ja': 'Japanese',
      'ru': 'Russian',
      'es': 'Spanish',
      'pt': 'Portuguese',
      'fr': 'French',
      'ko': 'Korean',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_applockLabel(String applock) {
    String _temp0 = intl.Intl.selectLogic(applock, {
      'none': 'None',
      'passphrase': 'Passphrase',
      'biometrics': 'Biometrics',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autolockLabel(String autolock) {
    String _temp0 = intl.Intl.selectLogic(autolock, {
      'm1': 'After 1 min',
      'm5': 'After 5 min',
      'm15': 'After 15 min',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autoccLabel(String autocc) {
    String _temp0 = intl.Intl.selectLogic(autocc, {
      's00': 'Disabled',
      's10': 'After 10 secs',
      's30': 'After 30 secs',
      's60': 'After 60 secs',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autosaveLabel(String autosave) {
    String _temp0 = intl.Intl.selectLogic(autosave, {
      's00': 'Disabled',
      's05': 'After 5 secs',
      's10': 'After 10 secs',
      's20': 'After 20 secs',
      's30': 'After 30 secs',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'theme': 'ThemeMode',
      'lang': 'Language',
      'secret': 'Secret',
      'applock': 'AppLock',
      'autolock': 'Auto-Lock',
      'autoclear': 'Clipboard-Clear',
      'autosave': 'Notes Auto Save',
      'cleanup': 'CleanUp',
      'overwrite': 'Overwrite existing files',
      'stats': 'Show vault stats',
      'mime': 'Custom MIME Types',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String cd_setting_mime(String status, Object tooltip) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'success': 'Loaded mime.types successfully.',
      'empty': 'Failed to load mime.types: data is empty.',
      'nottext': 'Failed to load mime.types: required text file.',
      'other': 'Other',
    });
    return '$_temp0 $tooltip';
  }

  @override
  String get st_setting_mime_tooltip =>
      'Load a mime.types file to extend MIME detection for filtering, icon classification, and packaging/auto-compress logic.';

  @override
  String st_home_drawer_directory_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'notes': 'Notes To Directory',
      'encrypt': 'Encrypted To Directory',
      'decrypt': 'Decrypted To Directory',
      'archive': 'Archived To Directory',
      'unarchive': 'UnArchived To Directory',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_nav_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'notes': 'Secure Notes',
      'vault': 'Secure Vault',
      'shredding': 'Secure Erase',
      'encrypt': 'Encrypt',
      'decrypt': 'Decrypt',
      'archive': 'Archive',
      'unarchive': 'UnArchive',
      'about': 'About',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_popup_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'copy': 'Copy',
      'copyto': 'Copy To...',
      'moveto': 'Move To...',
      'copypath': 'Copy Path',
      'rename': 'Rename...',
      'touch': 'Modify Date',
      'view': 'View',
      'edit': 'Edit',
      'delete': 'Delete',
      'erase': 'Erase',
      'save': 'Save',
      'saveto': 'Save To...',
      'reset': 'Reset',
      'clear': 'Clear',
      'refresh': 'Refresh',
      'pickenv': 'From Environment',
      'regen': 'Regenerate',
      'pickfile': 'Pick File',
      'pickfolder': 'Pick Folder',
      'openfile': 'Open File',
      'openfolder': 'Open Folder',
      'home': 'Home',
      'eula': 'EULA',
      'about': 'About',
      'help': 'Help',
      'quit': 'Quit',
      'share': 'Share',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_button_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'close': 'Close',
      'cancel': 'Cancel',
      'confirm': 'Confirm',
      'reset': 'Reset',
      'new_': 'New',
      'save': 'Save',
      'view': 'View',
      'variables': 'Variables',
      'accept': 'Agree',
      'copyall': 'Copy All',
      'pickfiles': 'Pick Files',
      'sharefiles': 'Share Files',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String get st_home_index_header_defaultTitle => 'Home';

  @override
  String get st_home_index_counter_incrementLabel =>
      'You have pushed the button this many times:';

  @override
  String get st_home_index_counter_incrementAction => 'Increment';

  @override
  String st_action_autocrypt_button_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'waiting': 'Waiting for File | Folder ...',
      'processing': 'Processing...',
      'encrypt': 'Encrypt File',
      'decrypt': 'Decrypt File',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String get st_common_global_info_independent =>
      'Note: Each item in the list is processed independently.';

  @override
  String get st_common_global_info_noGlobal =>
      'Note: Current setting changes apply only to this operation and will not be saved globally.';

  @override
  String get st_archive_global_info_compression =>
      'Note: Text files are compressed to .gz, while directories are packed and compressed to .tgz.';

  @override
  String get st_archive_global_info_independent =>
      'Note: Each item in the list is processed independently and not merged into a single archive.';

  @override
  String get st_decrypt_global_info_atomic =>
      'Atomic Decryption: This tool only decrypts files. If the result is a .tgz or .gz package, please use the \"Unarchive\" tool to extract it.';

  @override
  String get st_encrypt_global_info_atomic =>
      'Atomic Encryption: Only files are supported. To encrypt a directory, please use the \"Archive\" tool first to create a .tgz package.';

  @override
  String get st_unarchive_global_info_support =>
      'Note: Supports extraction of .gz (single files) and .tar, .tgz (directory packages).';

  @override
  String st_home_briefing_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'header': '💡 Daily Briefing',
      'helpHeader': '🌐 Help & Support',
      'doc': '📖 Documentation',
      'sponsor': '☕ Sponsor',
      'status': 'Vault Status',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String get st_multi_file_only_empty_hint => 'Drag & drop files here';

  @override
  String get st_single_path_empty_hint =>
      'Drag & drop file/folder, or select from menu';

  @override
  String get st_multi_path_empty_hint => 'Drag & drop files/folders here';

  @override
  String get st_multi_path_manage_title => 'Manage Paths';

  @override
  String get st_multi_path_paste_hint =>
      'Paste paths here (newline/comma separated)';

  @override
  String get st_common_dialog_unsaved_title => 'Unsaved Changes';

  @override
  String get cd_common_dialog_unsaved_body =>
      'You have unsaved content. Do you want to discard it and leave?';

  @override
  String get st_edit_text_hint => 'Start writing...';

  @override
  String get st_multi_path_add_tooltip => 'Add Paths';

  @override
  String get st_multi_path_add_from_input_tooltip => 'Add paths from input';

  @override
  String get st_multi_path_remove_tooltip => 'Remove this path';

  @override
  String st_common_form_field_label(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'dir': 'Monitored Directory',
      'pattern': 'Glob Pattern',
      'mime': 'Mimetype Part',
      'minSize': 'Min Size (bytes)',
      'maxSize': 'Max Size (bytes)',
      'startDate': 'Start Date',
      'endDate': 'End Date',
      'sortBy': 'Sort By',
      'sortOrder': 'Order',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String st_common_variables_body_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'appVarsTitle': 'Read-only app variables',
      'appVarsDesc':
          'These variables reflect the current app directory settings. Paths use POSIX separators (/). Tap the copy icon to insert the placeholder into your template.',
      'custVarsTitle': 'Custom variables',
      'custVarsDesc':
          'Variable names must start with a letter or underscore (e.g. myVar). Path values must use POSIX separators (e.g. /home/user/docs).',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String get rs_common_global_action_copied => 'Copied to clipboard';

  @override
  String get cd_common_action_edit_notTextFile => 'Only edit text file.';

  @override
  String get cd_common_action_view_notViewable =>
      'Only view (text | image) file.';

  @override
  String get rs_common_action_move_success => 'Moved!';

  @override
  String rs_common_action_file_error(Object err) {
    return 'Error: $err';
  }

  @override
  String get cd_common_action_rename_exists =>
      'File already exists. Delete it first.';

  @override
  String st_common_dialog_title(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': 'Rename',
      'delete': 'Delete File',
      'erase': 'Secure Erase File',
      'touch': 'Modify Date',
      'unsaved': 'Unsaved Changes',
      'applock': 'Enable App Lock',
      'filter': 'Filter Files',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String cd_common_dialog_confirm_message(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'delete': 'Are you sure you want to delete this file?',
      'erase': 'Are you sure you want to secure erase this file?',
      'unsaved':
          'You have unsaved content. Do you want to discard it and leave?',
      'applock':
          'Please confirm you have safely stored your passphrase or backup. If you enable app lock without credentials, you may be locked out and unable to access the app.',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String get cd_vault_action_security_check_failed => 'Security check failed.';

  @override
  String rs_edit_action_auto_save_failed(Object error) {
    return 'Auto-save failed: $error';
  }

  @override
  String get rs_edit_action_journal_saved => 'Journal Saved!';

  @override
  String rs_key_action_success(String action, Object path) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'regenerate': 'success, regenerate secret.',
      'save': 'success, save secret.',
      'saveto': 'success, saveto, $path.',
      'load': 'success, load from file.',
      'loadenv': 'success, load from environment, $path.',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String rs_edit_action_file_write_failed(Object error) {
    return 'file write failed: $error';
  }

  @override
  String cd_key_action_file_invalid(Object error) {
    return '$error';
  }

  @override
  String st_common_dialog_confirm_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': 'RENAME',
      'delete': 'DELETE',
      'erase': 'ERASE',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String rs_clipher_action_decryption_failed(Object error) {
    return 'Decryption failed: $error';
  }

  @override
  String rs_clipher_action_encryption_failed(Object error) {
    return 'Encryption failed: $error';
  }

  @override
  String rs_autocrypt_action_command_result(Object text) {
    return '$text';
  }

  @override
  String get cd_autocrypt_action_no_input => 'no input file selected';

  @override
  String common_auth_dialog_passwordTooShort_error(Object length) {
    return 'Password is too short (must be at least $length characters).';
  }

  @override
  String get common_auth_dialog_passwordInSecure_error =>
      'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character.';

  @override
  String get common_auth_dialog_passwordRequired_error =>
      'Must specify either a password or a keyfile.';

  @override
  String common_auth_dialog_fileNameIsSamed_error(Object file) {
    return 'file cannot be the same as the file: $file';
  }

  @override
  String get common_auth_dialog_fileNameIsEmpty_error => 'file name is empty.';

  @override
  String common_auth_dialog_fileIsExist_error(Object file) {
    return 'file already exist: $file .';
  }

  @override
  String common_auth_dialog_fileIsNotExist_error(Object file) {
    return 'file is not exist: $file .';
  }

  @override
  String common_auth_dialog_fileIsNotReadable_error(Object file) {
    return 'file is not readable: $file .';
  }

  @override
  String common_auth_dialog_fileIsNotWritable_error(Object file) {
    return 'file is not writable: $file .';
  }

  @override
  String common_auth_dialog_PathIsNotWritable_error(Object file) {
    return 'file path is not writable: $file .';
  }

  @override
  String common_auth_dialog_fileIsEmpty_error(Object file) {
    return 'file is empty: $file .';
  }

  @override
  String common_auth_dialog_fileIsEncrypted_error(Object file) {
    return 'file is already encrypted: $file .';
  }

  @override
  String common_auth_dialog_fileIsDecrypted_error(Object file) {
    return 'file type is not an decrypted file: $file .';
  }
}
