// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String st_home_drawer_setting_cleanupLabel(String cleanup) {
    String _temp0 = intl.Intl.selectLogic(cleanup, {
      'keep': 'Behalten',
      'delete': 'Löschen',
      'wipelow': 'Löschen (Nullen)',
      'wipemedium': 'Löschen (Bits)',
      'wipehigh': 'Löschen (Zufall)',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_cleanupParam(String param) {
    String _temp0 = intl.Intl.selectLogic(param, {
      'level': 'Löschstufe',
      'iter': 'Iterationen',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_themeLabel(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'system': 'System',
      'light': 'Hell',
      'dark': 'Dunkel',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_langLabel(String lang) {
    String _temp0 = intl.Intl.selectLogic(lang, {
      'en': 'Englisch',
      'zh': 'Vereinfachtes Chinesisch',
      'hk': 'Traditionelles Chinesisch',
      'de': 'Deutsch',
      'ja': 'Japanisch',
      'ru': 'Russisch',
      'es': 'Spanisch',
      'pt': 'Portugiesisch',
      'fr': 'Französisch',
      'ko': 'Koreanisch',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_applockLabel(String applock) {
    String _temp0 = intl.Intl.selectLogic(applock, {
      'none': 'Keine',
      'passphrase': 'Passphrase',
      'biometrics': 'Biometrie',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autolockLabel(String autolock) {
    String _temp0 = intl.Intl.selectLogic(autolock, {
      'm1': 'Nach 1 Min.',
      'm5': 'Nach 5 Min.',
      'm15': 'Nach 15 Min.',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autoccLabel(String autocc) {
    String _temp0 = intl.Intl.selectLogic(autocc, {
      's00': 'Deaktiviert',
      's10': 'Nach 10 Sek.',
      's30': 'Nach 30 Sek.',
      's60': 'Nach 60 Sek.',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autosaveLabel(String autosave) {
    String _temp0 = intl.Intl.selectLogic(autosave, {
      's00': 'Deaktiviert',
      's05': 'Nach 5 Sek.',
      's10': 'Nach 10 Sek.',
      's20': 'Nach 20 Sek.',
      's30': 'Nach 30 Sek.',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'theme': 'Design',
      'lang': 'Sprache',
      'secret': 'Geheimschlüssel',
      'applock': 'App-Sperre',
      'autolock': 'Autom. Sperre',
      'autoclear': 'Zwischenablage löschen',
      'autosave': 'Notizen autom. speichern',
      'cleanup': 'Quelldatei-Bereinigung',
      'overwrite': 'Bestehende Dateien überschreiben',
      'stats': 'Tresor-Statistik',
      'mime': 'Benutzerdefinierte MIME-Typen',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String cd_setting_mime(String status, Object tooltip) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'success': 'mime.types erfolgreich geladen.',
      'empty': 'Fehler: mime.types ist leer.',
      'nottext': 'Fehler: erfordert eine Textdatei.',
      'other': 'Andere',
    });
    return '$_temp0 $tooltip';
  }

  @override
  String get st_setting_mime_tooltip =>
      'Laden Sie eine mime.types-Datei, um die MIME-Erkennung für Filter, Symbolklassifizierung und Verpackungs/Auto-Komprimierungslogik zu erweitern.';

  @override
  String st_home_drawer_directory_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'notes': 'Notizen-Verzeichnis',
      'encrypt': 'Verschlüsselungs-Verzeichnis',
      'decrypt': 'Entschlüsselungs-Verzeichnis',
      'archive': 'Archiv-Verzeichnis',
      'unarchive': 'Extraktions-Verzeichnis',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_nav_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'notes': 'Sichere Notizen',
      'vault': 'Tresor',
      'shredding': 'Sicheres Löschen',
      'encrypt': 'Verschlüsseln',
      'decrypt': 'Entschlüsseln',
      'archive': 'Archivieren',
      'unarchive': 'Extrahieren',
      'about': 'Über',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_popup_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'copy': 'Kopieren',
      'copyto': 'Kopieren nach...',
      'moveto': 'Verschieben nach...',
      'copypath': 'Pfad kopieren',
      'rename': 'Umbenennen...',
      'touch': 'Datum ändern',
      'view': 'Ansehen',
      'edit': 'Bearbeiten',
      'delete': 'Löschen',
      'erase': 'Sicher löschen',
      'save': 'Speichern',
      'saveto': 'Speichern unter...',
      'reset': 'Zurücksetzen',
      'clear': 'Leeren',
      'refresh': 'Aktualisieren',
      'pickenv': 'Aus Umgebungsvariable',
      'regen': 'Neu generieren',
      'pickfile': 'Datei auswählen',
      'pickfolder': 'Ordner auswählen',
      'openfile': 'Datei öffnen',
      'openfolder': 'Ordner öffnen',
      'home': 'Start',
      'eula': 'EULA',
      'about': 'Über',
      'help': 'Hilfe',
      'quit': 'Beenden',
      'share': 'Teilen',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_button_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'close': 'Schließen',
      'cancel': 'Abbrechen',
      'confirm': 'Bestätigen',
      'reset': 'Zurücksetzen',
      'new_': 'Neu',
      'save': 'Speichern',
      'view': 'Ansehen',
      'variables': 'Variablen',
      'accept': 'Akzeptieren',
      'copyall': 'Alle kopieren',
      'pickfiles': 'Dateien auswählen',
      'sharefiles': 'Dateien teilen',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String get st_home_index_header_defaultTitle => 'Startseite';

  @override
  String get st_home_index_counter_incrementLabel =>
      'Sie haben den Button so oft gedrückt:';

  @override
  String get st_home_index_counter_incrementAction => 'Erhöhen';

  @override
  String st_action_autocrypt_button_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'waiting': 'Warte auf Datei | Ordner...',
      'processing': 'Verarbeitung...',
      'encrypt': 'Datei verschlüsseln',
      'decrypt': 'Datei entschlüsseln',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String get st_common_global_info_independent =>
      'Hinweis: Jedes Element in der Liste wird unabhängig verarbeitet.';

  @override
  String get st_common_global_info_noGlobal =>
      'Hinweis: Die aktuellen Einstellungen gelten nur für diesen Vorgang und werden nicht global gespeichert.';

  @override
  String get st_archive_global_info_compression =>
      'Hinweis: Textdateien werden als .gz komprimiert, Verzeichnisse als .tgz.';

  @override
  String get st_archive_global_info_independent =>
      'Hinweis: Jedes Element wird unabhängig verarbeitet und nicht zu einem Archiv zusammengefasst.';

  @override
  String get st_decrypt_global_info_atomic =>
      'Atomare Entschlüsselung: Dieses Tool entschlüsselt nur Dateien. Falls das Ergebnis ein .tgz- oder .gz-Paket ist, verwenden Sie bitte das „Extrahieren“-Tool.';

  @override
  String get st_encrypt_global_info_atomic =>
      'Atomare Verschlüsselung: Nur Dateien werden unterstützt. Um ein Verzeichnis zu verschlüsseln, verwenden Sie bitte zuerst das „Archivieren“-Tool.';

  @override
  String get st_unarchive_global_info_support =>
      'Hinweis: Unterstützt die Extraktion von .gz (Einzeldateien) und .tar, .tgz (Verzeichnisse).';

  @override
  String st_home_briefing_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'header': '💡 Tägliches Briefing',
      'helpHeader': '🌐 Hilfe & Support',
      'doc': '📖 Dokumentation',
      'sponsor': '☕ Sponsoren',
      'status': 'Tresor-Status',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String get st_multi_file_only_empty_hint => 'Dateien hierher ziehen';

  @override
  String get st_single_path_empty_hint =>
      'Datei/Ordner hierher ziehen oder über das Menü auswählen';

  @override
  String get st_multi_path_empty_hint => 'Dateien/Ordner hierher ziehen';

  @override
  String get st_multi_path_manage_title => 'Pfade verwalten';

  @override
  String get st_multi_path_paste_hint =>
      'Pfade hier einfügen (durch Zeilenumbruch/Komma getrennt)';

  @override
  String get st_common_dialog_unsaved_title => 'Nicht gespeicherte Änderungen';

  @override
  String get cd_common_dialog_unsaved_body =>
      'Sie haben nicht gespeicherte Inhalte. Möchten Sie diese verwerfen und verlassen?';

  @override
  String get st_edit_text_hint => 'Schreiben beginnen...';

  @override
  String get st_multi_path_add_tooltip => 'Pfade hinzufügen';

  @override
  String get st_multi_path_add_from_input_tooltip =>
      'Pfade aus Eingabe hinzufügen';

  @override
  String get st_multi_path_remove_tooltip => 'Diesen Pfad entfernen';

  @override
  String st_common_form_field_label(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'dir': 'Überwachtes Verzeichnis',
      'pattern': 'Glob-Muster',
      'mime': 'MIME-Typ',
      'minSize': 'Mindestgröße (Bytes)',
      'maxSize': 'Maximalgröße (Bytes)',
      'startDate': 'Startdatum',
      'endDate': 'Enddatum',
      'sortBy': 'Sortieren nach',
      'sortOrder': 'Reihenfolge',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String st_common_variables_body_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'appVarsTitle': 'Schreibgeschützte App-Variablen',
      'appVarsDesc':
          'Diese Variablen spiegeln die aktuellen Verzeichniseinstellungen der App wider. Pfade verwenden POSIX-Trennzeichen (/). Tippen Sie auf das Kopiersymbol, um den Platzhalter in Ihre Vorlage einzufügen.',
      'custVarsTitle': 'Benutzerdefinierte Variablen',
      'custVarsDesc':
          'Variablennamen müssen mit einem Buchstaben oder Unterstrich beginnen (z. B. myVar). Pfadwerte müssen POSIX-Trennzeichen (z. B. /home/user/docs) verwenden.',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String get rs_common_global_action_copied => 'In die Zwischenablage kopiert';

  @override
  String get cd_common_action_edit_notTextFile =>
      'Nur Textdateien können bearbeitet werden.';

  @override
  String get cd_common_action_view_notViewable =>
      'Nur Text- oder Bilddateien können angezeigt werden.';

  @override
  String get rs_common_action_move_success => 'Verschoben!';

  @override
  String rs_common_action_file_error(Object err) {
    return 'Fehler: $err';
  }

  @override
  String get cd_common_action_rename_exists =>
      'Datei existiert bereits. Bitte zuerst löschen.';

  @override
  String st_common_dialog_title(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': 'Umbenennen',
      'delete': 'Datei löschen',
      'erase': 'Sicheres Löschen',
      'touch': 'Datum ändern',
      'unsaved': 'Nicht gespeicherte Änderungen',
      'applock': 'App-Sperre aktivieren',
      'filter': 'Dateien filtern',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String cd_common_dialog_confirm_message(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'delete': 'Sind Sie sicher, dass Sie diese Datei löschen möchten?',
      'erase': 'Sind Sie sicher, dass Sie diese Datei sicher löschen möchten?',
      'unsaved':
          'Sie haben nicht gespeicherte Inhalte. Möchten Sie diese verwerfen und verlassen?',
      'applock':
          'Bitte bestätigen Sie, dass Sie Ihr Passwort oder Backup sicher aufbewahrt haben. Wenn Sie die App-Sperre ohne Zugangsdaten aktivieren, könnten Sie ausgesperrt werden.',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String get cd_vault_action_security_check_failed =>
      'Sicherheitsprüfung fehlgeschlagen.';

  @override
  String rs_edit_action_auto_save_failed(Object error) {
    return 'Autom. Speichern fehlgeschlagen: $error';
  }

  @override
  String get rs_edit_action_journal_saved => 'Journal gespeichert!';

  @override
  String rs_key_action_success(String action, Object path) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'regenerate': 'Geheimschlüssel erfolgreich neu generiert.',
      'save': 'Geheimschlüssel erfolgreich gespeichert.',
      'saveto': 'Erfolgreich gespeichert unter $path.',
      'load': 'Erfolgreich aus Datei geladen.',
      'loadenv': 'Erfolgreich aus Umgebungsvariable geladen: $path.',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String rs_edit_action_file_write_failed(Object error) {
    return 'Dateischreiben fehlgeschlagen: $error';
  }

  @override
  String cd_key_action_file_invalid(Object error) {
    return '$error';
  }

  @override
  String st_common_dialog_confirm_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': 'UMBENENNEN',
      'delete': 'LÖSCHEN',
      'erase': 'SICHER LÖSCHEN',
      'other': 'Andere',
    });
    return '$_temp0';
  }

  @override
  String rs_clipher_action_decryption_failed(Object error) {
    return 'Entschlüsselung fehlgeschlagen: $error';
  }

  @override
  String rs_clipher_action_encryption_failed(Object error) {
    return 'Verschlüsselung fehlgeschlagen: $error';
  }

  @override
  String rs_autocrypt_action_command_result(Object text) {
    return '$text';
  }

  @override
  String get cd_autocrypt_action_no_input => 'Keine Eingabedatei ausgewählt';

  @override
  String common_auth_dialog_passwordTooShort_error(Object length) {
    return 'Passwort ist zu kurz (mindestens $length Zeichen).';
  }

  @override
  String get common_auth_dialog_passwordInSecure_error =>
      'Passwort muss mindestens einen Großbuchstaben, einen Kleinbuchstaben, eine Zahl und ein Sonderzeichen enthalten.';

  @override
  String get common_auth_dialog_passwordRequired_error =>
      'Passwort oder Keyfile muss angegeben werden.';

  @override
  String common_auth_dialog_fileNameIsSamed_error(Object file) {
    return 'Datei darf nicht mit der Datei identisch sein: $file';
  }

  @override
  String get common_auth_dialog_fileNameIsEmpty_error => 'Dateiname ist leer.';

  @override
  String common_auth_dialog_fileIsExist_error(Object file) {
    return 'Datei existiert bereits: $file.';
  }

  @override
  String common_auth_dialog_fileIsNotExist_error(Object file) {
    return 'Datei existiert nicht: $file.';
  }

  @override
  String common_auth_dialog_fileIsNotReadable_error(Object file) {
    return 'Datei ist nicht lesbar: $file.';
  }

  @override
  String common_auth_dialog_fileIsNotWritable_error(Object file) {
    return 'Datei ist nicht beschreibbar: $file.';
  }

  @override
  String common_auth_dialog_PathIsNotWritable_error(Object file) {
    return 'Dateipfad ist nicht beschreibbar: $file.';
  }

  @override
  String common_auth_dialog_fileIsEmpty_error(Object file) {
    return 'Datei ist leer: $file.';
  }

  @override
  String common_auth_dialog_fileIsEncrypted_error(Object file) {
    return 'Datei ist bereits verschlüsselt: $file.';
  }

  @override
  String common_auth_dialog_fileIsDecrypted_error(Object file) {
    return 'Dateityp ist keine entschlüsselte Datei: $file.';
  }
}
