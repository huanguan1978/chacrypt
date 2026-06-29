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
enum ButtonEntity implements MenuItem {
  // dialog button
  close(label: 'close'),
  cancel(label: 'cancel'),
  confirm(label: 'confirm'),
  remove(label: 'delete'),
  reset(label: 'reset'),

  // toolbar button
  new_(label: 'new'),
  save(label: 'save'),
  view(label: 'view'),
  variables(label: 'variables'),

  // file list
  pickfiles(label: 'pickfiles'),
  sharefiles(label: 'sharefiles'),

  // eula button
  accept(label: 'agree'),

  // multi path button
  copyall(label: 'copyall');

  @override
  final String? label;

  const ButtonEntity({this.label});

  Widget getIcon({double size = 24.0}) {
    return switch (this) {
      close => FaIcon(FontAwesomeIcons.xmark, size: size),
      cancel => FaIcon(FontAwesomeIcons.xmark, size: size),
      confirm => FaIcon(FontAwesomeIcons.check, size: size),
      remove => FaIcon(FontAwesomeIcons.trash, size: size),
      reset => FaIcon(FontAwesomeIcons.arrowRotateLeft, size: size),

      new_ => FaIcon(FontAwesomeIcons.plus, size: size),
      save => FaIcon(FontAwesomeIcons.floppyDisk, size: size),
      view => FaIcon(FontAwesomeIcons.eye, size: size),
      variables => FaIcon(FontAwesomeIcons.sliders, size: size),

      pickfiles => FaIcon(FontAwesomeIcons.fileCirclePlus, size: size),
      sharefiles => FaIcon(FontAwesomeIcons.shareNodes, size: size),

      accept => FaIcon(FontAwesomeIcons.circleCheck, size: size),
      copyall => FaIcon(FontAwesomeIcons.copy, size: size),
    };
  }

  @override
  Widget? get icon => getIcon(size: 16);
}
