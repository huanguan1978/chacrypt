// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String st_home_drawer_setting_cleanupLabel(String cleanup) {
    String _temp0 = intl.Intl.selectLogic(cleanup, {
      'keep': '保持',
      'delete': '削除',
      'wipelow': '抹消 (ゼロ埋め)',
      'wipemedium': '抹消 (ビット埋め)',
      'wipehigh': '抹消 (ランダム)',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_cleanupParam(String param) {
    String _temp0 = intl.Intl.selectLogic(param, {
      'level': '抹消レベル',
      'iter': '反復回数',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_themeLabel(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'system': 'システム設定',
      'light': 'ライト',
      'dark': 'ダーク',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_langLabel(String lang) {
    String _temp0 = intl.Intl.selectLogic(lang, {
      'en': '英語',
      'zh': '簡体中国語',
      'hk': '繁体中国語',
      'de': 'ドイツ語',
      'ja': '日本語',
      'ru': 'ロシア語',
      'es': 'スペイン語',
      'pt': 'ポルトガル語',
      'fr': 'フランス語',
      'ko': '韓国語',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_applockLabel(String applock) {
    String _temp0 = intl.Intl.selectLogic(applock, {
      'none': 'なし',
      'passphrase': 'パスフレーズ',
      'biometrics': '生体認証',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autolockLabel(String autolock) {
    String _temp0 = intl.Intl.selectLogic(autolock, {
      'm1': '1分後',
      'm5': '5分後',
      'm15': '15分後',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autoccLabel(String autocc) {
    String _temp0 = intl.Intl.selectLogic(autocc, {
      's00': '無効',
      's10': '10秒後',
      's30': '30秒後',
      's60': '60秒後',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autosaveLabel(String autosave) {
    String _temp0 = intl.Intl.selectLogic(autosave, {
      's00': '無効',
      's05': '5秒後',
      's10': '10秒後',
      's20': '20秒後',
      's30': '30秒後',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'theme': 'テーマモード',
      'lang': '表示言語',
      'secret': '秘密鍵',
      'applock': 'アプリロック',
      'autolock': '自動ロック',
      'autoclear': 'クリップボード消去',
      'autosave': 'メモ自動保存',
      'cleanup': '元ファイルの処理',
      'overwrite': '既存ファイルを上書き',
      'stats': '保管庫の統計',
      'mime': 'カスタム MIME タイプ',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String cd_setting_mime(String status, Object tooltip) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'success': 'mime.types の読み込みに成功しました。',
      'empty': '読み込みに失敗しました: mime.types のデータが空です。',
      'nottext': '読み込みに失敗しました: テキストファイルが必要です。',
      'other': 'その他',
    });
    return '$_temp0 $tooltip';
  }

  @override
  String get st_setting_mime_tooltip =>
      'MIME 検出をフィルタリング、アイコン分類、パッケージ化/自動圧縮ロジック用に拡張するために mime.types ファイルを読み込みます。';

  @override
  String st_home_drawer_directory_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'notes': 'メモ用ディレクトリ',
      'encrypt': '暗号化出力ディレクトリ',
      'decrypt': '復号出力ディレクトリ',
      'archive': 'アーカイブ出力ディレクトリ',
      'unarchive': '展開出力ディレクトリ',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_nav_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'notes': 'セキュアメモ',
      'vault': '保管庫',
      'shredding': '安全な抹消',
      'encrypt': '暗号化',
      'decrypt': '復号',
      'archive': 'アーカイブ',
      'unarchive': '展開',
      'about': 'アプリについて',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_popup_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'copy': 'コピー',
      'copyto': '...へコピー',
      'moveto': '...へ移動',
      'copypath': 'パスをコピー',
      'rename': '名前を変更...',
      'touch': '日付を変更',
      'view': '表示',
      'edit': '編集',
      'delete': '削除',
      'erase': '抹消',
      'save': '保存',
      'saveto': '名前を付けて保存...',
      'reset': 'リセット',
      'clear': '消去',
      'refresh': '更新',
      'pickenv': '環境変数から読み込む',
      'regen': '再生成',
      'pickfile': 'ファイルを選択',
      'pickfolder': 'フォルダを選択',
      'openfile': 'ファイルを開く',
      'openfolder': 'フォルダを開く',
      'home': 'ホーム',
      'eula': '使用許諾契約',
      'about': 'アプリについて',
      'help': 'ヘルプ',
      'quit': '終了',
      'share': '共有',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_button_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'close': '閉じる',
      'cancel': 'キャンセル',
      'confirm': '確定',
      'reset': 'リセット',
      'new_': '新規',
      'save': '保存',
      'view': '表示',
      'variables': '変数',
      'accept': '同意する',
      'copyall': 'すべてコピー',
      'pickfiles': 'ファイルを選択',
      'sharefiles': 'ファイルを共有',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String get st_home_index_header_defaultTitle => 'ホーム';

  @override
  String get st_home_index_counter_incrementLabel => 'ボタンを押した回数：';

  @override
  String get st_home_index_counter_incrementAction => '増やす';

  @override
  String st_action_autocrypt_button_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'waiting': 'ファイルまたはフォルダを待機中...',
      'processing': '処理中...',
      'encrypt': 'ファイルを暗号化',
      'decrypt': 'ファイルを復号',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String get st_common_global_info_independent => '注意：リスト内の各項目は個別に処理されます。';

  @override
  String get st_common_global_info_noGlobal =>
      '注意：現在の設定変更はこの操作にのみ適用され、グローバルには保存されません。';

  @override
  String get st_archive_global_info_compression =>
      '注意：テキストファイルは .gz に、ディレクトリは .tgz に圧縮されます。';

  @override
  String get st_archive_global_info_independent =>
      '注意：各項目は個別に処理され、1つのアーカイブにはまとめられません。';

  @override
  String get st_decrypt_global_info_atomic =>
      'アトミック復号：このツールはファイルの復号のみを行います。結果が .tgz または .gz パッケージの場合は、「展開」ツールを使用してください。';

  @override
  String get st_encrypt_global_info_atomic =>
      'アトミック暗号化：ファイルのみサポートされています。ディレクトリを暗号化するには、まず「アーカイブ」ツールを使用して .tgz パッケージを作成してください。';

  @override
  String get st_unarchive_global_info_support =>
      '注意：.gz (単一ファイル) および .tar, .tgz (ディレクトリパッケージ) の展開をサポートしています。';

  @override
  String st_home_briefing_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'header': '💡 デイリーブリーフィング',
      'helpHeader': '🌐 ヘルプ＆サポート',
      'doc': '📖 ドキュメント',
      'sponsor': '☕ スポンサー',
      'status': '保管庫の状態',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String get st_multi_file_only_empty_hint => 'ファイルをここにドラッグ＆ドロップ';

  @override
  String get st_single_path_empty_hint => 'ファイル/フォルダをドラッグ＆ドロップ、またはメニューから選択';

  @override
  String get st_multi_path_empty_hint => 'ファイルやフォルダをここにドラッグ＆ドロップ';

  @override
  String get st_multi_path_manage_title => 'パスの管理';

  @override
  String get st_multi_path_paste_hint => 'パスをここに貼り付け（改行またはカンマ区切り）';

  @override
  String get st_common_dialog_unsaved_title => '未保存の変更';

  @override
  String get cd_common_dialog_unsaved_body => '未保存の内容があります。破棄して移動しますか？';

  @override
  String get st_edit_text_hint => '入力を開始...';

  @override
  String get st_multi_path_add_tooltip => 'パスを追加';

  @override
  String get st_multi_path_add_from_input_tooltip => '入力からパスを追加';

  @override
  String get st_multi_path_remove_tooltip => 'このパスを削除';

  @override
  String st_common_form_field_label(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'dir': '監視ディレクトリ',
      'pattern': 'Globパターン',
      'mime': 'MIMEタイプの一部',
      'minSize': '最小サイズ (bytes)',
      'maxSize': '最大サイズ (bytes)',
      'startDate': '開始日',
      'endDate': '終了日',
      'sortBy': '並び替え',
      'sortOrder': '順序',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String st_common_variables_body_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'appVarsTitle': '読み取り専用のアプリ変数',
      'appVarsDesc':
          'これらの変数は現在のアプリのディレクトリ設定を反映します。パスは POSIX 区切り文字 (/) を使用します。コピーアイコンをタップすると、テンプレートにプレースホルダーを挿入できます。',
      'custVarsTitle': 'カスタム変数',
      'custVarsDesc':
          '変数名は英字またはアンダースコアで始める必要があります (例: myVar)。パス値には POSIX 区切り文字 (例: /home/user/docs) を使用してください。',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String get rs_common_global_action_copied => 'クリップボードにコピーしました';

  @override
  String get cd_common_action_edit_notTextFile => 'テキストファイルのみ編集可能です。';

  @override
  String get cd_common_action_view_notViewable => 'テキストまたは画像ファイルのみ表示可能です。';

  @override
  String get rs_common_action_move_success => '移動しました！';

  @override
  String rs_common_action_file_error(Object err) {
    return 'エラー: $err';
  }

  @override
  String get cd_common_action_rename_exists => 'ファイルが既に存在します。先に削除してください。';

  @override
  String st_common_dialog_title(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': '名前を変更',
      'delete': 'ファイルを削除',
      'erase': 'ファイルを安全に抹消',
      'touch': '日付を変更',
      'unsaved': '未保存の変更',
      'applock': 'アプリロックを有効にする',
      'filter': 'ファイルをフィルター',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String cd_common_dialog_confirm_message(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'delete': 'このファイルを削除してもよろしいですか？',
      'erase': 'このファイルを安全に抹消してもよろしいですか？',
      'unsaved': '未保存の内容があります。破棄して移動しますか？',
      'applock':
          'アプリロックを有効にする前に、パスフレーズまたはバックアップを確実に保存したことを確認してください。資格情報がないまま有効にすると、アプリにアクセスできなくなる可能性があります。',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String get cd_vault_action_security_check_failed => 'セキュリティチェックに失敗しました。';

  @override
  String rs_edit_action_auto_save_failed(Object error) {
    return '自動保存に失敗しました: $error';
  }

  @override
  String get rs_edit_action_journal_saved => 'ジャーナルを保存しました！';

  @override
  String rs_key_action_success(String action, Object path) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'regenerate': '成功、秘密鍵を再生成しました。',
      'save': '成功、秘密鍵を保存しました。',
      'saveto': '成功、$path に保存しました。',
      'load': '成功、ファイルから読み込みました。',
      'loadenv': '成功、環境変数 $path から読み込みました。',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String rs_edit_action_file_write_failed(Object error) {
    return 'ファイル書き込みに失敗しました: $error';
  }

  @override
  String cd_key_action_file_invalid(Object error) {
    return '$error';
  }

  @override
  String st_common_dialog_confirm_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': '名前を変更',
      'delete': '削除',
      'erase': '抹消',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String rs_clipher_action_decryption_failed(Object error) {
    return '復号に失敗しました: $error';
  }

  @override
  String rs_clipher_action_encryption_failed(Object error) {
    return '暗号化に失敗しました: $error';
  }

  @override
  String rs_autocrypt_action_command_result(Object text) {
    return '$text';
  }

  @override
  String get cd_autocrypt_action_no_input => '入力ファイルが選択されていません';

  @override
  String common_auth_dialog_passwordTooShort_error(Object length) {
    return 'パスワードが短すぎます（少なくとも $length 文字必要です）。';
  }

  @override
  String get common_auth_dialog_passwordInSecure_error =>
      'パスワードには、大文字、小文字、数字、特殊文字をそれぞれ少なくとも1つ含める必要があります。';

  @override
  String get common_auth_dialog_passwordRequired_error =>
      'パスワードまたはキーファイルのいずれかを指定する必要があります。';

  @override
  String common_auth_dialog_fileNameIsSamed_error(Object file) {
    return 'ファイル名は元のファイルと同じにすることはできません: $file';
  }

  @override
  String get common_auth_dialog_fileNameIsEmpty_error => 'ファイル名が空です。';

  @override
  String common_auth_dialog_fileIsExist_error(Object file) {
    return 'ファイルが既に存在します: $file';
  }

  @override
  String common_auth_dialog_fileIsNotExist_error(Object file) {
    return 'ファイルが存在しません: $file';
  }

  @override
  String common_auth_dialog_fileIsNotReadable_error(Object file) {
    return 'ファイルを読み込めません: $file';
  }

  @override
  String common_auth_dialog_fileIsNotWritable_error(Object file) {
    return 'ファイルを書き込めません: $file';
  }

  @override
  String common_auth_dialog_PathIsNotWritable_error(Object file) {
    return 'ファイルパスが書き込み不可能です: $file';
  }

  @override
  String common_auth_dialog_fileIsEmpty_error(Object file) {
    return 'ファイルが空です: $file';
  }

  @override
  String common_auth_dialog_fileIsEncrypted_error(Object file) {
    return 'ファイルは既に暗号化されています: $file';
  }

  @override
  String common_auth_dialog_fileIsDecrypted_error(Object file) {
    return 'ファイル形式が復号されたファイルではありません: $file';
  }
}
