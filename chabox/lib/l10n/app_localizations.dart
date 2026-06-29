import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('zh'),
    Locale('zh', 'HK'),
  ];

  /// Setting cleanup (keep | delete | wipelow | wipemedium | wipehigh ) to (Keep | Delete | WipeLow | WipeMedium | WipeHigh).
  ///
  /// In en, this message translates to:
  /// **'{cleanup, select, keep{Keep} delete{Delete} wipelow{Erase(fill zeros)} wipemedium{Erase(fill bits)} wipehigh{Erase(fill rnds)} other{Other}}'**
  String st_home_drawer_setting_cleanupLabel(String cleanup);

  /// Setting cleanup param (level | iter) to (EraseLevel | Iterations).
  ///
  /// In en, this message translates to:
  /// **'{param, select, level{Erase Level} iter{Iterations} other{Other}}'**
  String st_home_drawer_setting_cleanupParam(String param);

  /// Setting theme (system | light | dark) to (Auto | Light | Dark).
  ///
  /// In en, this message translates to:
  /// **'{theme, select, system{Auto} light{Light} dark{Dark} other{Other}}'**
  String st_home_drawer_setting_themeLabel(String theme);

  /// Setting lang (en | zh | hk | de | ja | ru | es | pt) to (English | Simplified Chinese | Traditional Chinese | German | Japanese | Russian | Spanish | Portuguese).
  ///
  /// In en, this message translates to:
  /// **'{lang, select, en{English} zh{Simplified Chinese} hk{Traditional Chinese} de{German} ja{Japanese} ru{Russian} es{Spanish} pt{Portuguese} fr{French} ko{Korean} other{Other}}'**
  String st_home_drawer_setting_langLabel(String lang);

  /// Setting applock (none | passphrase | biometrics) to (None | Passphrase | Biometrics).
  ///
  /// In en, this message translates to:
  /// **'{applock, select, none{None} passphrase{Passphrase} biometrics{Biometrics} other{Other}}'**
  String st_home_drawer_setting_applockLabel(String applock);

  /// Setting autolock (m1 | m5 | m15) to (After 1 | 5 | 15 min).
  ///
  /// In en, this message translates to:
  /// **'{autolock, select, m1{After 1 min} m5{After 5 min} m15{After 15 min} other{Other}}'**
  String st_home_drawer_setting_autolockLabel(String autolock);

  /// Setting autocc (s00 | s10 | s30 | s60) to (Disabled | After 10 | 30 | 60 secs).
  ///
  /// In en, this message translates to:
  /// **'{autocc, select, s00{Disabled} s10{After 10 secs} s30{After 30 secs} s60{After 60 secs} other{Other}}'**
  String st_home_drawer_setting_autoccLabel(String autocc);

  /// Setting autosave (s00 | s05 | s10 | s20 | s30) to (Disabled | After 5 | 10 | 20 | 30 secs).
  ///
  /// In en, this message translates to:
  /// **'{autosave, select, s00{Disabled} s05{After 5 secs} s10{After 10 secs} s20{After 20 secs} s30{After 30 secs} other{Other}}'**
  String st_home_drawer_setting_autosaveLabel(String autosave);

  /// Setting titles in drawer.
  ///
  /// In en, this message translates to:
  /// **'{title, select, theme{ThemeMode} lang{Language} secret{Secret} applock{AppLock} autolock{Auto-Lock} autoclear{Clipboard-Clear} autosave{Notes Auto Save} cleanup{CleanUp} overwrite{Overwrite existing files} stats{Show vault stats} mime{Custom MIME Types} other{Other}}'**
  String st_home_drawer_setting_title(String title);

  /// Consolidated feedback for mime load with tooltip parameter.
  ///
  /// In en, this message translates to:
  /// **'{status, select, success{Loaded mime.types successfully.} empty{Failed to load mime.types: data is empty.} nottext{Failed to load mime.types: required text file.} other{Other}} {tooltip}'**
  String cd_setting_mime(String status, Object tooltip);

  /// Tooltip for the custom MIME types setting.
  ///
  /// In en, this message translates to:
  /// **'Load a mime.types file to extend MIME detection for filtering, icon classification, and packaging/auto-compress logic.'**
  String get st_setting_mime_tooltip;

  /// Directory titles in drawer.
  ///
  /// In en, this message translates to:
  /// **'{title, select, notes{Notes To Directory} encrypt{Encrypted To Directory} decrypt{Decrypted To Directory} archive{Archived To Directory} unarchive{UnArchived To Directory} other{Other}}'**
  String st_home_drawer_directory_title(String title);

  /// Navigation action labels.
  ///
  /// In en, this message translates to:
  /// **'{action, select, notes{Secure Notes} vault{Secure Vault} shredding{Secure Erase} encrypt{Encrypt} decrypt{Decrypt} archive{Archive} unarchive{UnArchive} about{About} other{Other}}'**
  String st_common_global_nav_actionLabel(String action);

  /// Popup menu action labels.
  ///
  /// In en, this message translates to:
  /// **'{action, select, copy{Copy} copyto{Copy To...} moveto{Move To...} copypath{Copy Path} rename{Rename...} touch{Modify Date} view{View} edit{Edit} delete{Delete} erase{Erase} save{Save} saveto{Save To...} reset{Reset} clear{Clear} refresh{Refresh} pickenv{From Environment} regen{Regenerate} pickfile{Pick File} pickfolder{Pick Folder} openfile{Open File} openfolder{Open Folder} home{Home} eula{EULA} about{About} help{Help} quit{Quit} share{Share} other{Other}}'**
  String st_common_global_popup_actionLabel(String action);

  /// Standard button action labels.
  ///
  /// In en, this message translates to:
  /// **'{action, select, close{Close} cancel{Cancel} confirm{Confirm} reset{Reset} new_{New} save{Save} view{View} variables{Variables} accept{Agree} copyall{Copy All} pickfiles{Pick Files} sharefiles{Share Files} other{Other}}'**
  String st_common_global_button_actionLabel(String action);

  /// Default home page header title.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get st_home_index_header_defaultTitle;

  /// Counter label for testing.
  ///
  /// In en, this message translates to:
  /// **'You have pushed the button this many times:'**
  String get st_home_index_counter_incrementLabel;

  /// Counter action button for testing.
  ///
  /// In en, this message translates to:
  /// **'Increment'**
  String get st_home_index_counter_incrementAction;

  /// Autocrypt action button labels.
  ///
  /// In en, this message translates to:
  /// **'{action, select, waiting{Waiting for File | Folder ...} processing{Processing...} encrypt{Encrypt File} decrypt{Decrypt File} other{Other}}'**
  String st_action_autocrypt_button_label(String action);

  /// Common note for independent processing.
  ///
  /// In en, this message translates to:
  /// **'Note: Each item in the list is processed independently.'**
  String get st_common_global_info_independent;

  /// Common note for session-only settings.
  ///
  /// In en, this message translates to:
  /// **'Note: Current setting changes apply only to this operation and will not be saved globally.'**
  String get st_common_global_info_noGlobal;

  /// Archive compression info.
  ///
  /// In en, this message translates to:
  /// **'Note: Text files are compressed to .gz, while directories are packed and compressed to .tgz.'**
  String get st_archive_global_info_compression;

  /// Archive independent processing info.
  ///
  /// In en, this message translates to:
  /// **'Note: Each item in the list is processed independently and not merged into a single archive.'**
  String get st_archive_global_info_independent;

  /// Decrypt atomic operation info.
  ///
  /// In en, this message translates to:
  /// **'Atomic Decryption: This tool only decrypts files. If the result is a .tgz or .gz package, please use the \"Unarchive\" tool to extract it.'**
  String get st_decrypt_global_info_atomic;

  /// Encrypt atomic operation info.
  ///
  /// In en, this message translates to:
  /// **'Atomic Encryption: Only files are supported. To encrypt a directory, please use the \"Archive\" tool first to create a .tgz package.'**
  String get st_encrypt_global_info_atomic;

  /// Unarchive support info.
  ///
  /// In en, this message translates to:
  /// **'Note: Supports extraction of .gz (single files) and .tar, .tgz (directory packages).'**
  String get st_unarchive_global_info_support;

  /// Static text labels for BriefingView.
  ///
  /// In en, this message translates to:
  /// **'{label, select, header{💡 Daily Briefing} helpHeader{🌐 Help & Support} doc{📖 Documentation} sponsor{☕ Sponsor} status{Vault Status} other{Other}}'**
  String st_home_briefing_label(String label);

  /// Hint text for multi file input.
  ///
  /// In en, this message translates to:
  /// **'Drag & drop files here'**
  String get st_multi_file_only_empty_hint;

  /// Hint text for single path input.
  ///
  /// In en, this message translates to:
  /// **'Drag & drop file/folder, or select from menu'**
  String get st_single_path_empty_hint;

  /// Hint text when MultiPath list is empty.
  ///
  /// In en, this message translates to:
  /// **'Drag & drop files/folders here'**
  String get st_multi_path_empty_hint;

  /// Title for path management dialog.
  ///
  /// In en, this message translates to:
  /// **'Manage Paths'**
  String get st_multi_path_manage_title;

  /// Hint text for path pasting.
  ///
  /// In en, this message translates to:
  /// **'Paste paths here (newline/comma separated)'**
  String get st_multi_path_paste_hint;

  /// Common dialog title for unsaved changes.
  ///
  /// In en, this message translates to:
  /// **'Unsaved Changes'**
  String get st_common_dialog_unsaved_title;

  /// Common dialog message for unsaved changes.
  ///
  /// In en, this message translates to:
  /// **'You have unsaved content. Do you want to discard it and leave?'**
  String get cd_common_dialog_unsaved_body;

  /// Hint text for the text editor.
  ///
  /// In en, this message translates to:
  /// **'Start writing...'**
  String get st_edit_text_hint;

  /// Tooltip for adding paths.
  ///
  /// In en, this message translates to:
  /// **'Add Paths'**
  String get st_multi_path_add_tooltip;

  /// Tooltip for adding paths from the text input field.
  ///
  /// In en, this message translates to:
  /// **'Add paths from input'**
  String get st_multi_path_add_from_input_tooltip;

  /// Tooltip for removing a single path from the list.
  ///
  /// In en, this message translates to:
  /// **'Remove this path'**
  String get st_multi_path_remove_tooltip;

  /// Common labels for form fields.
  ///
  /// In en, this message translates to:
  /// **'{field, select, dir{Monitored Directory} pattern{Glob Pattern} mime{Mimetype Part} minSize{Min Size (bytes)} maxSize{Max Size (bytes)} startDate{Start Date} endDate{End Date} sortBy{Sort By} sortOrder{Order} other{Other}}'**
  String st_common_form_field_label(String field);

  /// Template variables.
  ///
  /// In en, this message translates to:
  /// **'{label, select, appVarsTitle{Read-only app variables} appVarsDesc{These variables reflect the current app directory settings. Paths use POSIX separators (/). Tap the copy icon to insert the placeholder into your template.} custVarsTitle{Custom variables} custVarsDesc{Variable names must start with a letter or underscore (e.g. myVar). Path values must use POSIX separators (e.g. /home/user/docs).} other{Other}}'**
  String st_common_variables_body_label(String label);

  /// Success feedback for copy operation.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get rs_common_global_action_copied;

  /// Validation error: attempted to edit a non-text file.
  ///
  /// In en, this message translates to:
  /// **'Only edit text file.'**
  String get cd_common_action_edit_notTextFile;

  /// Validation error: attempted to view a non-viewable file.
  ///
  /// In en, this message translates to:
  /// **'Only view (text | image) file.'**
  String get cd_common_action_view_notViewable;

  /// Success feedback for move operation.
  ///
  /// In en, this message translates to:
  /// **'Moved!'**
  String get rs_common_action_move_success;

  /// Error feedback for file operations.
  ///
  /// In en, this message translates to:
  /// **'Error: {err}'**
  String rs_common_action_file_error(Object err);

  /// Validation error: rename operation collision.
  ///
  /// In en, this message translates to:
  /// **'File already exists. Delete it first.'**
  String get cd_common_action_rename_exists;

  /// Common dialog titles.
  ///
  /// In en, this message translates to:
  /// **'{action, select, rename{Rename} delete{Delete File} erase{Secure Erase File} touch{Modify Date} unsaved{Unsaved Changes} applock{Enable App Lock} filter{Filter Files} other{Other}}'**
  String st_common_dialog_title(String action);

  /// Common dialog confirmation messages.
  ///
  /// In en, this message translates to:
  /// **'{action, select, delete{Are you sure you want to delete this file?} erase{Are you sure you want to secure erase this file?} unsaved{You have unsaved content. Do you want to discard it and leave?} applock{Please confirm you have safely stored your passphrase or backup. If you enable app lock without credentials, you may be locked out and unable to access the app.} other{Other}}'**
  String cd_common_dialog_confirm_message(String action);

  /// Validation error: vault security check failed.
  ///
  /// In en, this message translates to:
  /// **'Security check failed.'**
  String get cd_vault_action_security_check_failed;

  /// Error feedback for auto-save operation failure.
  ///
  /// In en, this message translates to:
  /// **'Auto-save failed: {error}'**
  String rs_edit_action_auto_save_failed(Object error);

  /// Success feedback for journal save operation.
  ///
  /// In en, this message translates to:
  /// **'Journal Saved!'**
  String get rs_edit_action_journal_saved;

  /// Success feedback for key operations.
  ///
  /// In en, this message translates to:
  /// **'{action, select, regenerate{success, regenerate secret.} save{success, save secret.} saveto{success, saveto, {path}.} load{success, load from file.} loadenv{success, load from environment, {path}.} other{Other}}'**
  String rs_key_action_success(String action, Object path);

  /// Error feedback for file write operation failure.
  ///
  /// In en, this message translates to:
  /// **'file write failed: {error}'**
  String rs_edit_action_file_write_failed(Object error);

  /// Validation error for file operations.
  ///
  /// In en, this message translates to:
  /// **'{error}'**
  String cd_key_action_file_invalid(Object error);

  /// Common dialog confirmation button labels.
  ///
  /// In en, this message translates to:
  /// **'{action, select, rename{RENAME} delete{DELETE} erase{ERASE} other{Other}}'**
  String st_common_dialog_confirm_label(String action);

  /// Error feedback for decryption operation failure.
  ///
  /// In en, this message translates to:
  /// **'Decryption failed: {error}'**
  String rs_clipher_action_decryption_failed(Object error);

  /// Error feedback for encryption operation failure.
  ///
  /// In en, this message translates to:
  /// **'Encryption failed: {error}'**
  String rs_clipher_action_encryption_failed(Object error);

  /// Unified output for autocrypt command results (success/error).
  ///
  /// In en, this message translates to:
  /// **'{text}'**
  String rs_autocrypt_action_command_result(Object text);

  /// Validation error: no input selected for autocrypt.
  ///
  /// In en, this message translates to:
  /// **'no input file selected'**
  String get cd_autocrypt_action_no_input;

  /// No description provided for @common_auth_dialog_passwordTooShort_error.
  ///
  /// In en, this message translates to:
  /// **'Password is too short (must be at least {length} characters).'**
  String common_auth_dialog_passwordTooShort_error(Object length);

  /// No description provided for @common_auth_dialog_passwordInSecure_error.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character.'**
  String get common_auth_dialog_passwordInSecure_error;

  /// No description provided for @common_auth_dialog_passwordRequired_error.
  ///
  /// In en, this message translates to:
  /// **'Must specify either a password or a keyfile.'**
  String get common_auth_dialog_passwordRequired_error;

  /// No description provided for @common_auth_dialog_fileNameIsSamed_error.
  ///
  /// In en, this message translates to:
  /// **'file cannot be the same as the file: {file}'**
  String common_auth_dialog_fileNameIsSamed_error(Object file);

  /// No description provided for @common_auth_dialog_fileNameIsEmpty_error.
  ///
  /// In en, this message translates to:
  /// **'file name is empty.'**
  String get common_auth_dialog_fileNameIsEmpty_error;

  /// No description provided for @common_auth_dialog_fileIsExist_error.
  ///
  /// In en, this message translates to:
  /// **'file already exist: {file} .'**
  String common_auth_dialog_fileIsExist_error(Object file);

  /// No description provided for @common_auth_dialog_fileIsNotExist_error.
  ///
  /// In en, this message translates to:
  /// **'file is not exist: {file} .'**
  String common_auth_dialog_fileIsNotExist_error(Object file);

  /// No description provided for @common_auth_dialog_fileIsNotReadable_error.
  ///
  /// In en, this message translates to:
  /// **'file is not readable: {file} .'**
  String common_auth_dialog_fileIsNotReadable_error(Object file);

  /// No description provided for @common_auth_dialog_fileIsNotWritable_error.
  ///
  /// In en, this message translates to:
  /// **'file is not writable: {file} .'**
  String common_auth_dialog_fileIsNotWritable_error(Object file);

  /// No description provided for @common_auth_dialog_PathIsNotWritable_error.
  ///
  /// In en, this message translates to:
  /// **'file path is not writable: {file} .'**
  String common_auth_dialog_PathIsNotWritable_error(Object file);

  /// No description provided for @common_auth_dialog_fileIsEmpty_error.
  ///
  /// In en, this message translates to:
  /// **'file is empty: {file} .'**
  String common_auth_dialog_fileIsEmpty_error(Object file);

  /// No description provided for @common_auth_dialog_fileIsEncrypted_error.
  ///
  /// In en, this message translates to:
  /// **'file is already encrypted: {file} .'**
  String common_auth_dialog_fileIsEncrypted_error(Object file);

  /// No description provided for @common_auth_dialog_fileIsDecrypted_error.
  ///
  /// In en, this message translates to:
  /// **'file type is not an decrypted file: {file} .'**
  String common_auth_dialog_fileIsDecrypted_error(Object file);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'ja',
    'ko',
    'pt',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'HK':
            return AppLocalizationsZhHk();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
