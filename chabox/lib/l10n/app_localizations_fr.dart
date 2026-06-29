// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String st_home_drawer_setting_cleanupLabel(String cleanup) {
    String _temp0 = intl.Intl.selectLogic(cleanup, {
      'keep': 'Conserver',
      'delete': 'Supprimer',
      'wipelow': 'Effacer (zéros)',
      'wipemedium': 'Effacer (bits)',
      'wipehigh': 'Effacer (aléat)',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_cleanupParam(String param) {
    String _temp0 = intl.Intl.selectLogic(param, {
      'level': 'Niveau d\'effacement',
      'iter': 'Itérations',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_themeLabel(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'system': 'Auto',
      'light': 'Clair',
      'dark': 'Sombre',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_langLabel(String lang) {
    String _temp0 = intl.Intl.selectLogic(lang, {
      'en': 'Anglais',
      'zh': 'Chinois simplifié',
      'hk': 'Chinois traditionnel',
      'de': 'Allemand',
      'ja': 'Japonais',
      'ru': 'Russe',
      'es': 'Espagnol',
      'pt': 'Portugais',
      'fr': 'Français',
      'ko': 'Coréen',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_applockLabel(String applock) {
    String _temp0 = intl.Intl.selectLogic(applock, {
      'none': 'Aucun',
      'passphrase': 'Phrase secrète',
      'biometrics': 'Biométrie',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autolockLabel(String autolock) {
    String _temp0 = intl.Intl.selectLogic(autolock, {
      'm1': 'Après 1 min',
      'm5': 'Après 5 min',
      'm15': 'Après 15 min',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autoccLabel(String autocc) {
    String _temp0 = intl.Intl.selectLogic(autocc, {
      's00': 'Désactivé',
      's10': 'Après 10 s',
      's30': 'Après 30 s',
      's60': 'Après 60 s',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autosaveLabel(String autosave) {
    String _temp0 = intl.Intl.selectLogic(autosave, {
      's00': 'Désactivé',
      's05': 'Après 5 s',
      's10': 'Après 10 s',
      's20': 'Après 20 s',
      's30': 'Après 30 s',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'theme': 'Mode thème',
      'lang': 'Langue',
      'secret': 'Secret',
      'applock': 'Verrouillage',
      'autolock': 'Auto-verrou',
      'autoclear': 'Presse-papiers',
      'autosave': 'Sauvegarde notes',
      'cleanup': 'Nettoyage source',
      'overwrite': 'Écraser fichiers',
      'stats': 'Stats coffre',
      'mime': 'Types MIME personnalisés',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String cd_setting_mime(String status, Object tooltip) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'success': 'mime.types chargé avec succès.',
      'empty': 'Erreur: mime.types est vide.',
      'nottext': 'Erreur: nécessite un fichier texte.',
      'other': 'Autre',
    });
    return '$_temp0 $tooltip';
  }

  @override
  String get st_setting_mime_tooltip =>
      'Chargez un fichier mime.types pour étendre la détection MIME pour le filtrage, la classification des icônes et la logique d\'archivage/auto-compression.';

  @override
  String st_home_drawer_directory_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'notes': 'Dossier notes',
      'encrypt': 'Dossier chiffré',
      'decrypt': 'Dossier déchiffré',
      'archive': 'Dossier archive',
      'unarchive': 'Dossier extraction',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_nav_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'notes': 'Notes sécurisées',
      'vault': 'Coffre',
      'shredding': 'Effacement sûr',
      'encrypt': 'Chiffrer',
      'decrypt': 'Déchiffrer',
      'archive': 'Archiver',
      'unarchive': 'Désarchiver',
      'about': 'À propos',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_popup_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'copy': 'Copier',
      'copyto': 'Copier vers...',
      'moveto': 'Déplacer vers...',
      'copypath': 'Copier chemin',
      'rename': 'Renommer...',
      'touch': 'Modifier la date',
      'view': 'Voir',
      'edit': 'Modifier',
      'delete': 'Supprimer',
      'erase': 'Effacer',
      'save': 'Enregistrer',
      'saveto': 'Enregistrer sous...',
      'reset': 'Réinitialiser',
      'clear': 'Effacer',
      'refresh': 'Actualiser',
      'pickenv': 'Depuis env',
      'regen': 'Régénérer',
      'pickfile': 'Choisir fichier',
      'pickfolder': 'Choisir dossier',
      'openfile': 'Ouvrir fichier',
      'openfolder': 'Ouvrir dossier',
      'home': 'Accueil',
      'eula': 'CLUF',
      'about': 'À propos',
      'help': 'Aide',
      'quit': 'Quitter',
      'share': 'Partager',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_button_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'close': 'Fermer',
      'cancel': 'Annuler',
      'confirm': 'Confirmer',
      'reset': 'Réinitialiser',
      'new_': 'Nouveau',
      'save': 'Enregistrer',
      'view': 'Voir',
      'variables': 'Variables',
      'accept': 'Accepter',
      'copyall': 'Copier tout',
      'pickfiles': 'Sélectionner fichiers',
      'sharefiles': 'Partager fichiers',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String get st_home_index_header_defaultTitle => 'Accueil';

  @override
  String get st_home_index_counter_incrementLabel =>
      'Vous avez appuyé sur le bouton ce nombre de fois :';

  @override
  String get st_home_index_counter_incrementAction => 'Incrémenter';

  @override
  String st_action_autocrypt_button_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'waiting': 'En attente de fichier | dossier...',
      'processing': 'Traitement...',
      'encrypt': 'Chiffrer fichier',
      'decrypt': 'Déchiffrer fichier',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String get st_common_global_info_independent =>
      'Note : Chaque élément est traité indépendamment.';

  @override
  String get st_common_global_info_noGlobal =>
      'Note : Les réglages actuels ne s\'appliquent qu\'à cette opération.';

  @override
  String get st_archive_global_info_compression =>
      'Note : Fichiers texte compressés en .gz, dossiers en .tgz.';

  @override
  String get st_archive_global_info_independent =>
      'Note : Les éléments ne sont pas fusionnés.';

  @override
  String get st_decrypt_global_info_atomic =>
      'Déchiffrement atomique : Fichiers uniquement. Pour .tgz/.gz, utilisez l\'outil de désarchivage.';

  @override
  String get st_encrypt_global_info_atomic =>
      'Chiffrement atomique : Fichiers uniquement. Pour dossiers, archivez d\'abord.';

  @override
  String get st_unarchive_global_info_support =>
      'Note : Supporte l\'extraction de .gz (fichiers) et .tar, .tgz (dossiers).';

  @override
  String st_home_briefing_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'header': '💡 Briefing quotidien',
      'helpHeader': '🌐 Aide & Support',
      'doc': '📖 Documentation',
      'sponsor': '☕ Soutenir',
      'status': 'État du coffre',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String get st_multi_file_only_empty_hint =>
      'Glissez-déposez des fichiers ici';

  @override
  String get st_single_path_empty_hint =>
      'Glissez-déposez fichier/dossier, ou choisissez via menu';

  @override
  String get st_multi_path_empty_hint =>
      'Glissez-déposez fichiers/dossiers ici';

  @override
  String get st_multi_path_manage_title => 'Gérer les chemins';

  @override
  String get st_multi_path_paste_hint =>
      'Collez les chemins ici (séparés par ligne/virgule)';

  @override
  String get st_common_dialog_unsaved_title => 'Modifications non enregistrées';

  @override
  String get cd_common_dialog_unsaved_body =>
      'Contenu non enregistré. Voulez-vous quitter ?';

  @override
  String get st_edit_text_hint => 'Commencez à écrire...';

  @override
  String get st_multi_path_add_tooltip => 'Ajouter des chemins';

  @override
  String get st_multi_path_add_from_input_tooltip => 'Ajouter depuis l\'entrée';

  @override
  String get st_multi_path_remove_tooltip => 'Supprimer ce chemin';

  @override
  String st_common_form_field_label(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'dir': 'Dossier surveillé',
      'pattern': 'Motif Glob',
      'mime': 'Type MIME',
      'minSize': 'Taille min (octets)',
      'maxSize': 'Taille max (octets)',
      'startDate': 'Date début',
      'endDate': 'Date fin',
      'sortBy': 'Trier par',
      'sortOrder': 'Ordre',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String st_common_variables_body_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'appVarsTitle': 'Variables d\'application en lecture seule',
      'appVarsDesc':
          'Ces variables reflètent les réglages actuels du dossier de l\'application. Les chemins utilisent des séparateurs POSIX (/). Touchez l\'icône de copie pour insérer l\'espace réservé dans votre modèle.',
      'custVarsTitle': 'Variables personnalisées',
      'custVarsDesc':
          'Les noms de variable doivent commencer par une lettre ou un souligné (par ex. myVar). Les valeurs de chemin doivent utiliser des séparateurs POSIX (par ex. /home/user/docs).',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String get rs_common_global_action_copied => 'Copié dans le presse-papiers';

  @override
  String get cd_common_action_edit_notTextFile =>
      'Modifier uniquement des fichiers texte.';

  @override
  String get cd_common_action_view_notViewable =>
      'Voir uniquement fichiers texte ou image.';

  @override
  String get rs_common_action_move_success => 'Déplacé !';

  @override
  String rs_common_action_file_error(Object err) {
    return 'Erreur : $err';
  }

  @override
  String get cd_common_action_rename_exists =>
      'Le fichier existe déjà. Supprimez-le d\'abord.';

  @override
  String st_common_dialog_title(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': 'Renommer',
      'delete': 'Supprimer fichier',
      'erase': 'Effacement sûr',
      'touch': 'Modifier la date',
      'unsaved': 'Modifications non enregistrées',
      'applock': 'Activer le verrouillage de l\'application',
      'filter': 'Filtrer fichiers',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String cd_common_dialog_confirm_message(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'delete': 'Voulez-vous supprimer ce fichier ?',
      'erase': 'Voulez-vous effacer sûrement ce fichier ?',
      'unsaved': 'Contenu non enregistré. Quitter ?',
      'applock':
          'Veuillez confirmer que vous avez bien sauvegardé votre mot de passe ou sauvegarde. Si vous activez le verrouillage sans identifiants, vous pourriez être bloqué hors de l\'application.',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String get cd_vault_action_security_check_failed =>
      'Échec du contrôle de sécurité.';

  @override
  String rs_edit_action_auto_save_failed(Object error) {
    return 'Échec sauvegarde auto : $error';
  }

  @override
  String get rs_edit_action_journal_saved => 'Journal enregistré !';

  @override
  String rs_key_action_success(String action, Object path) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'regenerate': 'Succès, secret régénéré.',
      'save': 'Succès, secret enregistré.',
      'saveto': 'Succès, enregistré vers $path.',
      'load': 'Succès, chargé depuis fichier.',
      'loadenv': 'Succès, chargé depuis env, $path.',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String rs_edit_action_file_write_failed(Object error) {
    return 'Échec écriture fichier : $error';
  }

  @override
  String cd_key_action_file_invalid(Object error) {
    return '$error';
  }

  @override
  String st_common_dialog_confirm_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': 'RENOMMER',
      'delete': 'SUPPRIMER',
      'erase': 'EFFACER',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String rs_clipher_action_decryption_failed(Object error) {
    return 'Échec déchiffrement : $error';
  }

  @override
  String rs_clipher_action_encryption_failed(Object error) {
    return 'Échec chiffrement : $error';
  }

  @override
  String rs_autocrypt_action_command_result(Object text) {
    return '$text';
  }

  @override
  String get cd_autocrypt_action_no_input => 'Aucun fichier sélectionné';

  @override
  String common_auth_dialog_passwordTooShort_error(Object length) {
    return 'Mot de passe trop court (min $length caractères).';
  }

  @override
  String get common_auth_dialog_passwordInSecure_error =>
      'Le mot de passe doit contenir majuscules, minuscules, chiffres et symboles.';

  @override
  String get common_auth_dialog_passwordRequired_error =>
      'Mot de passe ou clé requis.';

  @override
  String common_auth_dialog_fileNameIsSamed_error(Object file) {
    return 'Le fichier ne peut être identique au fichier : $file';
  }

  @override
  String get common_auth_dialog_fileNameIsEmpty_error => 'Nom de fichier vide.';

  @override
  String common_auth_dialog_fileIsExist_error(Object file) {
    return 'Le fichier existe déjà : $file.';
  }

  @override
  String common_auth_dialog_fileIsNotExist_error(Object file) {
    return 'Le fichier n\'existe pas : $file.';
  }

  @override
  String common_auth_dialog_fileIsNotReadable_error(Object file) {
    return 'Le fichier n\'est pas lisible : $file.';
  }

  @override
  String common_auth_dialog_fileIsNotWritable_error(Object file) {
    return 'Le fichier n\'est pas scriptible : $file.';
  }

  @override
  String common_auth_dialog_PathIsNotWritable_error(Object file) {
    return 'Chemin non scriptible : $file.';
  }

  @override
  String common_auth_dialog_fileIsEmpty_error(Object file) {
    return 'Le fichier est vide : $file.';
  }

  @override
  String common_auth_dialog_fileIsEncrypted_error(Object file) {
    return 'Le fichier est déjà chiffré : $file.';
  }

  @override
  String common_auth_dialog_fileIsDecrypted_error(Object file) {
    return 'Le type n\'est pas un fichier déchiffré : $file.';
  }
}
