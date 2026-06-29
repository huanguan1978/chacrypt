// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String st_home_drawer_setting_cleanupLabel(String cleanup) {
    String _temp0 = intl.Intl.selectLogic(cleanup, {
      'keep': 'Manter',
      'delete': 'Excluir',
      'wipelow': 'Apagar (zeros)',
      'wipemedium': 'Apagar (bits)',
      'wipehigh': 'Apagar (aleat)',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_cleanupParam(String param) {
    String _temp0 = intl.Intl.selectLogic(param, {
      'level': 'Nível de exclusão',
      'iter': 'Iterações',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_themeLabel(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'system': 'Sistema',
      'light': 'Claro',
      'dark': 'Escuro',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_langLabel(String lang) {
    String _temp0 = intl.Intl.selectLogic(lang, {
      'en': 'Inglês',
      'zh': 'Chinês simplificado',
      'hk': 'Chinês tradicional',
      'de': 'Alemão',
      'ja': 'Japonês',
      'ru': 'Russo',
      'es': 'Espanhol',
      'pt': 'Português',
      'fr': 'Francês',
      'ko': 'Coreano',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_applockLabel(String applock) {
    String _temp0 = intl.Intl.selectLogic(applock, {
      'none': 'Nenhum',
      'passphrase': 'Frase secreta',
      'biometrics': 'Biometria',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autolockLabel(String autolock) {
    String _temp0 = intl.Intl.selectLogic(autolock, {
      'm1': 'Após 1 min',
      'm5': 'Após 5 min',
      'm15': 'Após 15 min',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autoccLabel(String autocc) {
    String _temp0 = intl.Intl.selectLogic(autocc, {
      's00': 'Desativado',
      's10': 'Após 10 seg',
      's30': 'Após 30 seg',
      's60': 'Após 60 seg',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_autosaveLabel(String autosave) {
    String _temp0 = intl.Intl.selectLogic(autosave, {
      's00': 'Desativado',
      's05': 'Após 5 seg',
      's10': 'Após 10 seg',
      's20': 'Após 20 seg',
      's30': 'Após 30 seg',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String st_home_drawer_setting_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'theme': 'Modo de tema',
      'lang': 'Idioma',
      'secret': 'Chave secreta',
      'applock': 'Bloqueio de app',
      'autolock': 'Autobloqueio',
      'autoclear': 'Limpar área de transferência',
      'autosave': 'Salvamento automático de notas',
      'cleanup': 'Limpeza de origem',
      'overwrite': 'Sobrescrever arquivos existentes',
      'stats': 'Estatísticas do cofre',
      'mime': 'Tipos MIME personalizados',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String cd_setting_mime(String status, Object tooltip) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'success': 'mime.types carregado com sucesso.',
      'empty': 'Falha ao carregar: mime.types está vazio.',
      'nottext': 'Falha ao carregar: arquivo de texto necessário.',
      'other': 'Outro',
    });
    return '$_temp0 $tooltip';
  }

  @override
  String get st_setting_mime_tooltip =>
      'Carregue um arquivo mime.types para expandir a detecção de MIME para filtragem, classificação de ícones e lógica de empacotamento/auto-compressão.';

  @override
  String st_home_drawer_directory_title(String title) {
    String _temp0 = intl.Intl.selectLogic(title, {
      'notes': 'Diretório de notas',
      'encrypt': 'Diretório criptografado',
      'decrypt': 'Diretório descriptografado',
      'archive': 'Diretório de arquivos',
      'unarchive': 'Diretório de extração',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_nav_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'notes': 'Notas seguras',
      'vault': 'Cofre',
      'shredding': 'Exclusão segura',
      'encrypt': 'Criptografar',
      'decrypt': 'Descriptografar',
      'archive': 'Arquivar',
      'unarchive': 'Extrair',
      'about': 'Sobre',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_popup_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'copy': 'Copiar',
      'copyto': 'Copiar para...',
      'moveto': 'Mover para...',
      'copypath': 'Copiar caminho',
      'rename': 'Renomear...',
      'touch': 'Modificar data',
      'view': 'Visualizar',
      'edit': 'Editar',
      'delete': 'Excluir',
      'erase': 'Apagar',
      'save': 'Salvar',
      'saveto': 'Salvar em...',
      'reset': 'Redefinir',
      'clear': 'Limpar',
      'refresh': 'Atualizar',
      'pickenv': 'Do ambiente',
      'regen': 'Regenerar',
      'pickfile': 'Escolher arquivo',
      'pickfolder': 'Escolher pasta',
      'openfile': 'Abrir arquivo',
      'openfolder': 'Abrir pasta',
      'home': 'Início',
      'eula': 'EULA',
      'about': 'Sobre',
      'help': 'Ajuda',
      'quit': 'Sair',
      'share': 'Compartilhar',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String st_common_global_button_actionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'close': 'Fechar',
      'cancel': 'Cancelar',
      'confirm': 'Confirmar',
      'reset': 'Redefinir',
      'new_': 'Novo',
      'save': 'Salvar',
      'view': 'Visualizar',
      'variables': 'Variáveis',
      'accept': 'Aceitar',
      'copyall': 'Copiar tudo',
      'pickfiles': 'Selecionar arquivos',
      'sharefiles': 'Compartilhar arquivos',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String get st_home_index_header_defaultTitle => 'Início';

  @override
  String get st_home_index_counter_incrementLabel =>
      'Você pressionou o botão este número de vezes:';

  @override
  String get st_home_index_counter_incrementAction => 'Incrementar';

  @override
  String st_action_autocrypt_button_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'waiting': 'Aguardando arquivo | pasta...',
      'processing': 'Processando...',
      'encrypt': 'Criptografar arquivo',
      'decrypt': 'Descriptografar arquivo',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String get st_common_global_info_independent =>
      'Nota: Cada item na lista é processado independentemente.';

  @override
  String get st_common_global_info_noGlobal =>
      'Nota: As alterações de configurações atuais aplicam-se apenas a esta operação e não serão salvas globalmente.';

  @override
  String get st_archive_global_info_compression =>
      'Nota: Arquivos de texto são compactados em .gz, pastas em .tgz.';

  @override
  String get st_archive_global_info_independent =>
      'Nota: Itens não são mesclados em um único arquivo.';

  @override
  String get st_decrypt_global_info_atomic =>
      'Descriptografia atômica: Apenas para arquivos. Para pacotes .tgz/.gz use a ferramenta de extração.';

  @override
  String get st_encrypt_global_info_atomic =>
      'Criptografia atômica: Apenas arquivos suportados. Para pastas use primeiro a ferramenta de arquivamento.';

  @override
  String get st_unarchive_global_info_support =>
      'Nota: Suporta extração de .gz (arquivos únicos) e .tar, .tgz (pacotes de diretórios).';

  @override
  String st_home_briefing_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'header': '💡 Briefing diário',
      'helpHeader': '🌐 Ajuda e suporte',
      'doc': '📖 Documentação',
      'sponsor': '☕ Patrocinar',
      'status': 'Status do cofre',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String get st_multi_file_only_empty_hint => 'Arraste arquivos para cá';

  @override
  String get st_single_path_empty_hint =>
      'Arraste e solte o arquivo/pasta, ou selecione no menu';

  @override
  String get st_multi_path_empty_hint => 'Arraste arquivos/pastas para cá';

  @override
  String get st_multi_path_manage_title => 'Gerenciar caminhos';

  @override
  String get st_multi_path_paste_hint =>
      'Cole caminhos aqui (separados por linha ou vírgula)';

  @override
  String get st_common_dialog_unsaved_title => 'Alterações não salvas';

  @override
  String get cd_common_dialog_unsaved_body =>
      'Você tem conteúdo não salvo. Deseja descartar e sair?';

  @override
  String get st_edit_text_hint => 'Comece a escrever...';

  @override
  String get st_multi_path_add_tooltip => 'Adicionar caminhos';

  @override
  String get st_multi_path_add_from_input_tooltip =>
      'Adicionar caminhos da entrada';

  @override
  String get st_multi_path_remove_tooltip => 'Remover este caminho';

  @override
  String st_common_form_field_label(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'dir': 'Diretório monitorado',
      'pattern': 'Padrão glob',
      'mime': 'Tipo MIME',
      'minSize': 'Tam. mín (bytes)',
      'maxSize': 'Tam. máx (bytes)',
      'startDate': 'Data de início',
      'endDate': 'Data de término',
      'sortBy': 'Ordenar por',
      'sortOrder': 'Ordem',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String st_common_variables_body_label(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'appVarsTitle': 'Variáveis somente leitura do app',
      'appVarsDesc':
          'Estas variáveis refletem as configurações atuais do diretório do app. Os caminhos usam separadores POSIX (/). Toque no ícone de copiar para inserir o marcador no seu modelo.',
      'custVarsTitle': 'Variáveis personalizadas',
      'custVarsDesc':
          'Os nomes das variáveis devem começar com uma letra ou sublinhado (por exemplo, myVar). Os valores de caminho devem usar separadores POSIX (por exemplo, /home/user/docs).',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String get rs_common_global_action_copied =>
      'Copiado para a área de transferência';

  @override
  String get cd_common_action_edit_notTextFile =>
      'Apenas arquivos de texto podem ser editados.';

  @override
  String get cd_common_action_view_notViewable =>
      'Apenas arquivos de texto ou imagem podem ser visualizados.';

  @override
  String get rs_common_action_move_success => 'Movido!';

  @override
  String rs_common_action_file_error(Object err) {
    return 'Erro: $err';
  }

  @override
  String get cd_common_action_rename_exists =>
      'O arquivo já existe. Exclua-o primeiro.';

  @override
  String st_common_dialog_title(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': 'Renomear',
      'delete': 'Excluir arquivo',
      'erase': 'Excluir com segurança',
      'touch': 'Modificar data',
      'unsaved': 'Alterações não salvas',
      'applock': 'Ativar bloqueio do aplicativo',
      'filter': 'Filtrar arquivos',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String cd_common_dialog_confirm_message(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'delete': 'Tem certeza que deseja excluir este arquivo?',
      'erase': 'Tem certeza que deseja excluir este arquivo com segurança?',
      'unsaved': 'Você tem conteúdo não salvo. Deseja descartar e sair?',
      'applock':
          'Por favor, confirme que você armazenou com segurança sua senha ou backup. Se ativar o bloqueio do aplicativo sem credenciais, poderá ficar impossibilitado de acessar o aplicativo.',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String get cd_vault_action_security_check_failed =>
      'Falha na verificação de segurança.';

  @override
  String rs_edit_action_auto_save_failed(Object error) {
    return 'Falha no salvamento automático: $error';
  }

  @override
  String get rs_edit_action_journal_saved => 'Diário salvo!';

  @override
  String rs_key_action_success(String action, Object path) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'regenerate': 'Sucesso, chave regenerada.',
      'save': 'Sucesso, chave salva.',
      'saveto': 'Sucesso, salva em $path.',
      'load': 'Sucesso, carregada do arquivo.',
      'loadenv': 'Sucesso, carregada do ambiente: $path.',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String rs_edit_action_file_write_failed(Object error) {
    return 'Falha na escrita do arquivo: $error';
  }

  @override
  String cd_key_action_file_invalid(Object error) {
    return '$error';
  }

  @override
  String st_common_dialog_confirm_label(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'rename': 'RENOMEAR',
      'delete': 'EXCLUIR',
      'erase': 'APAGAR',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String rs_clipher_action_decryption_failed(Object error) {
    return 'Falha na descriptografia: $error';
  }

  @override
  String rs_clipher_action_encryption_failed(Object error) {
    return 'Falha na criptografia: $error';
  }

  @override
  String rs_autocrypt_action_command_result(Object text) {
    return '$text';
  }

  @override
  String get cd_autocrypt_action_no_input =>
      'Nenhum arquivo de entrada selecionado';

  @override
  String common_auth_dialog_passwordTooShort_error(Object length) {
    return 'A senha é muito curta (mínimo $length caracteres).';
  }

  @override
  String get common_auth_dialog_passwordInSecure_error =>
      'A senha deve conter maiúsculas, minúsculas, números e símbolos.';

  @override
  String get common_auth_dialog_passwordRequired_error =>
      'Especifique senha ou arquivo de chave.';

  @override
  String common_auth_dialog_fileNameIsSamed_error(Object file) {
    return 'O nome não pode ser igual ao arquivo: $file';
  }

  @override
  String get common_auth_dialog_fileNameIsEmpty_error =>
      'O nome do arquivo está vazio.';

  @override
  String common_auth_dialog_fileIsExist_error(Object file) {
    return 'O arquivo já existe: $file.';
  }

  @override
  String common_auth_dialog_fileIsNotExist_error(Object file) {
    return 'O arquivo não existe: $file.';
  }

  @override
  String common_auth_dialog_fileIsNotReadable_error(Object file) {
    return 'O arquivo não pode ser lido: $file.';
  }

  @override
  String common_auth_dialog_fileIsNotWritable_error(Object file) {
    return 'O arquivo não pode ser gravado: $file.';
  }

  @override
  String common_auth_dialog_PathIsNotWritable_error(Object file) {
    return 'O caminho do arquivo não permite gravação: $file.';
  }

  @override
  String common_auth_dialog_fileIsEmpty_error(Object file) {
    return 'O arquivo está vazio: $file.';
  }

  @override
  String common_auth_dialog_fileIsEncrypted_error(Object file) {
    return 'O arquivo já está criptografado: $file.';
  }

  @override
  String common_auth_dialog_fileIsDecrypted_error(Object file) {
    return 'O tipo de arquivo não é um arquivo descriptografado: $file.';
  }
}
