/*
 * ChaBox - Offline Secure Vault
 * Description: A high-performance file security workstation built on 
 * the industry-grade ChaCha20-Poly1305 authenticated encryption standard.
 * 
 * Copyright (c) 2026 ChaBox Contributors
 * Distributed under the PolyForm Noncommercial 1.0.0 license.
 * https://github.com/huanguan1978/chacrypt
 */

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ClipboardData, Clipboard;
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:mime/mime.dart' show MimeTypeResolver;
import 'package:path/path.dart' as p;
import 'package:file_selector/file_selector.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/constant.dart';
import '../../thirdparty/ft_textmime.dart';
import '../../thirdparty/ft_wipe.dart' show fileOverWrite;
import '../../utils/file_helper.dart';
import '../../utils/responsive.dart';

import '../edit/text_clipher_page.dart';
import '../edit/text_plain_page.dart';
import '../view/image_cipher_page.dart';
import '../view/image_plain_page.dart';
import '../view/text_cipher_page.dart';
import '../view/text_plain_page.dart';

import '../../widget/enum_menu_entity.dart';
import '../../message/definition.dart';

void onFileSelectedAction(
  BuildContext context,
  MenuEntity? action,
  Object? passthrough, {
  VoidCallback? onDone,
}) {
  if (action == null) return;
  assert(passthrough is File, "passthrough required File.");
  final file = passthrough as File;

  switch (action) {
    case MenuEntity.share:
      var mimeType = 'application/octet-stream';
      if (!file.path.endsWith(chaFileExtName)) {
        mimeType = sl<MimeTypeResolver>().lookup(file.path) ?? mimeType;
      }
      final fileName = p.basename(file.path);
      final fileModified = file.lastModifiedSync();
      final params = ShareParams(
        title: fileName,
        files: [
          XFile(
            file.path,
            mimeType: mimeType,
            name: fileName,
            lastModified: fileModified,
          ),
        ],
      );

      SharePlus.instance.share(params).then((value) {
        if (!context.mounted) return;
        context.showSnackBar(value.toString());
      });

      break;

    case MenuEntity.edit:
      final (realName, fileExts) = fileNameWithExts(file.path);
      final isTextFile = isTextMimeType(realName);
      if (isTextFile) {
        if (fileExts.isNotEmpty) {
          final lastExt = '.${fileExts.last}';
          if (lastExt.endsWith(chaFileExtName)) {
            context.push(TextClipherEditPage(chaFile: file));
            return;
          } else {
            context.push(TextPlainEditPage(txtFile: file));
            return;
          }
        } else {
          context.push(TextPlainEditPage(txtFile: file));
          return;
        }
      }

      context.showSnackBar(ME.tr(MD.cdCommonActionEditNotTextFile));

      break;

    case MenuEntity.view:
      final (realName, fileExts) = fileNameWithExts(file.path);
      final isImageFile = isImageMimeType(realName);
      if (isImageFile) {
        if (fileExts.isNotEmpty) {
          final lastExt = '.${fileExts.last}';
          if (lastExt.endsWith(chaFileExtName)) {
            context.push(ImageCipherViewPage(file));
            return;
          } else {
            context.push(ImagePlainViewPage(file));
            return;
          }
        } else {
          context.push(ImagePlainViewPage(file));
          return;
        }
      }

      final isTextFile = isTextMimeType(realName);
      if (isTextFile) {
        if (fileExts.isNotEmpty) {
          final lastExt = '.${fileExts.last}';
          if (lastExt.endsWith(chaFileExtName)) {
            context.push(TextCipherViewPage(file));
            return;
          } else {
            context.push(TextPlainViewPage(file));
            return;
          }
        } else {
          context.push(TextPlainViewPage(file));
          return;
        }
      }

      context.showSnackBar(ME.tr(MD.cdCommonActionViewNotViewable));
      break;

    case MenuEntity.copyto:
      final fileName = p.basename(file.path);
      getSaveLocation(suggestedName: fileName).then((
        FileSaveLocation? location,
      ) {
        if (location != null) {
          file
              .copy(location.path)
              .then(
                (value) {
                  if (context.mounted) {
                    context.showSnackBar(ME.tr(MD.rsCommonGlobalActionCopied));
                  }
                  // Sync source file's last modified time to target file
                  try {
                    value.setLastModifiedSync(file.lastModifiedSync());
                  } catch (e) {
                    sl<Logger>().warning(
                      "Failed to sync modification time: $e",
                    );
                  }
                },
                onError: (e, st) {
                  sl<Logger>().severe("$action, $e");
                  if (context.mounted) {
                    context.showSnackBar(
                      ME.tr(MD.rsCommonActionFileError, args: {'error': '$e'}),
                    );
                  }
                },
              );
        }
      });

      break;
    case MenuEntity.moveto:
      final fileName = p.basename(file.path);
      getSaveLocation(suggestedName: fileName).then((
        FileSaveLocation? location,
      ) {
        if (location != null) {
          file
              .rename(location.path)
              .then(
                (value) {
                  if (context.mounted) {
                    context.showSnackBar(ME.tr(MD.rsCommonActionMoveSuccess));
                  }
                },
                onError: (e, st) {
                  sl<Logger>().severe("$action, $e");
                  if (context.mounted) {
                    context.showSnackBar(
                      ME.tr(MD.rsCommonActionFileError, args: {'error': '$e'}),
                    );
                  }
                },
              );
        }
      });
      break;
    case MenuEntity.copypath:
      Clipboard.setData(ClipboardData(text: file.path));
      context.showSnackBar(ME.tr(MD.rsCommonGlobalActionCopied));
      break;
    case MenuEntity.touch:
      final currentDt = file.lastModifiedSync();
      final timeStr = currentDt.toString().split('.').first;
      final controller = TextEditingController(text: timeStr);
      final formKey = GlobalKey<FormState>();

      context
          .showInputDialog(
            title: Text(
              ME.tr(MD.stCommonDialogTitle, args: {'action': action.name}),
            ),
            content: Text("Path: ${file.path}"),
            controller: controller,
            cancelText: ME.tr(
              MD.stCommonGlobalButtonActionLabel,
              args: {'action': 'cancel'},
            ),
            confirmText: ME.tr(
              MD.stCommonGlobalButtonActionLabel,
              args: {'action': 'confirm'},
            ),
            inputField: Form(
              key: formKey,
              child: TextFormField(
                controller: controller,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "Modify Date (YYYY-MM-DD HH:MM:SS)",
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || DateTime.tryParse(val) == null) {
                    return "Invalid date format";
                  }
                  return null;
                },
              ),
            ),
            onConfirm: (dialogContext) {
              if (formKey.currentState!.validate()) {
                Navigator.pop(dialogContext, controller.text.trim());
              }
            },
          )
          .then((newTimeStr) {
            if (newTimeStr == null) return;
            final newDt = DateTime.parse(newTimeStr);
            try {
              file.setLastModifiedSync(newDt);
              onDone?.call();
            } catch (e) {
              sl<Logger>().severe("$action, $e");
              if (context.mounted) {
                context.showSnackBar(
                  ME.tr(MD.rsCommonActionFileError, args: {'err': '$e'}),
                );
              }
            }
          });
      break;

    case MenuEntity.rename:
      final fileName = p.basename(file.path);
      final directory = p.dirname(file.path);

      String extName = p.extension(fileName);
      String baseName = p.basenameWithoutExtension(fileName);

      if (fileName.endsWith(chaNoteExtName)) {
        extName = chaNoteExtName;
        baseName = fileName.substring(0, fileName.length - extName.length);
      } else if (fileName.endsWith(chaFileExtName)) {
        extName = chaFileExtName;
        baseName = fileName.substring(0, fileName.length - extName.length);
      }

      final controller = TextEditingController(text: baseName);
      final formKey = GlobalKey<FormState>();
      controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: baseName.length,
      );

      context
          .showInputDialog(
            title: Text(
              ME.tr(MD.stCommonDialogTitle, args: {'action': action.name}),
            ),
            content: Text("Path: $directory"),
            controller: controller,
            cancelText: ME.tr(
              MD.stCommonGlobalButtonActionLabel,
              args: {'action': 'cancel'},
            ),
            confirmText: ME.tr(
              MD.stCommonDialogConfirmLabel,
              args: {'action': action.name},
            ),
            inputField: Form(
              key: formKey,
              child: TextFormField(
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "New Name",
                  suffixText: extName,
                  border: const OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Name cannot be empty";
                  final newPath = p.join(directory, "$val$extName");
                  if (File(newPath).existsSync() &&
                      "$val$extName" != fileName) {
                    return "File already exists";
                  }
                  return null;
                },
              ),
            ),
            onConfirm: (dialogContext) {
              if (formKey.currentState!.validate()) {
                Navigator.pop(dialogContext, controller.text.trim());
              }
            },
          )
          .then((newBase) {
            if (newBase == null) return;
            final newPath = p.join(directory, "$newBase$extName");
            try {
              file.renameSync(newPath);
              onDone?.call();
            } catch (e) {
              sl<Logger>().severe("$action, $e");
              if (context.mounted) {
                context.showSnackBar(
                  ME.tr(MD.rsCommonActionFileError, args: {'err': '$e'}),
                );
              }
            }
          });
      break;

    case MenuEntity.delete:
      context
          .showConfirmDialog(
            title: Text(
              ME.tr(MD.stCommonDialogTitle, args: {'action': action.name}),
            ),
            content: Text(
              ME.tr(
                MD.cdCommonDialogConfirmMessage,
                args: {'action': action.name},
              ),
            ),
            cancelText: ME.tr(
              MD.stCommonGlobalButtonActionLabel,
              args: {'action': 'cancel'},
            ),
            confirmText: ME.tr(
              MD.stCommonDialogConfirmLabel,
              args: {'action': action.name},
            ),
            confirmColor: Colors.red,
          )
          .then((confirmed) {
            if (confirmed == true) {
              try {
                file.deleteSync();
                onDone?.call();
              } catch (e) {
                sl<Logger>().severe("$action, $e");
                if (context.mounted) {
                  context.showSnackBar(
                    ME.tr(MD.rsCommonActionFileError, args: {'err': '$e'}),
                  );
                }
              }
            }
          });
      break;

    case MenuEntity.erase:
      context
          .showConfirmDialog(
            title: Text(
              ME.tr(MD.stCommonDialogTitle, args: {'action': action.name}),
            ),
            content: Text(
              ME.tr(
                MD.cdCommonDialogConfirmMessage,
                args: {'action': action.name},
              ),
            ),
            cancelText: ME.tr(
              MD.stCommonGlobalButtonActionLabel,
              args: {'action': 'cancel'},
            ),
            confirmText: ME.tr(
              MD.stCommonDialogConfirmLabel,
              args: {'action': action.name},
            ),
            confirmColor: Colors.red,
          )
          .then((confirmed) {
            if (confirmed == true) {
              try {
                fileOverWrite(file);
              } catch (e) {
                sl<Logger>().severe("$action, $e");
                if (context.mounted) {
                  context.showSnackBar(
                    ME.tr(MD.rsCommonActionFileError, args: {'err': '$e'}),
                  );
                }
              }
            }
          });
      break;

    default:
  }
}
