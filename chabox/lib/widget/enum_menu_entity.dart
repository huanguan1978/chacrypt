/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'enum_menu_item.dart';

/// Standard menu definitions used across the application.
enum MenuEntity implements MenuItem {
  // file list optional menu
  copy(label: 'copy'),
  copyto(label: 'copy to...'),
  moveto(label: 'move to...'),
  copypath(label: 'copy path'),
  rename(label: 'rename...'),
  view(label: 'view'),
  edit(label: 'edit'),
  delete(label: 'delete'),
  erase(label: 'erase'),
  save(label: 'save'),
  saveto(label: 'save to...'),
  touch(label: 'modify date'),
  share(label: 'share file'),

  // form optional menu
  reset(label: 'reset'),

  // logger view optional menu
  clear(label: 'clear'),
  refresh(label: 'refresh'),

  // password optional menu
  pickenv(label: 'pick environ'),
  regen(label: 'regenerate'),

  // file source optional menu
  pickfile(label: 'pick file'),
  pickfolder(label: 'pick folder'),
  openfile(label: 'open file'),
  openfolder(label: 'open folder'),

  // navigation action
  notes(label: 'Secure Notes'),
  vault(label: 'Secure Vault'),
  shredding(label: 'Secure Erase'),
  encrypt(label: 'encrypt'),
  decrypt(label: 'decrypt'),
  archive(label: 'archive'),
  unarchive(label: 'unarchive'),

  // navigation menu
  home(label: 'home'),
  eula(label: 'eula'),
  about(label: 'about'),
  help(label: 'help'),
  quit(label: 'quit');

  @override
  final String? label;

  const MenuEntity({this.label});

  Widget getIcon({double size = 24.0}) {
    return switch (this) {
      copy => FaIcon(FontAwesomeIcons.copy, size: size),
      copyto => FaIcon(FontAwesomeIcons.clone, size: size),
      moveto => FaIcon(FontAwesomeIcons.arrowRight, size: size),
      copypath => FaIcon(FontAwesomeIcons.link, size: size),
      rename => FaIcon(FontAwesomeIcons.penToSquare, size: size),
      view => FaIcon(FontAwesomeIcons.eye, size: size),
      edit => FaIcon(FontAwesomeIcons.pen, size: size),
      delete => FaIcon(FontAwesomeIcons.trash, size: size),
      erase => FaIcon(FontAwesomeIcons.eraser, size: size),
      save => FaIcon(FontAwesomeIcons.floppyDisk, size: size),
      saveto => FaIcon(FontAwesomeIcons.fileExport, size: size),
      touch => FaIcon(FontAwesomeIcons.calendarDay, size: size),
      share => FaIcon(FontAwesomeIcons.share, size: size),

      reset => FaIcon(FontAwesomeIcons.arrowRotateLeft, size: size),
      clear => FaIcon(FontAwesomeIcons.trashCan, size: size),
      refresh => FaIcon(FontAwesomeIcons.arrowsRotate, size: size),

      pickenv => FaIcon(FontAwesomeIcons.terminal, size: size),
      regen => FaIcon(FontAwesomeIcons.arrowsRotate, size: size),

      pickfile => FaIcon(FontAwesomeIcons.file, size: size),
      pickfolder => FaIcon(FontAwesomeIcons.folder, size: size),
      openfile => FaIcon(FontAwesomeIcons.fileArrowDown, size: size),
      openfolder => FaIcon(FontAwesomeIcons.folderOpen, size: size),
      notes => FaIcon(FontAwesomeIcons.noteSticky, size: size),
      vault => FaIcon(FontAwesomeIcons.vault, size: size),
      shredding => FaIcon(FontAwesomeIcons.eraser, size: size),
      encrypt => FaIcon(FontAwesomeIcons.lock, size: size),
      decrypt => FaIcon(FontAwesomeIcons.unlock, size: size),
      archive => FaIcon(FontAwesomeIcons.boxArchive, size: size),
      unarchive => FaIcon(FontAwesomeIcons.boxOpen, size: size),
      home => FaIcon(FontAwesomeIcons.house, size: size),
      eula => FaIcon(FontAwesomeIcons.fileContract, size: size),
      about => FaIcon(FontAwesomeIcons.circleInfo, size: size),
      help => FaIcon(FontAwesomeIcons.circleQuestion, size: size),
      quit => FaIcon(FontAwesomeIcons.arrowRightFromBracket, size: size),
    };
  }

  @override
  Widget? get icon => getIcon(size: 16);
}
