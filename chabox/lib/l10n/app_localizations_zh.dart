// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String st_home_drawer_setting_cleanupLabel(String cleanup) {
    String _temp0 = intl.Intl.selectLogic(cleanup, {
      'keep': '保留',
      'delete': '删除',
      'wipelow': '擦除 (填零)',
      'wipemedium': '擦除 (填位)',
      'wipehigh': '擦除 (随机)',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_cleanupParam(String param) {
    String _temp0 = intl.Intl.selectLogic(param, {
      'level': '擦除级别',
      'iter': '迭代次数',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_themeLabel(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'system': '跟随系统',
      'light': '浅色模式',
      'dark': '深色模式',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_langLabel(String lang) {
    String _temp0 = intl.Intl.selectLogic(lang, {
      'en': '英文',
      'zh': '简体中文',
      'hk': '繁体中文',
      'de': '德文',
      'ja': '日文',
      'ru': '俄文',
      'es': '西班牙文',
      'pt': '葡萄牙文',
      'fr': '法文',
      'ko': '韩文',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_applockLabel(String applock) {
    String _temp0 = intl.Intl.selectLogic(applock, {
      'none': '无',
      'passphrase': '口令锁',
      'biometrics': '生物识别',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autolockLabel(String autolock) {
    String _temp0 = intl.Intl.selectLogic(autolock, {
      'm1': '1 分钟后',
      'm5': '5 分钟后',
      'm15': '15 分钟后',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autoccLabel(String autocc) {
    String _temp0 = intl.Intl.selectLogic(autocc, {
      's00': '已禁用',
      's10': '10 秒后',
      's30': '30 秒后',
      's60': '60 秒后',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autosaveLabel(String autosave) {
    String _temp0 = intl.Intl.selectLogic(autosave, {
      's00': '已禁用',
      's05': '5 秒后',
      's10': '10 秒后',
      's20': '20 秒后',
      's30': '30 秒后',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'theme': '主题模式',
      'lang': '显示语言',
      'secret': '安全密钥',
      'applock': '应用锁定',
      'autolock': '自动锁定',
      'autoclear': '剪贴板清除',
      'autosave': '笔记自动保存',
      'cleanup': '源文件处理',
      'overwrite': '覆盖现有文件',
      'stats': '保险库统计',
      'mime': '自定义 MIME 类型',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String cd_setting_mime(String status, Object tooltip) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'success': '载入 mime.types 成功。',
      'empty': '载入失败：mime.types 数据为空。',
      'nottext': '载入失败：需要文本文件。',
      'other': '其他',
    });
    return '$_temp0 $tooltip';
  }

  @override
  String get st_setting_mime_tooltip =>
      '载入 mime.types 以扩展全局 MIME 识别，用于筛选、图标分类和归档/自动压缩逻辑。';

  @override
  String st_home_drawer_directory_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'notes': '笔记目录',
      'encrypt': '加密输出目录',
      'decrypt': '解密输出目录',
      'archive': '归档输出目录',
      'unarchive': '提取输出目录',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_nav_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'notes': '加密笔记',
      'vault': '保险库',
      'shredding': '安全擦除',
      'encrypt': '文件加密',
      'decrypt': '文件解密',
      'archive': '归档压缩',
      'unarchive': '提取归档',
      'about': '关于',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_popup_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'copy': '复制',
      'copyto': '复制到...',
      'moveto': '移动到...',
      'copypath': '复制路径',
      'rename': '重命名...',
      'touch': '修改时间',
      'view': '查看',
      'edit': '编辑',
      'delete': '删除',
      'erase': '安全抹除',
      'save': '保存',
      'saveto': '保存到...',
      'reset': '重置',
      'clear': '清除',
      'refresh': '刷新',
      'pickenv': '从环境变量加载',
      'regen': '重新生成',
      'pickfile': '选择文件',
      'pickfolder': '选择文件夹',
      'openfile': '打开文件',
      'openfolder': '打开文件夹',
      'home': '首页',
      'eula': '最终用户许可协议',
      'about': '关于',
      'help': '帮助',
      'quit': '退出',
      'share': '分享',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_button_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'close': '关闭',
      'cancel': '取消',
      'confirm': '确定',
      'reset': '重置',
      'new_': '新建',
      'save': '保存',
      'view': '查看',
      'variables': '变量',
      'accept': '接受',
      'copyall': '全部复制',
      'pickfiles': '选取文件',
      'sharefiles': '分享文件',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String get st_home_index_header_defaultTitle => '首页';

  @override
  String get st_home_index_counter_incrementLabel => '您已点击按钮这么多次：';

  @override
  String get st_home_index_counter_incrementAction => '增加';

  @override
  String st_action_autocrypt_button_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'waiting': '等待选择文件或文件夹...',
      'processing': '处理中...',
      'encrypt': '加密文件',
      'decrypt': '解密文件',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String get st_common_global_info_independent => '注意：列表中的每一项都将独立处理。';

  @override
  String get st_common_global_info_noGlobal => '注意：当前设置仅对本次操作生效，不会全局保存。';

  @override
  String get st_archive_global_info_compression =>
      '注意：文本文件将被压缩为 .gz，目录将被打包并压缩为 .tgz。';

  @override
  String get st_archive_global_info_independent =>
      '注意：列表中的每一项都将独立处理，不会合并到一个归档中。';

  @override
  String get st_decrypt_global_info_atomic =>
      '原子解密：此工具仅负责解密文件。如果结果是 .tgz 或 .gz 包，请使用“提取归档”工具进行解压。';

  @override
  String get st_encrypt_global_info_atomic =>
      '原子加密：仅支持加密文件。如需加密目录，请先使用“归档压缩”工具创建 .tgz 包。';

  @override
  String get st_unarchive_global_info_support =>
      '注意：支持提取 .gz (单文件) 和 .tar、.tgz (目录包)。';

  @override
  String st_home_briefing_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'header': '💡 每日简报',
      'helpHeader': '🌐 帮助与支持',
      'doc': '📖 文档指南',
      'sponsor': '☕ 赞助支持',
      'status': '保险库状态',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String get st_multi_file_only_empty_hint => '拖放文件到此处';

  @override
  String get st_single_path_empty_hint => '拖放文件/文件夹，或从菜单浏览选取';

  @override
  String get st_multi_path_empty_hint => '拖放文件或文件夹到此处';

  @override
  String get st_multi_path_manage_title => '管理路径';

  @override
  String get st_multi_path_paste_hint => '在此粘贴路径 (以换行或逗号分隔)';

  @override
  String get st_common_dialog_unsaved_title => '未保存更改';

  @override
  String get cd_common_dialog_unsaved_body => '您有未保存的内容。确定要放弃并离开吗？';

  @override
  String get st_edit_text_hint => '开始写作...';

  @override
  String get st_multi_path_add_tooltip => '添加路径';

  @override
  String get st_multi_path_add_from_input_tooltip => '从输入添加路径';

  @override
  String get st_multi_path_remove_tooltip => '移除此路径';

  @override
  String st_common_form_field_label(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'dir': '监控目录',
      'pattern': '匹配通配符',
      'mime': '媒体类型部分',
      'minSize': '最小尺寸 (字节)',
      'maxSize': '最大尺寸 (字节)',
      'startDate': '开始日期',
      'endDate': '结束日期',
      'sortBy': '排序依据',
      'sortOrder': '排序顺序',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_common_variables_body_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'appVarsTitle': '应用只读变量',
      'appVarsDesc': '这些变量反映当前应用目录设置。路径使用 POSIX 分隔符 (/)。点按复制图标即可将占位符插入模板。',
      'custVarsTitle': '自定义变量',
      'custVarsDesc':
          '变量名必须以字母或下划线开头（例如 myVar）。路径值必须使用 POSIX 分隔符（例如 /home/user/docs）。',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String get rs_common_global_action_copied => '已复制到剪贴板';

  @override
  String get cd_common_action_edit_notTextFile => '仅能编辑文本文件。';

  @override
  String get cd_common_action_view_notViewable => '仅能查看文本或图像文件。';

  @override
  String get rs_common_action_move_success => '移动成功！';

  @override
  String rs_common_action_file_error(Object err) {
    return '错误：$err';
  }

  @override
  String get cd_common_action_rename_exists => '文件已存在。请先将其删除。';

  @override
  String st_common_dialog_title(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': '重命名',
      'delete': '删除文件',
      'erase': '安全抹除文件',
      'touch': '修改时间',
      'unsaved': '未保存更改',
      'applock': '启用应用锁',
      'filter': '筛选文件',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String cd_common_dialog_confirm_message(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'delete': '确定要删除此文件吗？',
      'erase': '确定要安全抹除此文件吗？',
      'unsaved': '您有未保存的内容。确定要放弃并离开吗？',
      'applock': '请确认您已妥善保存了应用锁的密码或备份。如果在没有凭证的情况下启用应用锁，您可能会被锁定无法登录应用。',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String get cd_vault_action_security_check_failed => '安全性检查失败。';

  @override
  String rs_edit_action_auto_save_failed(Object error) {
    return '自动保存失败：$error';
  }

  @override
  String get rs_edit_action_journal_saved => '日记已保存！';

  @override
  String rs_key_action_success(String action, Object path) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'regenerate': '重新生成密钥成功。',
      'save': '保存密钥成功。',
      'saveto': '保存密钥到 $path 成功。',
      'load': '从文件加载密钥成功。',
      'loadenv': '从环境变量 $path 加载密钥成功。',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String rs_edit_action_file_write_failed(Object error) {
    return '文件写入失败：$error';
  }

  @override
  String cd_key_action_file_invalid(Object error) {
    return '$error';
  }

  @override
  String st_common_dialog_confirm_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': '重命名',
      'delete': '删除',
      'erase': '安全抹除',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String rs_clipher_action_decryption_failed(Object error) {
    return '解密失败：$error';
  }

  @override
  String rs_clipher_action_encryption_failed(Object error) {
    return '加密失败：$error';
  }

  @override
  String rs_autocrypt_action_command_result(Object text) {
    return '$text';
  }

  @override
  String get cd_autocrypt_action_no_input => '未选择输入文件';

  @override
  String common_auth_dialog_passwordTooShort_error(Object length) {
    return '密码太短 (长度必须至少为 $length 个字符)。';
  }

  @override
  String get common_auth_dialog_passwordInSecure_error =>
      '密码必须包含至少一个大写字母、一个小写字母、一个数字和一个特殊字符。';

  @override
  String get common_auth_dialog_passwordRequired_error => '必须指定密码或密钥文件。';

  @override
  String common_auth_dialog_fileNameIsSamed_error(Object file) {
    return '目标文件名不能与原文件名相同：$file';
  }

  @override
  String get common_auth_dialog_fileNameIsEmpty_error => '文件名不能为空。';

  @override
  String common_auth_dialog_fileIsExist_error(Object file) {
    return '文件已存在：$file。';
  }

  @override
  String common_auth_dialog_fileIsNotExist_error(Object file) {
    return '文件不存在：$file。';
  }

  @override
  String common_auth_dialog_fileIsNotReadable_error(Object file) {
    return '文件不可读：$file。';
  }

  @override
  String common_auth_dialog_fileIsNotWritable_error(Object file) {
    return '文件不可写：$file。';
  }

  @override
  String common_auth_dialog_PathIsNotWritable_error(Object file) {
    return '文件路径不可写：$file。';
  }

  @override
  String common_auth_dialog_fileIsEmpty_error(Object file) {
    return '文件为空：$file。';
  }

  @override
  String common_auth_dialog_fileIsEncrypted_error(Object file) {
    return '文件已加密：$file。';
  }

  @override
  String common_auth_dialog_fileIsDecrypted_error(Object file) {
    return '文件类型不是有效的已解密文件：$file。';
  }
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class AppLocalizationsZhHk extends AppLocalizationsZh {
  AppLocalizationsZhHk() : super('zh_HK');

  @override
  String st_home_drawer_setting_cleanupLabel(String cleanup) {
    String _temp0 = intl.Intl.selectLogic(cleanup, {
      'keep': '保留',
      'delete': '刪除',
      'wipelow': '擦除 (填零)',
      'wipemedium': '擦除 (填位)',
      'wipehigh': '擦除 (隨機)',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_cleanupParam(String param) {
    String _temp0 = intl.Intl.selectLogic(param, {
      'level': '擦除級別',
      'iter': '迭代次數',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_themeLabel(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'system': '跟隨系統',
      'light': '淺色模式',
      'dark': '深色模式',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_langLabel(String lang) {
    String _temp0 = intl.Intl.selectLogic(lang, {
      'en': '英文',
      'zh': '簡體中文',
      'hk': '繁體中文',
      'de': '德文',
      'ja': '日文',
      'ru': '俄文',
      'es': '西班牙文',
      'pt': '葡萄牙文',
      'fr': '法文',
      'ko': '韓文',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_applockLabel(String applock) {
    String _temp0 = intl.Intl.selectLogic(applock, {
      'none': '無',
      'passphrase': '口令鎖',
      'biometrics': '生物識別',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autolockLabel(String autolock) {
    String _temp0 = intl.Intl.selectLogic(autolock, {
      'm1': '1 分鐘後',
      'm5': '5 分鐘後',
      'm15': '15 分鐘後',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autoccLabel(String autocc) {
    String _temp0 = intl.Intl.selectLogic(autocc, {
      's00': '已禁用',
      's10': '10 秒後',
      's30': '30 秒後',
      's60': '60 秒後',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autosaveLabel(String autosave) {
    String _temp0 = intl.Intl.selectLogic(autosave, {
      's00': '已禁用',
      's05': '5 秒後',
      's10': '10 秒後',
      's20': '20 秒後',
      's30': '30 秒後',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'theme': '主題模式',
      'lang': '顯示語言',
      'secret': '安全金鑰',
      'applock': '應用鎖定',
      'autolock': '自動鎖定',
      'autoclear': '剪貼簿清除',
      'autosave': '筆記自動儲存',
      'cleanup': '源檔案處理',
      'overwrite': '覆蓋現有檔案',
      'stats': '保險庫統計',
      'mime': '自訂 MIME 類型',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String cd_setting_mime(String status, Object tooltip) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'success': '載入 mime.types 成功。',
      'empty': '載入失敗：mime.types 資料為空。',
      'nottext': '載入失敗：需要文字檔案。',
      'other': '其他',
    });
    return '$_temp0 $tooltip';
  }

  @override
  String get st_setting_mime_tooltip =>
      '載入 mime.types 以擴展全域 MIME 偵測，用於篩選、圖示分類與打包/自動壓縮邏輯。';

  @override
  String st_home_drawer_directory_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'notes': '筆記目錄',
      'encrypt': '加密輸出目錄',
      'decrypt': '解密輸出目錄',
      'archive': '歸档輸出目錄',
      'unarchive': '提取歸档',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_nav_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'notes': '加密筆記',
      'vault': '保險庫',
      'shredding': '安全擦除',
      'encrypt': '檔案加密',
      'decrypt': '檔案解密',
      'archive': '歸档壓縮',
      'unarchive': '提取歸档',
      'about': '關於',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_popup_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'copy': '複製',
      'copyto': '複製到...',
      'moveto': '移動到...',
      'copypath': '複製路徑',
      'rename': '重新命名...',
      'touch': '修改時間',
      'view': '查看',
      'edit': '編輯',
      'delete': '刪除',
      'erase': '安全抹除',
      'save': '儲存',
      'saveto': '儲存到...',
      'reset': '重置',
      'clear': '清除',
      'refresh': '重新整理',
      'pickenv': '從環境變數載入',
      'regen': '重新生成',
      'pickfile': '選擇檔案',
      'pickfolder': '選擇資料夾',
      'openfile': '開啟檔案',
      'openfolder': '開啟資料夾',
      'home': '首頁',
      'eula': '最終用戶許可協定',
      'about': '關於',
      'help': '幫助',
      'quit': '退出',
      'share': '分享',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_button_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'close': '關閉',
      'cancel': '取消',
      'confirm': '確定',
      'reset': '重置',
      'new_': '新建',
      'save': '儲存',
      'view': '查看',
      'variables': '變數',
      'accept': '接受',
      'copyall': '全部複製',
      'pickfiles': '選取檔案',
      'sharefiles': '分享檔案',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String get st_home_index_header_defaultTitle => '首頁';

  @override
  String get st_home_index_counter_incrementLabel => '您已點擊按鈕這麼多次：';

  @override
  String get st_home_index_counter_incrementAction => '增加';

  @override
  String st_action_autocrypt_button_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'waiting': '等待選擇檔案或資料夾...',
      'processing': '處理中...',
      'encrypt': '加密檔案',
      'decrypt': '解密檔案',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String get st_common_global_info_independent => '注意：列表中的每一項都將獨立處理。';

  @override
  String get st_common_global_info_noGlobal => '注意：目前設置僅對本次操作生效，不會全域儲存。';

  @override
  String get st_archive_global_info_compression =>
      '注意：文字檔案將被壓縮為 .gz，目錄將被打包並壓縮為 .tgz。';

  @override
  String get st_archive_global_info_independent =>
      '注意：列表中的每一項都將独立处理，不會合併到一個归档中。';

  @override
  String get st_decrypt_global_info_atomic =>
      '原子解密：此工具僅負責解密檔案。如果結果是 .tgz 或 .gz 包，請使用「提取歸档」工具進行解壓。';

  @override
  String get st_encrypt_global_info_atomic =>
      '原子加密：僅支援加密檔案。如需加密目錄，请先使用「歸档壓縮」工具建立 .tgz 包。';

  @override
  String get st_unarchive_global_info_support =>
      '注意：支援提取 .gz (單檔案) 和 .tar、.tgz (目錄包)。';

  @override
  String st_home_briefing_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'header': '💡 每日簡報',
      'helpHeader': '🌐 幫助與支持',
      'doc': '📖 文檔指南',
      'sponsor': '☕ 贊助支持',
      'status': '保險庫狀態',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String get st_multi_file_only_empty_hint => '拖放檔案到此處';

  @override
  String get st_single_path_empty_hint => '拖放檔案/資料夾，或从選單瀏覽選取';

  @override
  String get st_multi_path_empty_hint => '拖放檔案或資料夾到此处';

  @override
  String get st_multi_path_manage_title => '管理路徑';

  @override
  String get st_multi_path_paste_hint => '在此貼上路徑 (以換行或逗號分隔)';

  @override
  String get st_common_dialog_unsaved_title => '未儲存變更';

  @override
  String get cd_common_dialog_unsaved_body => '您有未儲存的内容。確定要放棄並離開嗎？';

  @override
  String get st_edit_text_hint => '開始寫作...';

  @override
  String get st_multi_path_add_tooltip => '添加路徑';

  @override
  String get st_multi_path_add_from_input_tooltip => '從輸入添加路徑';

  @override
  String get st_multi_path_remove_tooltip => '移除此路徑';

  @override
  String st_common_form_field_label(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'dir': '監控目錄',
      'pattern': '比對萬用字元',
      'mime': '媒體類型部分',
      'minSize': '最小尺寸 (位元組)',
      'maxSize': '最大尺寸 (位元組)',
      'startDate': '開始日期',
      'endDate': '結束日期',
      'sortBy': '排序依據',
      'sortOrder': '排序順序',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String st_common_variables_body_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'appVarsTitle': '應用唯讀變數',
      'appVarsDesc': '這些變數會反映目前應用程式目錄設定。路徑使用 POSIX 分隔符號 (/)。點按複製圖示即可將佔位符插入範本。',
      'custVarsTitle': '自訂變數',
      'custVarsDesc':
          '變數名稱必須以字母或底線開頭（例如 myVar）。路徑值必須使用 POSIX 分隔符號（例如 /home/user/docs）。',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String get rs_common_global_action_copied => '已複製到剪貼簿';

  @override
  String get cd_common_action_edit_notTextFile => '僅能編輯文字檔案。';

  @override
  String get cd_common_action_view_notViewable => '僅能查看文字或影像檔案。';

  @override
  String get rs_common_action_move_success => '移動成功！';

  @override
  String rs_common_action_file_error(Object err) {
    return '錯誤：$err';
  }

  @override
  String get cd_common_action_rename_exists => '檔案已存在。請先將其刪除。';

  @override
  String st_common_dialog_title(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': '重新命名',
      'delete': '刪除檔案',
      'erase': '安全抹除檔案',
      'touch': '修改時間',
      'unsaved': '未儲存變更',
      'applock': '啟用應用鎖',
      'filter': '篩選檔案',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String cd_common_dialog_confirm_message(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'delete': '確定要刪除此檔案嗎？',
      'erase': '確定要安全抹除此檔案嗎？',
      'unsaved': '您有未儲存的内容。確定要放棄並離開嗎？',
      'applock': '請確認您已妥善保存應用鎖的密碼或備份。如在沒有憑證情況下啟用應用鎖，您可能會被鎖定無法登入應用。',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String get cd_vault_action_security_check_failed => '安全性檢查失敗。';

  @override
  String rs_edit_action_auto_save_failed(Object error) {
    return '自動儲存失敗：$error';
  }

  @override
  String get rs_edit_action_journal_saved => '日誌已儲存！';

  @override
  String rs_key_action_success(String action, Object path) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'regenerate': '重新生成金鑰成功。',
      'save': '儲存金鑰成功。',
      'saveto': '儲存金鑰到 $path 成功。',
      'load': '从檔案載入金鑰成功。',
      'loadenv': '从環境變數 $path 載入金鑰成功。',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String rs_edit_action_file_write_failed(Object error) {
    return '檔案寫入失敗：$error';
  }

  @override
  String cd_key_action_file_invalid(Object error) {
    return '$error';
  }

  @override
  String st_common_dialog_confirm_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': '重新命名',
      'delete': '刪除',
      'erase': '安全抹除',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String rs_clipher_action_decryption_failed(Object error) {
    return '解密失敗：$error';
  }

  @override
  String rs_clipher_action_encryption_failed(Object error) {
    return '加密失敗：$error';
  }

  @override
  String rs_autocrypt_action_command_result(Object text) {
    return '$text';
  }

  @override
  String get cd_autocrypt_action_no_input => '未选择輸入檔案';

  @override
  String common_auth_dialog_passwordTooShort_error(Object length) {
    return '密碼太短 (長度必須至少为 $length 個字元)。';
  }

  @override
  String get common_auth_dialog_passwordInSecure_error =>
      '密碼必須包含至少一个大寫字母、一个小寫字母、一个数字和一个特殊字元。';

  @override
  String get common_auth_dialog_passwordRequired_error => '必須指定密碼或金鑰檔案。';

  @override
  String common_auth_dialog_fileNameIsSamed_error(Object file) {
    return '目标檔案名不能与原檔案名相同：$file';
  }

  @override
  String get common_auth_dialog_fileNameIsEmpty_error => '檔案名不能为空。';

  @override
  String common_auth_dialog_fileIsExist_error(Object file) {
    return '檔案已存在：$file。';
  }

  @override
  String common_auth_dialog_fileIsNotExist_error(Object file) {
    return '檔案不存在：$file。';
  }

  @override
  String common_auth_dialog_fileIsNotReadable_error(Object file) {
    return '檔案不可讀：$file。';
  }

  @override
  String common_auth_dialog_fileIsNotWritable_error(Object file) {
    return '檔案不可寫：$file。';
  }

  @override
  String common_auth_dialog_PathIsNotWritable_error(Object file) {
    return '檔案路徑不可寫：$file。';
  }

  @override
  String common_auth_dialog_fileIsEmpty_error(Object file) {
    return '檔案为空：$file。';
  }

  @override
  String common_auth_dialog_fileIsEncrypted_error(Object file) {
    return '檔案已加密：$file。';
  }

  @override
  String common_auth_dialog_fileIsDecrypted_error(Object file) {
    return '檔案類型不是有效的已解密檔案：$file。';
  }
}
