/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'package:chabox/page/home/widget/setting/note_autosave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';

import '../../../../utils/caching.dart';
import '../../helper/security_briefing.dart';
import 'mime_file.dart';
import 'key.dart';
import 'language.dart';
import 'stats.dart';
import 'theme.dart';
import 'notes_folder.dart';
import 'encrypted_folder.dart';
import 'decrypted_folder.dart';
import 'archived_folder.dart';
import 'unarchived_folder.dart';
import 'cleanup.dart';
import 'overwrite.dart';
import 'app_lock.dart';
import 'auto_lock.dart';
import 'clipboard_clear.dart';

class SettingDrawer extends StatelessWidget with WatchItMixin {
  const SettingDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          /*
          const DrawerHeader(
            // decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              "Settings",
              // style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          */
          SettingTheme(),
          SettingLanguage(
            onSelected: (lang) {
              sl<BriefingService>().loadDatabase(
                lang,
                onLoaded: (_) => sl<Caching>().briefingUpdated.value++,
              );
            },
          ),

          const Divider(),
          SettingKey(),
          SettingAppLock(),
          SettingAutoLock(),
          SettingAutoClearClipboard(),

          const Divider(),
          SettingAutoSave(),
          SettingNotesFolder(),

          const Divider(),
          SettingEncryptedFolder(),
          SettingDecryptedFolder(),

          const Divider(),
          SettingArchivedFolder(),
          SettingUnarchivedFolder(),

          const Divider(),
          SpecMimeTypes(),
          SettingCleanup(),
          SettingOverwrite(),
          SettingStats(),
        ],
      ),
    );
  }
}
