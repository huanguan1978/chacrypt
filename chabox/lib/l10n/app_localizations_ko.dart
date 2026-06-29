// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String st_home_drawer_setting_cleanupLabel(String cleanup) {
    String _temp0 = intl.Intl.selectLogic(cleanup, {
      'keep': '유지',
      'delete': '삭제',
      'wipelow': '삭제(0으로 채우기)',
      'wipemedium': '삭제(비트로 채우기)',
      'wipehigh': '삭제(랜덤 채우기)',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_cleanupParam(String param) {
    String _temp0 = intl.Intl.selectLogic(param, {
      'level': '삭제 레벨',
      'iter': '반복 횟수',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_themeLabel(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'system': '시스템 설정',
      'light': '라이트 모드',
      'dark': '다크 모드',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_langLabel(String lang) {
    String _temp0 = intl.Intl.selectLogic(lang, {
      'en': '영어',
      'zh': '중국어 간체',
      'hk': '중국어 번체',
      'de': '독일어',
      'ja': '일본어',
      'ru': '러시아어',
      'es': '스페인어',
      'pt': '포르투갈어',
      'fr': '프랑스어',
      'ko': '한국어',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_applockLabel(String applock) {
    String _temp0 = intl.Intl.selectLogic(applock, {
      'none': '없음',
      'passphrase': '비밀번호',
      'biometrics': '생체 인식',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autolockLabel(String autolock) {
    String _temp0 = intl.Intl.selectLogic(autolock, {
      'm1': '1분 후',
      'm5': '5분 후',
      'm15': '15분 후',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autoccLabel(String autocc) {
    String _temp0 = intl.Intl.selectLogic(autocc, {
      's00': '비활성화',
      's10': '10초 후',
      's30': '30초 후',
      's60': '60초 후',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autosaveLabel(String autosave) {
    String _temp0 = intl.Intl.selectLogic(autosave, {
      's00': '비활성화',
      's05': '5초 후',
      's10': '10초 후',
      's20': '20초 후',
      's30': '30초 후',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'theme': '테마 모드',
      'lang': '표시 언어',
      'secret': '보안 키',
      'applock': '앱 잠금',
      'autolock': '자동 잠금',
      'autoclear': '클립보드 삭제',
      'autosave': '노트 자동 저장',
      'cleanup': '소스 정리',
      'overwrite': '기존 파일 덮어쓰기',
      'stats': '보관함 통계',
      'mime': '사용자 지정 MIME 유형',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String cd_setting_mime(String status, Object tooltip) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'success': 'mime.types 로드 성공.',
      'empty': '로드 실패: mime.types 데이터가 비어 있습니다.',
      'nottext': '로드 실패: 텍스트 파일이 필요합니다.',
      'other': '기타',
    });
    return '$_temp0 $tooltip';
  }

  @override
  String get st_setting_mime_tooltip =>
      '필터링, 아이콘 분류 및 패키징/자동 압축 로직을 위해 MIME 감지를 확장하려면 mime.types 파일을 로드하세요.';

  @override
  String st_home_drawer_directory_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'notes': '노트 저장 폴더',
      'encrypt': '암호화 저장 폴더',
      'decrypt': '복호화 저장 폴더',
      'archive': '아카이브 저장 폴더',
      'unarchive': '추출 저장 폴더',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_nav_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'notes': '보안 노트',
      'vault': '보관함',
      'shredding': '보안 삭제',
      'encrypt': '암호화',
      'decrypt': '복호화',
      'archive': '아카이브',
      'unarchive': '아카이브 해제',
      'about': '정보',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_popup_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'copy': '복사',
      'copyto': '...로 복사',
      'moveto': '...로 이동',
      'copypath': '경로 복사',
      'rename': '이름 변경...',
      'touch': '날짜 수정',
      'view': '보기',
      'edit': '편집',
      'delete': '삭제',
      'erase': '영구 삭제',
      'save': '저장',
      'saveto': '다른 이름으로 저장...',
      'reset': '초기화',
      'clear': '지우기',
      'refresh': '새로고침',
      'pickenv': '환경 변수에서',
      'regen': '재생성',
      'pickfile': '파일 선택',
      'pickfolder': '폴더 선택',
      'openfile': '파일 열기',
      'openfolder': '폴더 열기',
      'home': '홈',
      'eula': 'EULA',
      'about': '정보',
      'help': '도움말',
      'quit': '종료',
      'share': '공유',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_button_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'close': '닫기',
      'cancel': '취소',
      'confirm': '확인',
      'reset': '초기화',
      'new_': '새로 만들기',
      'save': '저장',
      'view': '보기',
      'variables': '변수',
      'accept': '동의',
      'copyall': '모두 복사',
      'pickfiles': '파일 선택',
      'sharefiles': '파일 공유',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String get st_home_index_header_defaultTitle => '홈';

  @override
  String get st_home_index_counter_incrementLabel => '버튼을 누른 횟수:';

  @override
  String get st_home_index_counter_incrementAction => '증가';

  @override
  String st_action_autocrypt_button_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'waiting': '파일/폴더 대기 중...',
      'processing': '처리 중...',
      'encrypt': '파일 암호화',
      'decrypt': '파일 복호화',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String get st_common_global_info_independent => '참고: 목록의 각 항목은 독립적으로 처리됩니다.';

  @override
  String get st_common_global_info_noGlobal =>
      '참고: 현재 설정은 이번 작업에만 적용되며 전역으로 저장되지 않습니다.';

  @override
  String get st_archive_global_info_compression =>
      '참고: 텍스트 파일은 .gz로, 디렉토리는 .tgz로 압축됩니다.';

  @override
  String get st_archive_global_info_independent =>
      '참고: 각 항목은 독립적으로 처리되며 하나의 아카이브로 합쳐지지 않습니다.';

  @override
  String get st_decrypt_global_info_atomic =>
      '원자적 복호화: 이 도구는 파일 복호화만 수행합니다. 결과가 .tgz/.gz인 경우 추출 도구를 사용하십시오.';

  @override
  String get st_encrypt_global_info_atomic =>
      '원자적 암호화: 파일만 지원됩니다. 디렉토리를 암호화하려면 먼저 아카이브 도구를 사용하십시오.';

  @override
  String get st_unarchive_global_info_support =>
      '참고: .gz(단일 파일) 및 .tar, .tgz(디렉토리 패키지) 추출을 지원합니다.';

  @override
  String st_home_briefing_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'header': '💡 데일리 브리핑',
      'helpHeader': '🌐 도움말 및 지원',
      'doc': '📖 문서 가이드',
      'sponsor': '☕ 후원하기',
      'status': '보관함 상태',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String get st_multi_file_only_empty_hint => '여기에 파일을 끌어다 놓으세요';

  @override
  String get st_single_path_empty_hint => '파일/폴더를 끌어다 놓거나 메뉴에서 선택하세요';

  @override
  String get st_multi_path_empty_hint => '여기에 파일 또는 폴더를 끌어다 놓으세요';

  @override
  String get st_multi_path_manage_title => '경로 관리';

  @override
  String get st_multi_path_paste_hint => '여기에 경로를 붙여넣으세요 (줄바꿈/쉼표 구분)';

  @override
  String get st_common_dialog_unsaved_title => '저장되지 않은 변경 사항';

  @override
  String get cd_common_dialog_unsaved_body => '저장되지 않은 내용이 있습니다. 무시하고 나갈까요?';

  @override
  String get st_edit_text_hint => '글쓰기 시작...';

  @override
  String get st_multi_path_add_tooltip => '경로 추가';

  @override
  String get st_multi_path_add_from_input_tooltip => '입력에서 경로 추가';

  @override
  String get st_multi_path_remove_tooltip => '이 경로 제거';

  @override
  String st_common_form_field_label(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'dir': '모니터링 디렉토리',
      'pattern': 'Glob 패턴',
      'mime': 'MIME 타입',
      'minSize': '최소 크기 (바이트)',
      'maxSize': '최대 크기 (바이트)',
      'startDate': '시작 날짜',
      'endDate': '종료 날짜',
      'sortBy': '정렬 기준',
      'sortOrder': '순서',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String st_common_variables_body_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'appVarsTitle': '읽기 전용 앱 변수',
      'appVarsDesc':
          '이 변수들은 현재 앱 디렉터리 설정을 반영합니다. 경로는 POSIX 구분자 (/) 를 사용합니다. 복사 아이콘을 탭하면 자리 표시자를 템플릿에 삽입할 수 있습니다.',
      'custVarsTitle': '사용자 지정 변수',
      'custVarsDesc':
          '변수 이름은 문자 또는 밑줄로 시작해야 합니다 (예: myVar). 경로 값은 POSIX 구분자 (예: /home/user/docs) 를 사용해야 합니다.',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String get rs_common_global_action_copied => '클립보드에 복사됨';

  @override
  String get cd_common_action_edit_notTextFile => '텍스트 파일만 편집 가능합니다.';

  @override
  String get cd_common_action_view_notViewable => '텍스트 또는 이미지 파일만 보기 가능합니다.';

  @override
  String get rs_common_action_move_success => '이동 완료!';

  @override
  String rs_common_action_file_error(Object err) {
    return '오류: $err';
  }

  @override
  String get cd_common_action_rename_exists => '파일이 이미 존재합니다. 먼저 삭제하세요.';

  @override
  String st_common_dialog_title(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': '이름 변경',
      'delete': '파일 삭제',
      'erase': '보안 영구 삭제',
      'touch': '날짜 수정',
      'unsaved': '저장되지 않은 변경 사항',
      'applock': '앱 잠금 활성화',
      'filter': '파일 필터링',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String cd_common_dialog_confirm_message(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'delete': '이 파일을 삭제하시겠습니까?',
      'erase': '이 파일을 보안 삭제하시겠습니까?',
      'unsaved': '저장되지 않은 내용이 있습니다. 나갈까요?',
      'applock':
          '앱 잠금을 활성화하기 전에 비밀번호 또는 백업을 안전하게 저장했는지 확인하세요. 자격 증명 없이 활성화하면 앱에 접근할 수 없게 될 수 있습니다.',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String get cd_vault_action_security_check_failed => '보안 확인 실패.';

  @override
  String rs_edit_action_auto_save_failed(Object error) {
    return '자동 저장 실패: $error';
  }

  @override
  String get rs_edit_action_journal_saved => '저널 저장 완료!';

  @override
  String rs_key_action_success(String action, Object path) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'regenerate': '성공, 보안 키 재생성.',
      'save': '성공, 보안 키 저장.',
      'saveto': '성공, $path에 저장.',
      'load': '성공, 파일에서 로드.',
      'loadenv': '성공, 환경 변수 $path에서 로드.',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String rs_edit_action_file_write_failed(Object error) {
    return '파일 쓰기 실패: $error';
  }

  @override
  String cd_key_action_file_invalid(Object error) {
    return '$error';
  }

  @override
  String st_common_dialog_confirm_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': '이름 변경',
      'delete': '삭제',
      'erase': '영구 삭제',
      'other': '기타',
    });
    return '$_temp0';
  }

  @override
  String rs_clipher_action_decryption_failed(Object error) {
    return '복호화 실패: $error';
  }

  @override
  String rs_clipher_action_encryption_failed(Object error) {
    return '암호화 실패: $error';
  }

  @override
  String rs_autocrypt_action_command_result(Object text) {
    return '$text';
  }

  @override
  String get cd_autocrypt_action_no_input => '입력 파일이 선택되지 않음';

  @override
  String common_auth_dialog_passwordTooShort_error(Object length) {
    return '비밀번호가 너무 짧습니다 (최소 $length자).';
  }

  @override
  String get common_auth_dialog_passwordInSecure_error =>
      '비밀번호는 대문자, 소문자, 숫자, 특수 문자를 각각 하나 이상 포함해야 합니다.';

  @override
  String get common_auth_dialog_passwordRequired_error =>
      '비밀번호 또는 키 파일을 지정해야 합니다.';

  @override
  String common_auth_dialog_fileNameIsSamed_error(Object file) {
    return '파일 이름은 원본 파일과 같을 수 없습니다: $file';
  }

  @override
  String get common_auth_dialog_fileNameIsEmpty_error => '파일 이름이 비어 있습니다.';

  @override
  String common_auth_dialog_fileIsExist_error(Object file) {
    return '파일이 이미 존재합니다: $file.';
  }

  @override
  String common_auth_dialog_fileIsNotExist_error(Object file) {
    return '파일이 존재하지 않습니다: $file.';
  }

  @override
  String common_auth_dialog_fileIsNotReadable_error(Object file) {
    return '파일을 읽을 수 없습니다: $file.';
  }

  @override
  String common_auth_dialog_fileIsNotWritable_error(Object file) {
    return '파일에 쓸 수 없습니다: $file.';
  }

  @override
  String common_auth_dialog_PathIsNotWritable_error(Object file) {
    return '파일 경로에 쓸 수 없습니다: $file.';
  }

  @override
  String common_auth_dialog_fileIsEmpty_error(Object file) {
    return '파일이 비어 있습니다: $file.';
  }

  @override
  String common_auth_dialog_fileIsEncrypted_error(Object file) {
    return '파일이 이미 암호화되어 있습니다: $file.';
  }

  @override
  String common_auth_dialog_fileIsDecrypted_error(Object file) {
    return '파일 형식이 복호화된 파일이 아닙니다: $file.';
  }
}
