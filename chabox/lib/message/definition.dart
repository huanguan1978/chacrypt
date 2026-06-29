/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'package:basic_message/basic_message.dart';

typedef ME = MessageEngine;
typedef ML = MessageLevel;
typedef MD = GuiMessageDefinition;

enum GuiMessageDefinition implements MessageEnum {
  /// st_home_drawer_setting_cleanupLabel
  stHomeDrawerSettingCleanupLabel(
    20010,
    'st_home_drawer_setting_cleanupLabel',
    '{cleanup, select, keep{Keep} delete{Delete} wipelow{Erase(fill zeros)} wipemedium{Erase(fill bits)} wipehigh{Erase(fill rnds)} other{Other}}',
    'Setting cleanup (keep | delete | wipelow | wipemedium | wipehigh ) to (Keep | Delete | WipeLow | WipeMedium | WipeHigh).',
    param: {'cleanup': 'keep'},
  ),

  /// st_home_drawer_setting_cleanupParam
  stHomeDrawerSettingCleanupParam(
    20011,
    'st_home_drawer_setting_cleanupParam',
    '{param, select, level{Erase Level} iter{Iterations} other{Other}}',
    'Setting cleanup param (level | iter) to (EraseLevel | Iterations).',
    param: {'param': 'level'},
  ),

  /// st_home_drawer_setting_themeLabel
  stHomeDrawerSettingThemeLabel(
    20012,
    'st_home_drawer_setting_themeLabel',
    '{theme, select, system{Auto} light{Light} dark{Dark} other{Other}}',
    'Setting theme (system | light | dark) to (Auto | Light | Dark).',
    param: {'theme': 'system'},
  ),

  /// st_home_drawer_setting_langLabel
  stHomeDrawerSettingLangLabel(
    20013,
    'st_home_drawer_setting_langLabel',
    '{lang, select, en{English} zh{Simplified Chinese} hk{Traditional Chinese} de{German} ja{Japanese} ru{Russian} es{Spanish} pt{Portuguese} fr{French} ko{Korean} other{Other}}',
    'Setting lang (en | zh | hk | de | ja | ru | es | pt | fr | ko) to (English | Simplified Chinese | Traditional Chinese | German | Japanese | Russian | Spanish | Portuguese | French | Korean).',
    param: {'lang': 'en'},
  ),

  /// st_home_drawer_setting_applockLabel
  stHomeDrawerSettingApplockLabel(
    20014,
    'st_home_drawer_setting_applockLabel',
    '{applock, select, none{None} passphrase{Passphrase} biometrics{Biometrics} other{Other}}',
    'Setting applock (none | passphrase | biometrics) to (None | Passphrase | Biometrics).',
    param: {'applock': 'none'},
  ),

  /// st_home_drawer_setting_autolockLabel
  stHomeDrawerSettingAutolockLabel(
    20015,
    'st_home_drawer_setting_autolockLabel',
    '{autolock, select, m1{After 1 min} m5{After 5 min} m15{After 15 min} other{Other}}',
    'Setting autolock (m1 | m5 | m15) to (After 1 | 5 | 15 min).',
    param: {'autolock': 'm5'},
  ),

  /// st_home_drawer_setting_autoccLabel
  stHomeDrawerSettingAutoccLabel(
    20016,
    'st_home_drawer_setting_autoccLabel',
    '{autocc, select, s00{Disabled} s10{After 10 secs} s30{After 30 secs} s60{After 60 secs} other{Other}}',
    'Setting autocc (s00 | s10 | s30 | s60) to (Disabled | After 10 | 30 | 60 secs).',
    param: {'autocc': 's30'},
  ),

  /// st_home_drawer_setting_autosaveLabel
  stHomeDrawerSettingAutosaveLabel(
    20017,
    'st_home_drawer_setting_autosaveLabel',
    '{autosave, select, s00{Disabled} s05{After 5 secs} s10{After 10 secs} s20{After 20 secs} s30{After 30 secs} other{Other}}',
    'Setting autosave (s00 | s05 | s10 | s20 | s30) to (Disabled | After 5 | 10 | 20 | 30 secs).',
    param: {'autosave': 's30'},
  ),

  /// st_home_drawer_setting_title
  stHomeDrawerSettingTitle(
    20018,
    'st_home_drawer_setting_title',
    '{title, select, theme{ThemeMode} lang{Language} secret{Secret} applock{AppLock} autolock{Auto-Lock} autoclear{Clipboard-Clear} autosave{Notes Auto Save} cleanup{CleanUp} overwrite{Overwrite existing files} stats{Show vault stats} mime{Custom MIME Types} other{Other}}',
    'Setting titles in drawer.',
    param: {'title': 'theme'},
  ),

  /// st_home_drawer_directory_title
  stHomeDrawerDirectoryTitle(
    20019,
    'st_home_drawer_directory_title',
    '{title, select, notes{Notes To Directory} encrypt{Encrypted To Directory} decrypt{Decrypted To Directory} archive{Archived To Directory} unarchive{UnArchived To Directory} other{Other}}',
    'Directory titles in drawer.',
    param: {'title': 'theme'},
  ),

  /// st_common_global_nav_actionLabel
  stCommonGlobalNavActionLabel(
    20031,
    'st_common_global_nav_actionLabel',
    '{action, select, notes{Secure Notes} vault{Secure Vault} shredding{Secure Erase} encrypt{Encrypt} decrypt{Decrypt} archive{Archive} unarchive{UnArchive} about{About} other{Other}}',
    'Navigation action labels.',
    param: {'action': 'about'},
  ),

  /// st_common_global_popup_actionLabel
  stCommonGlobalPopupActionLabel(
    20032,
    'st_common_global_popup_actionLabel',
    '{action, select, copy{Copy} copyto{Copy To...} moveto{Move To...} copypath{Copy Path} rename{Rename...} touch{Modify Date} view{View} edit{Edit} delete{Delete} erase{Erase} save{Save} saveto{Save To...} reset{Reset} clear{Clear} refresh{Refresh} pickenv{From Environment} regen{Regenerate} pickfile{Pick File} pickfolder{Pick Folder} openfile{Open File} openfolder{Open Folder} home{Home} eula{EULA} about{About} help{Help} quit{Quit} share{Share} other{Other}}',
    'Popup menu action labels.',
    param: {'action': 'view'},
  ),

  /// st_common_global_button_actionLabel
  stCommonGlobalButtonActionLabel(
    20033,
    'st_common_global_button_actionLabel',
    '{action, select, close{Close} cancel{Cancel} confirm{Confirm} reset{Reset} new_{New} save{Save} view{View} variables{Variables} accept{Agree} copyall{Copy All} pickfiles{Pick Files} sharefiles{Share Files} other{Other}}',
    'Standard button action labels.',
    param: {'action': 'view'},
  ),

  /// st_home_index_header_defaultTitle
  stHomeIndexHeaderDefaultTitle(
    20091,
    'st_home_index_header_defaultTitle',
    'Home',
    'Default home page header title.',
  ),

  /// st_home_index_counter_incrementLabel
  stHomeIndexCounterIncrementLabel(
    20092,
    'st_home_index_counter_incrementLabel',
    'You have pushed the button this many times:',
    'Counter label for testing.',
  ),

  /// st_home_index_counter_incrementAction
  stHomeIndexCounterIncrementAction(
    20093,
    'st_home_index_counter_incrementAction',
    'Increment',
    'Counter action button for testing.',
  ),

  /// st_action_autocrypt_button_label
  stActionAutocryptButtonLabel(
    20021,
    'st_action_autocrypt_button_label',
    '{action, select, waiting{Waiting for File | Folder ...} processing{Processing...} encrypt{Encrypt File} decrypt{Decrypt File} other{Other}}',
    'Autocrypt action button labels.',
    param: {'action': 'waiting'},
  ),

  /// st_common_global_info_independent
  stCommonGlobalInfoIndependent(
    20411,
    'st_common_global_info_independent',
    'Note: Each item in the list is processed independently.',
    'Common note for independent processing.',
  ),

  /// st_common_global_info_noGlobal
  stCommonGlobalInfoNoGlobal(
    20412,
    'st_common_global_info_noGlobal',
    'Note: Current setting changes apply only to this operation and will not be saved globally.',
    'Common note for session-only settings.',
  ),

  /// st_archive_global_info_compression
  stArchiveGlobalInfoCompression(
    20413,
    'st_archive_global_info_compression',
    'Note: Text files are compressed to .gz, while directories are packed and compressed to .tgz.',
    'Archive compression info.',
  ),

  /// st_archive_global_info_independent
  stArchiveGlobalInfoIndependent(
    20414,
    'st_archive_global_info_independent',
    'Note: Each item in the list is processed independently and not merged into a single archive.',
    'Archive independent processing info.',
  ),

  /// st_decrypt_global_info_atomic
  stDecryptGlobalInfoAtomic(
    20415,
    'st_decrypt_global_info_atomic',
    'Atomic Decryption: This tool only decrypts files. If the result is a .tgz or .gz package, please use the "Unarchive" tool to extract it.',
    'Decrypt atomic operation info.',
  ),

  /// st_encrypt_global_info_atomic
  stEncryptGlobalInfoAtomic(
    20416,
    'st_encrypt_global_info_atomic',
    'Atomic Encryption: Only files are supported. To encrypt a directory, please use the "Archive" tool first to create a .tgz package.',
    'Encrypt atomic operation info.',
  ),

  /// st_unarchive_global_info_support
  stUnarchiveGlobalInfoSupport(
    20417,
    'st_unarchive_global_info_support',
    'Note: Supports extraction of .gz (single files) and .tar, .tgz (directory packages).',
    'Unarchive support info.',
  ),

  /// st_home_briefing_label
  stHomeBriefingLabel(
    20501,
    'st_home_briefing_label',
    '{label, select, header{💡 Daily Briefing} helpHeader{🌐 Help & Support} doc{📖 Documentation} sponsor{☕ Sponsor} status{Vault Status} other{Other}}',
    'Static text labels for BriefingView.',
    param: {'label': 'header'},
  ),

  /// st_multi_file_only_empty_hint
  stMultiFileOnlyEmptyHint(
    20599,
    'st_multi_file_only_empty_hint',
    'Drag & drop files here',
    'Hint text for multi file input.',
  ),

  /// st_single_path_empty_hint
  stSinglePathEmptyHint(
    20600,
    'st_single_path_empty_hint',
    'Drag & drop file/folder, or select from menu',
    'Hint text for single path input.',
  ),

  /// st_multi_path_empty_hint
  stMultiPathEmptyHint(
    20601,
    'st_multi_path_empty_hint',
    'Drag & drop files/folders here',
    'Hint text when MultiPath list is empty.',
  ),

  /// st_multi_path_manage_title
  stMultiPathManageTitle(
    20602,
    'st_multi_path_manage_title',
    'Manage Paths',
    'Title for path management dialog.',
  ),

  /// st_multi_path_paste_hint
  stMultiPathPasteHint(
    20603,
    'st_multi_path_paste_hint',
    'Paste paths here (newline/comma separated)',
    'Hint text for path pasting.',
  ),

  /// st_common_dialog_unsaved_title
  stCommonDialogUnsavedTitle(
    20103,
    'st_common_dialog_unsaved_title',
    'Unsaved Changes',
    'Common dialog title for unsaved changes.',
  ),

  /// cd_common_dialog_unsaved_body
  cdCommonDialogUnsavedBody(
    21102,
    'cd_common_dialog_unsaved_body',
    'You have unsaved content. Do you want to discard it and leave?',
    'Common dialog message for unsaved changes.',
  ),

  /// st_edit_text_hint
  stEditTextHint(
    20604,
    'st_edit_text_hint',
    'Start writing...',
    'Hint text for the text editor.',
  ),

  /// st_multi_path_add_tooltip
  stMultiPathAddTooltip(
    20605,
    'st_multi_path_add_tooltip',
    'Add Paths',
    'Tooltip for adding paths.',
  ),

  /// st_multi_path_add_from_input_tooltip
  stMultiPathAddFromInputTooltip(
    20606,
    'st_multi_path_add_from_input_tooltip',
    'Add paths from input',
    'Tooltip for adding paths from the text input field.',
  ),

  /// st_multi_path_remove_tooltip
  stMultiPathRemoveTooltip(
    20607,
    'st_multi_path_remove_tooltip',
    'Remove this path',
    'Tooltip for removing a single path from the list.',
  ),

  /// st_common_form_field_label
  stCommonFormFieldLabel(
    20104,
    'st_common_form_field_label',
    '{field, select, dir{Monitored Directory} pattern{Glob Pattern} mime{Mimetype Part} minSize{Min Size (bytes)} maxSize{Max Size (bytes)} startDate{Start Date} endDate{End Date} sortBy{Sort By} sortOrder{Order} other{Other}}',
    'Common labels for form fields.',
    param: {'field': 'dir'},
  ),

  /// st_common_variables_body_label
  stCommonVariablesBodyLabel(
    20105,
    'st_common_variables_body_label',
    '{label, select, appVarsTitle{Read-only app variables} appVarsDesc{These variables reflect the current app directory settings. Paths use POSIX separators (/). Tap the copy icon to insert the placeholder into your template.} custVarsTitle{Custom variables} custVarsDesc{Variable names must start with a letter or underscore (e.g. myVar). Path values must use POSIX separators (e.g. /home/user/docs).}  other{Other}}',
    'Template variables.',
    param: {'label': ''},
  ),

  /// rs_common_global_action_copied
  rsCommonGlobalActionCopied(
    22001,
    'rs_common_global_action_copied',
    'Copied to clipboard',
    'Success feedback for copy operation.',
    level: ML.INFO,
  ),

  /// cd_common_action_edit_notTextFile
  cdCommonActionEditNotTextFile(
    21002,
    'cd_common_action_edit_notTextFile',
    'Only edit text file.',
    'Validation error: attempted to edit a non-text file.',
    level: ML.WARNING,
  ),

  /// cd_common_action_view_notViewable
  cdCommonActionViewNotViewable(
    21003,
    'cd_common_action_view_notViewable',
    'Only view (text | image) file.',
    'Validation error: attempted to view a non-viewable file.',
    level: ML.WARNING,
  ),

  /// rs_common_action_move_success
  rsCommonActionMoveSuccess(
    22005,
    'rs_common_action_move_success',
    'Moved!',
    'Success feedback for move operation.',
    level: ML.INFO,
  ),

  /// rs_common_action_file_error
  rsCommonActionFileError(
    22006,
    'rs_common_action_file_error',
    'Error: {err}',
    'Error feedback for file operations.',
    param: {'err': 'unknown error'},
    level: ML.SEVERE,
  ),

  /// cd_common_action_rename_exists
  cdCommonActionRenameExists(
    21007,
    'cd_common_action_rename_exists',
    'File already exists. Delete it first.',
    'Validation error: rename operation collision.',
    level: ML.WARNING,
  ),

  /// st_common_dialog_title
  stCommonDialogTitle(
    20101,
    'st_common_dialog_title',
    '{action, select, rename{Rename} delete{Delete File} erase{Secure Erase File} touch{Modify Date} unsaved{Unsaved Changes} applock{Enable App Lock} other{Other}}',
    'Common dialog titles.',
    param: {'action': 'rename'},
  ),

  /// cd_common_dialog_confirm_message
  cdCommonDialogConfirmMessage(
    21101,
    'cd_common_dialog_confirm_message',
    '{action, select, delete{Are you sure you want to delete this file?} erase{Are you sure you want to secure erase this file?} unsaved{You have unsaved content. Do you want to discard it and leave?} applock{Please confirm you have safely stored your passphrase or backup. If you enable app lock without credentials, you may be locked out and unable to access the app.} other{Other}}',
    'Common dialog confirmation messages.',
    param: {'action': 'delete'},
  ),

  /// cd_vault_action_security_check_failed
  cdVaultActionSecurityCheckFailed(
    21201,
    'cd_vault_action_security_check_failed',
    'Security check failed.',
    'Validation error: vault security check failed.',
    level: ML.WARNING,
  ),

  /// rs_edit_action_auto_save_failed
  rsEditActionAutoSaveFailed(
    22201,
    'rs_edit_action_auto_save_failed',
    'Auto-save failed: {error}',
    'Error feedback for auto-save operation failure.',
    param: {'error': 'unknown error'},
    level: ML.SEVERE,
  ),

  /// rs_edit_action_journal_saved
  rsEditActionJournalSaved(
    22202,
    'rs_edit_action_journal_saved',
    'Journal Saved!',
    'Success feedback for journal save operation.',
    level: ML.INFO,
  ),

  /// rs_key_action_success
  rsKeyActionSuccess(
    22301,
    'rs_key_action_success',
    '{action, select, regenerate{success, regenerate secret.} save{success, save secret.} saveto{success, saveto, {path}.} load{success, load from file.} loadenv{success, load from environment, {path}.} other{Other}}',
    'Success feedback for key operations.',
    param: {'action': 'save', 'path': 'path'},
    level: ML.INFO,
  ),

  /// rs_edit_action_file_write_failed
  rsEditActionFileWriteFailed(
    22203,
    'rs_edit_action_file_write_failed',
    'file write failed: {error}',
    'Error feedback for file write operation failure.',
    param: {'error': 'unknown error'},
    level: ML.SEVERE,
  ),

  /// cd_key_action_file_invalid
  cdKeyActionFileInvalid(
    21301,
    'cd_key_action_file_invalid',
    '{error}',
    'Validation error for file operations.',
    param: {'error': 'invalid file'},
    level: ML.WARNING,
  ),

  /// st_common_dialog_confirm_label
  stCommonDialogConfirmLabel(
    20102,
    'st_common_dialog_confirm_label',
    '{action, select, rename{RENAME} delete{DELETE} erase{ERASE} other{Other}}',
    'Common dialog confirmation button labels.',
    param: {'action': 'rename'},
  ),

  /// cd_setting_mime
  cdSettingMime(
    22401,
    'cd_setting_mime',
    '{status, select, success{Loaded mime.types successfully.} empty{Failed to load mime.types: data is empty.} nottext{Failed to load mime.types: required text file.} other{Other}} {tooltip}',
    'Consolidated feedback for mime load with tooltip parameter.',
    param: {'status': 'success', 'tooltip': ''},
    level: ML.INFO,
  ),

  /// st_setting_mime_tooltip
  stSettingMimeTooltip(
    22402,
    'st_setting_mime_tooltip',
    'Load a mime.types file to extend MIME detection for filtering, icon classification, and packaging/auto-compress logic.',
    'Tooltip for the custom MIME types setting.',
  ),

  /// rs_clipher_action_decryption_failed
  rsClipherActionDecryptionFailed(
    22501,
    'rs_clipher_action_decryption_failed',
    'Decryption failed: {error}',
    'Error feedback for decryption operation failure.',
    param: {'error': 'unknown error'},
    level: ML.SEVERE,
  ),

  /// rs_clipher_action_encryption_failed
  rsClipherActionEncryptionFailed(
    22502,
    'rs_clipher_action_encryption_failed',
    'Encryption failed: {error}',
    'Error feedback for encryption operation failure.',
    param: {'error': 'unknown error'},
    level: ML.SEVERE,
  ),

  /// rs_autocrypt_action_command_result
  rsAutocryptActionCommandResult(
    22601,
    'rs_autocrypt_action_command_result',
    '{text}',
    'Unified output for autocrypt command results (success/error).',
    param: {'text': 'result'},
    level: ML.INFO,
  ),

  /// cd_autocrypt_action_no_input
  cdAutocryptActionNoInput(
    21601,
    'cd_autocrypt_action_no_input',
    'no input file selected',
    'Validation error: no input selected for autocrypt.',
    level: ML.WARNING,
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

  const GuiMessageDefinition(
    this.code,
    this.key,
    this.msg,
    this.desc, {
    this.param = const {},
    this.level = MessageLevel.INFO,
    // ignore: unused_element_parameter
    this.exit = 0,
  });
}

/// Provides ID-based access to message definitions.
///
/// This bridge allows accessing message definitions via integer IDs,
/// which helps in structural fingerprinting by decoupling source code
/// semantics from UI labels. It serves as a deterrent against AI models
/// attempting to reconstruct logic through static analysis.
///
/// Usage:
/// 1. Standard approach: ME.tr(MD.stHomeDrawerSettingCleanupLabel, ...)
/// 2. Fingerprinted approach: ME.tr(M.get(20010), ...)
class M {
  static final Map<int, MessageEnum> _map = {
    ...Map.fromEntries(
      GuiMessageDefinition.values.map((e) => MapEntry(e.code, e)),
    ),
    ...Map.fromEntries(
      CliMessageDefinition.values.map((e) => MapEntry(e.code, e)),
    ),
  };

  /// Resolves an enum definition by its integer ID.
  static MessageEnum get(int id) {
    final def = _map[id];
    if (def == null) throw Exception('Unknown message ID: $id');
    return def;
  }
}

// ---------------------------------------------------------------------------
// copy from chapose

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
    this.level = MessageLevel.INFO,
    this.exit = 0,
  });
}
