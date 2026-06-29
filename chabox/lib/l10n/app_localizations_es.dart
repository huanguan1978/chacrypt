// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String st_home_drawer_setting_cleanupLabel(String cleanup) {
    String _temp0 = intl.Intl.selectLogic(cleanup, {
      'keep': 'Mantener',
      'delete': 'Eliminar',
      'wipelow': 'Borrar (ceros)',
      'wipemedium': 'Borrar (bits)',
      'wipehigh': 'Borrar (aleat)',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_cleanupParam(String param) {
    String _temp0 = intl.Intl.selectLogic(param, {
      'level': 'Nivel de borrado',
      'iter': 'Iteraciones',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_themeLabel(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'system': 'Sistema',
      'light': 'Claro',
      'dark': 'Oscuro',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_langLabel(String lang) {
    String _temp0 = intl.Intl.selectLogic(lang, {
      'en': 'Inglés',
      'zh': 'Chino simplificado',
      'hk': 'Chino tradicional',
      'de': 'Alemán',
      'ja': 'Japonés',
      'ru': 'Ruso',
      'es': 'Español',
      'pt': 'Portugués',
      'fr': 'Francés',
      'ko': 'Coreano',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_applockLabel(String applock) {
    String _temp0 = intl.Intl.selectLogic(applock, {
      'none': 'Ninguno',
      'passphrase': 'Frase de contraseña',
      'biometrics': 'Biometría',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autolockLabel(String autolock) {
    String _temp0 = intl.Intl.selectLogic(autolock, {
      'm1': 'Tras 1 min',
      'm5': 'Tras 5 min',
      'm15': 'Tras 15 min',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autoccLabel(String autocc) {
    String _temp0 = intl.Intl.selectLogic(autocc, {
      's00': 'Desactivado',
      's10': 'Tras 10 seg',
      's30': 'Tras 30 seg',
      's60': 'Tras 60 seg',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autosaveLabel(String autosave) {
    String _temp0 = intl.Intl.selectLogic(autosave, {
      's00': 'Desactivado',
      's05': 'Tras 5 seg',
      's10': 'Tras 10 seg',
      's20': 'Tras 20 seg',
      's30': 'Tras 30 seg',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'theme': 'Modo de tema',
      'lang': 'Idioma',
      'secret': 'Llave secreta',
      'applock': 'Bloqueo de app',
      'autolock': 'Autobloqueo',
      'autoclear': 'Limpiar portapapeles',
      'autosave': 'Autoguardado de notas',
      'cleanup': 'Limpieza de origen',
      'overwrite': 'Sobrescribir archivos',
      'stats': 'Estadísticas de bóveda',
      'mime': 'Tipos MIME personalizados',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String cd_setting_mime(String status, Object tooltip) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'success': 'mime.types cargado con éxito.',
      'empty': 'Error: mime.types está vacío.',
      'nottext': 'Error: se requiere un archivo de texto.',
      'other': 'Otro',
    });
    return '$_temp0 $tooltip';
  }

  @override
  String get st_setting_mime_tooltip =>
      'Cargue un archivo mime.types para ampliar la detección MIME para filtros, clasificación de iconos y la lógica de empaquetado/auto-compresión.';

  @override
  String st_home_drawer_directory_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'notes': 'Directorio de notas',
      'encrypt': 'Directorio cifrado',
      'decrypt': 'Directorio descifrado',
      'archive': 'Directorio de archivos',
      'unarchive': 'Directorio de extracción',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_nav_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'notes': 'Notas seguras',
      'vault': 'Bóveda',
      'shredding': 'Borrado seguro',
      'encrypt': 'Cifrar',
      'decrypt': 'Descifrar',
      'archive': 'Archivar',
      'unarchive': 'Extraer',
      'about': 'Acerca de',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_popup_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'copy': 'Copiar',
      'copyto': 'Copiar a...',
      'moveto': 'Mover a...',
      'copypath': 'Copiar ruta',
      'rename': 'Renombrar...',
      'touch': 'Modificar fecha',
      'view': 'Ver',
      'edit': 'Editar',
      'delete': 'Eliminar',
      'erase': 'Borrar',
      'save': 'Guardar',
      'saveto': 'Guardar en...',
      'reset': 'Restablecer',
      'clear': 'Limpiar',
      'refresh': 'Actualizar',
      'pickenv': 'Desde entorno',
      'regen': 'Regenerar',
      'pickfile': 'Elegir archivo',
      'pickfolder': 'Elegir carpeta',
      'openfile': 'Abrir archivo',
      'openfolder': 'Abrir carpeta',
      'home': 'Inicio',
      'eula': 'EULA',
      'about': 'Acerca de',
      'help': 'Ayuda',
      'quit': 'Salir',
      'share': 'Compartir',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_button_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'close': 'Cerrar',
      'cancel': 'Cancelar',
      'confirm': 'Confirmar',
      'reset': 'Restablecer',
      'new_': 'Nuevo',
      'save': 'Guardar',
      'view': 'Ver',
      'variables': 'Variables',
      'accept': 'Aceptar',
      'copyall': 'Copiar todo',
      'pickfiles': 'Seleccionar archivos',
      'sharefiles': 'Compartir archivos',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String get st_home_index_header_defaultTitle => 'Inicio';

  @override
  String get st_home_index_counter_incrementLabel =>
      'Has pulsado el botón estas veces:';

  @override
  String get st_home_index_counter_incrementAction => 'Incrementar';

  @override
  String st_action_autocrypt_button_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'waiting': 'Esperando archivo | carpeta...',
      'processing': 'Procesando...',
      'encrypt': 'Cifrar archivo',
      'decrypt': 'Descifrar archivo',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String get st_common_global_info_independent =>
      'Nota: Cada elemento se procesa de forma independiente.';

  @override
  String get st_common_global_info_noGlobal =>
      'Nota: Los ajustes actuales solo se aplican a esta operación y no se guardarán globalmente.';

  @override
  String get st_archive_global_info_compression =>
      'Nota: Archivos de texto se comprimen en .gz, carpetas en .tgz.';

  @override
  String get st_archive_global_info_independent =>
      'Nota: Los elementos no se combinan en un solo archivo.';

  @override
  String get st_decrypt_global_info_atomic =>
      'Descifrado atómico: Solo para archivos. Para .tgz/.gz use la herramienta de extracción.';

  @override
  String get st_encrypt_global_info_atomic =>
      'Cifrado atómico: Solo archivos. Para carpetas use primero la herramienta de archivo.';

  @override
  String get st_unarchive_global_info_support =>
      'Nota: Admite extracción de .gz (archivos) y .tar, .tgz (carpetas).';

  @override
  String st_home_briefing_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'header': '💡 Resumen diario',
      'helpHeader': '🌐 Ayuda y soporte',
      'doc': '📖 Documentación',
      'sponsor': '☕ Patrocinar',
      'status': 'Estado de bóveda',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String get st_multi_file_only_empty_hint => 'Arrastre archivos aquí';

  @override
  String get st_single_path_empty_hint =>
      'Arrastre y suelte el archivo/carpeta, o seleccione del menú';

  @override
  String get st_multi_path_empty_hint => 'Arrastre archivos/carpetas aquí';

  @override
  String get st_multi_path_manage_title => 'Gestionar rutas';

  @override
  String get st_multi_path_paste_hint =>
      'Pegue rutas aquí (separadas por línea o coma)';

  @override
  String get st_common_dialog_unsaved_title => 'Cambios sin guardar';

  @override
  String get cd_common_dialog_unsaved_body =>
      '¿Desea descartar los cambios y salir?';

  @override
  String get st_edit_text_hint => 'Empiece a escribir...';

  @override
  String get st_multi_path_add_tooltip => 'Agregar rutas';

  @override
  String get st_multi_path_add_from_input_tooltip =>
      'Agregar rutas desde la entrada';

  @override
  String get st_multi_path_remove_tooltip => 'Eliminar esta ruta';

  @override
  String st_common_form_field_label(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'dir': 'Directorio',
      'pattern': 'Patrón glob',
      'mime': 'Tipo MIME',
      'minSize': 'Tamaño mín (bytes)',
      'maxSize': 'Tamaño máx (bytes)',
      'startDate': 'Fecha inicio',
      'endDate': 'Fecha fin',
      'sortBy': 'Ordenar por',
      'sortOrder': 'Orden',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String st_common_variables_body_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'appVarsTitle': 'Variables de la app de solo lectura',
      'appVarsDesc':
          'Estas variables reflejan la configuración actual del directorio de la app. Las rutas usan separadores POSIX (/). Toque el icono de copiar para insertar el marcador en su plantilla.',
      'custVarsTitle': 'Variables personalizadas',
      'custVarsDesc':
          'Los nombres de variable deben comenzar con una letra o un guion bajo (por ejemplo, myVar). Los valores de ruta deben usar separadores POSIX (por ejemplo, /home/user/docs).',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String get rs_common_global_action_copied => 'Copiado al portapapeles';

  @override
  String get cd_common_action_edit_notTextFile =>
      'Solo se pueden editar archivos de texto.';

  @override
  String get cd_common_action_view_notViewable =>
      'Solo se pueden ver archivos de texto o imagen.';

  @override
  String get rs_common_action_move_success => '¡Movido!';

  @override
  String rs_common_action_file_error(Object err) {
    return 'Error: $err';
  }

  @override
  String get cd_common_action_rename_exists => 'El archivo ya existe.';

  @override
  String st_common_dialog_title(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': 'Renombrar',
      'delete': 'Eliminar archivo',
      'erase': 'Borrado seguro',
      'touch': 'Modificar fecha',
      'unsaved': 'Cambios sin guardar',
      'applock': 'Activar bloqueo de la aplicación',
      'filter': 'Filtrar archivos',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String cd_common_dialog_confirm_message(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'delete': '¿Eliminar este archivo?',
      'erase': '¿Borrar de forma segura este archivo?',
      'unsaved': 'Hay cambios sin guardar. ¿Salir?',
      'applock':
          'Por favor confirme que ha guardado de forma segura su contraseña o copia de seguridad. Si activa el bloqueo sin credenciales, podría quedar bloqueado y no poder acceder a la aplicación.',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String get cd_vault_action_security_check_failed =>
      'Error de comprobación de seguridad.';

  @override
  String rs_edit_action_auto_save_failed(Object error) {
    return 'Error de autoguardado: $error';
  }

  @override
  String get rs_edit_action_journal_saved => '¡Diario guardado!';

  @override
  String rs_key_action_success(String action, Object path) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'regenerate': 'Llave regenerada.',
      'save': 'Llave guardada.',
      'saveto': 'Guardada en $path.',
      'load': 'Cargada desde archivo.',
      'loadenv': 'Cargada desde entorno: $path.',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String rs_edit_action_file_write_failed(Object error) {
    return 'Error al escribir archivo: $error';
  }

  @override
  String cd_key_action_file_invalid(Object error) {
    return '$error';
  }

  @override
  String st_common_dialog_confirm_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': 'RENOMBRAR',
      'delete': 'ELIMINAR',
      'erase': 'BORRAR',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String rs_clipher_action_decryption_failed(Object error) {
    return 'Error de descifrado: $error';
  }

  @override
  String rs_clipher_action_encryption_failed(Object error) {
    return 'Error de cifrado: $error';
  }

  @override
  String rs_autocrypt_action_command_result(Object text) {
    return '$text';
  }

  @override
  String get cd_autocrypt_action_no_input => 'No se ha seleccionado archivo';

  @override
  String common_auth_dialog_passwordTooShort_error(Object length) {
    return 'Contraseña demasiado corta (mín. $length caracteres).';
  }

  @override
  String get common_auth_dialog_passwordInSecure_error =>
      'Debe incluir mayúsculas, minúsculas, números y símbolos.';

  @override
  String get common_auth_dialog_passwordRequired_error =>
      'Especifique contraseña o archivo de llave.';

  @override
  String common_auth_dialog_fileNameIsSamed_error(Object file) {
    return 'El nombre coincide con el original: $file';
  }

  @override
  String get common_auth_dialog_fileNameIsEmpty_error =>
      'El nombre de archivo está vacío.';

  @override
  String common_auth_dialog_fileIsExist_error(Object file) {
    return 'El archivo ya existe: $file.';
  }

  @override
  String common_auth_dialog_fileIsNotExist_error(Object file) {
    return 'El archivo no existe: $file.';
  }

  @override
  String common_auth_dialog_fileIsNotReadable_error(Object file) {
    return 'El archivo no es legible: $file.';
  }

  @override
  String common_auth_dialog_fileIsNotWritable_error(Object file) {
    return 'El archivo no es escribible: $file.';
  }

  @override
  String common_auth_dialog_PathIsNotWritable_error(Object file) {
    return 'La ruta no es escribible: $file.';
  }

  @override
  String common_auth_dialog_fileIsEmpty_error(Object file) {
    return 'El archivo está vacío: $file.';
  }

  @override
  String common_auth_dialog_fileIsEncrypted_error(Object file) {
    return 'El archivo ya está cifrado: $file.';
  }

  @override
  String common_auth_dialog_fileIsDecrypted_error(Object file) {
    return 'El archivo no es un archivo descifrado: $file.';
  }
}
