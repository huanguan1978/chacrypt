// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String st_home_drawer_setting_cleanupLabel(String cleanup) {
    String _temp0 = intl.Intl.selectLogic(cleanup, {
      'keep': 'Сохранить',
      'delete': 'Удалить',
      'wipelow': 'Стереть (нули)',
      'wipemedium': 'Стереть (биты)',
      'wipehigh': 'Стереть (случайно)',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_cleanupParam(String param) {
    String _temp0 = intl.Intl.selectLogic(param, {
      'level': 'Уровень стирания',
      'iter': 'Итерации',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_themeLabel(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'system': 'Системная',
      'light': 'Светлая',
      'dark': 'Темная',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_langLabel(String lang) {
    String _temp0 = intl.Intl.selectLogic(lang, {
      'en': 'Английский',
      'zh': 'Китайский упрощенный',
      'hk': 'Китайский традиционный',
      'de': 'Немецкий',
      'ja': 'Японский',
      'ru': 'Русский',
      'es': 'Испанский',
      'pt': 'Португальский',
      'fr': 'Французский',
      'ko': 'Корейский',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_applockLabel(String applock) {
    String _temp0 = intl.Intl.selectLogic(applock, {
      'none': 'Нет',
      'passphrase': 'Парольная фраза',
      'biometrics': 'Биометрия',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autolockLabel(String autolock) {
    String _temp0 = intl.Intl.selectLogic(autolock, {
      'm1': 'Через 1 мин',
      'm5': 'Через 5 мин',
      'm15': 'Через 15 мин',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autoccLabel(String autocc) {
    String _temp0 = intl.Intl.selectLogic(autocc, {
      's00': 'Отключено',
      's10': 'Через 10 сек',
      's30': 'Через 30 сек',
      's60': 'Через 60 сек',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autosaveLabel(String autosave) {
    String _temp0 = intl.Intl.selectLogic(autosave, {
      's00': 'Отключено',
      's05': 'Через 5 сек',
      's10': 'Через 10 сек',
      's20': 'Через 20 сек',
      's30': 'Через 30 сек',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'theme': 'Тема',
      'lang': 'Язык',
      'secret': 'Секретный ключ',
      'applock': 'Блокировка приложения',
      'autolock': 'Автоблокировка',
      'autoclear': 'Очистка буфера',
      'autosave': 'Автосохранение заметок',
      'cleanup': 'Очистка исходников',
      'overwrite': 'Перезаписывать файлы',
      'stats': 'Статистика',
      'mime': 'Пользовательские MIME типы',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String cd_setting_mime(String status, Object tooltip) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'success': 'mime.types успешно загружен.',
      'empty': 'Не удалось загрузить mime.types: данные пусты.',
      'nottext': 'Не удалось загрузить mime.types: требуется текстовый файл.',
      'other': 'Другое',
    });
    return '$_temp0 $tooltip';
  }

  @override
  String get st_setting_mime_tooltip =>
      'Загрузите файл mime.types, чтобы расширить обнаружение MIME для фильтрации, классификации значков и логики упаковки/автоматической компрессии.';

  @override
  String st_home_drawer_directory_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'notes': 'Папка заметок',
      'encrypt': 'Папка для шифрования',
      'decrypt': 'Папка для дешифрования',
      'archive': 'Папка архивов',
      'unarchive': 'Папка извлечения',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_nav_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'notes': 'Заметки',
      'vault': 'Хранилище',
      'shredding': 'Стирание',
      'encrypt': 'Шифрование',
      'decrypt': 'Дешифрование',
      'archive': 'Архивация',
      'unarchive': 'Извлечение',
      'about': 'О программе',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_popup_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'copy': 'Копировать',
      'copyto': 'Копировать в...',
      'moveto': 'Переместить в...',
      'copypath': 'Копировать путь',
      'rename': 'Переименовать...',
      'touch': 'Изменить дату',
      'view': 'Просмотр',
      'edit': 'Правка',
      'delete': 'Удалить',
      'erase': 'Стереть',
      'save': 'Сохранить',
      'saveto': 'Сохранить в...',
      'reset': 'Сброс',
      'clear': 'Очистить',
      'refresh': 'Обновить',
      'pickenv': 'Из окружения',
      'regen': 'Перегенерировать',
      'pickfile': 'Выбрать файл',
      'pickfolder': 'Выбрать папку',
      'openfile': 'Открыть файл',
      'openfolder': 'Открыть папку',
      'home': 'Главная',
      'eula': 'Лицензия',
      'about': 'О программе',
      'help': 'Помощь',
      'quit': 'Выход',
      'share': 'Поделиться',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_button_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'close': 'Закрыть',
      'cancel': 'Отмена',
      'confirm': 'ОК',
      'reset': 'Сброс',
      'new_': 'Создать',
      'save': 'Сохранить',
      'view': 'Просмотр',
      'variables': 'Переменные',
      'accept': 'Принять',
      'copyall': 'Копировать всё',
      'pickfiles': 'Выбрать файлы',
      'sharefiles': 'Поделиться файлами',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String get st_home_index_header_defaultTitle => 'Главная';

  @override
  String get st_home_index_counter_incrementLabel =>
      'Кнопка нажата столько раз:';

  @override
  String get st_home_index_counter_incrementAction => 'Увеличить';

  @override
  String st_action_autocrypt_button_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'waiting': 'Ожидание файла | папки...',
      'processing': 'Обработка...',
      'encrypt': 'Зашифровать файл',
      'decrypt': 'Расшифровать файл',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String get st_common_global_info_independent =>
      'Примечание: каждый элемент обрабатывается независимо.';

  @override
  String get st_common_global_info_noGlobal =>
      'Примечание: текущие изменения настроек применяются только к этой операции и не будут сохранены глобально.';

  @override
  String get st_archive_global_info_compression =>
      'Примечание: текстовые файлы сжимаются в .gz, папки — в .tgz.';

  @override
  String get st_archive_global_info_independent =>
      'Примечание: элементы не объединяются в один архив.';

  @override
  String get st_decrypt_global_info_atomic =>
      'Дешифрование: только для файлов. Для .tgz/.gz используйте инструмент извлечения.';

  @override
  String get st_encrypt_global_info_atomic =>
      'Шифрование: только для файлов. Для папок сначала создайте .tgz архив.';

  @override
  String get st_unarchive_global_info_support =>
      'Поддержка: .gz (файлы) и .tar, .tgz (папки).';

  @override
  String st_home_briefing_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'header': '💡 Брифинг',
      'helpHeader': '🌐 Поддержка',
      'doc': '📖 Документация',
      'sponsor': '☕ Спонсоры',
      'status': 'Статус',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String get st_multi_file_only_empty_hint => 'Перетащите файлы сюда';

  @override
  String get st_single_path_empty_hint =>
      'Перетащите файл/папку или выберите из меню';

  @override
  String get st_multi_path_empty_hint => 'Перетащите файлы/папки сюда';

  @override
  String get st_multi_path_manage_title => 'Управление путями';

  @override
  String get st_multi_path_paste_hint =>
      'Вставьте пути (разделитель: строка или запятая)';

  @override
  String get st_common_dialog_unsaved_title => 'Несохраненные изменения';

  @override
  String get cd_common_dialog_unsaved_body =>
      'Есть несохраненные данные. Выйти без сохранения?';

  @override
  String get st_edit_text_hint => 'Начните писать...';

  @override
  String get st_multi_path_add_tooltip => 'Добавить пути';

  @override
  String get st_multi_path_add_from_input_tooltip => 'Добавить пути из ввода';

  @override
  String get st_multi_path_remove_tooltip => 'Удалить этот путь';

  @override
  String st_common_form_field_label(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'dir': 'Папка',
      'pattern': 'Шаблон',
      'mime': 'MIME-тип',
      'minSize': 'Мин. размер (байт)',
      'maxSize': 'Макс. размер (байт)',
      'startDate': 'Начало',
      'endDate': 'Конец',
      'sortBy': 'Сортировать',
      'sortOrder': 'Порядок',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String st_common_variables_body_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'appVarsTitle': 'Переменные приложения только для чтения',
      'appVarsDesc':
          'Эти переменные отражают текущие настройки каталога приложения. Пути используют разделители POSIX (/). Нажмите значок копирования, чтобы вставить плейсхолдер в ваш шаблон.',
      'custVarsTitle': 'Пользовательские переменные',
      'custVarsDesc':
          'Имена переменных должны начинаться с буквы или символа подчёркивания (например, myVar). Значения путей должны использовать разделители POSIX (например, /home/user/docs).',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String get rs_common_global_action_copied => 'Скопировано в буфер';

  @override
  String get cd_common_action_edit_notTextFile =>
      'Только для текстовых файлов.';

  @override
  String get cd_common_action_view_notViewable =>
      'Только для текста или изображений.';

  @override
  String get rs_common_action_move_success => 'Перемещено!';

  @override
  String rs_common_action_file_error(Object err) {
    return 'Ошибка: $err';
  }

  @override
  String get cd_common_action_rename_exists => 'Файл уже существует.';

  @override
  String st_common_dialog_title(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': 'Переименовать',
      'delete': 'Удалить файл',
      'erase': 'Стереть файл',
      'touch': 'Изменить дату',
      'unsaved': 'Несохраненные изменения',
      'applock': 'Включить блокировку приложения',
      'filter': 'Фильтрация файлов',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String cd_common_dialog_confirm_message(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'delete': 'Удалить этот файл?',
      'erase': 'Безвозвратно стереть этот файл?',
      'unsaved': 'Данные не сохранены. Выйти?',
      'applock':
          'Пожалуйста, подтвердите, что вы надежно сохранили пароль или резервную копию. Если вы включите блокировку без учетных данных, вы можете быть заблокированы и не сможете получить доступ к приложению.',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String get cd_vault_action_security_check_failed =>
      'Ошибка проверки безопасности.';

  @override
  String rs_edit_action_auto_save_failed(Object error) {
    return 'Ошибка автосохранения: $error';
  }

  @override
  String get rs_edit_action_journal_saved => 'Журнал сохранен!';

  @override
  String rs_key_action_success(String action, Object path) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'regenerate': 'Ключ перегенерирован.',
      'save': 'Ключ сохранен.',
      'saveto': 'Сохранено в $path.',
      'load': 'Загружено из файла.',
      'loadenv': 'Загружено из окружения: $path.',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String rs_edit_action_file_write_failed(Object error) {
    return 'Ошибка записи файла: $error';
  }

  @override
  String cd_key_action_file_invalid(Object error) {
    return '$error';
  }

  @override
  String st_common_dialog_confirm_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': 'ПЕРЕИМЕНОВАТЬ',
      'delete': 'УДАЛИТЬ',
      'erase': 'СТЕРЕТЬ',
      'other': 'Другое',
    });
    return '$_temp0';
  }

  @override
  String rs_clipher_action_decryption_failed(Object error) {
    return 'Ошибка дешифрования: $error';
  }

  @override
  String rs_clipher_action_encryption_failed(Object error) {
    return 'Ошибка шифрования: $error';
  }

  @override
  String rs_autocrypt_action_command_result(Object text) {
    return '$text';
  }

  @override
  String get cd_autocrypt_action_no_input => 'Файл не выбран';

  @override
  String common_auth_dialog_passwordTooShort_error(Object length) {
    return 'Пароль слишком короткий (минимум $length симв.).';
  }

  @override
  String get common_auth_dialog_passwordInSecure_error =>
      'Пароль должен содержать заглавные, строчные буквы, цифры и спецсимволы.';

  @override
  String get common_auth_dialog_passwordRequired_error =>
      'Укажите пароль или файл ключа.';

  @override
  String common_auth_dialog_fileNameIsSamed_error(Object file) {
    return 'Имя совпадает с исходным: $file';
  }

  @override
  String get common_auth_dialog_fileNameIsEmpty_error => 'Имя файла пусто.';

  @override
  String common_auth_dialog_fileIsExist_error(Object file) {
    return 'Файл уже существует: $file.';
  }

  @override
  String common_auth_dialog_fileIsNotExist_error(Object file) {
    return 'Файл не существует: $file.';
  }

  @override
  String common_auth_dialog_fileIsNotReadable_error(Object file) {
    return 'Файл не читается: $file.';
  }

  @override
  String common_auth_dialog_fileIsNotWritable_error(Object file) {
    return 'Файл защищен от записи: $file.';
  }

  @override
  String common_auth_dialog_PathIsNotWritable_error(Object file) {
    return 'Путь защищен от записи: $file.';
  }

  @override
  String common_auth_dialog_fileIsEmpty_error(Object file) {
    return 'Файл пуст: $file.';
  }

  @override
  String common_auth_dialog_fileIsEncrypted_error(Object file) {
    return 'Файл уже зашифрован: $file.';
  }

  @override
  String common_auth_dialog_fileIsDecrypted_error(Object file) {
    return 'Файл не является расшифрованным: $file.';
  }
}
