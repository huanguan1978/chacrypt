import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';

import 'responsive.dart';

/// Common error handler for directory selection failures.
///
/// If [context] is provided, this also shows a snack bar with the error text.
void onDirPickError(
  Object error, {
  StackTrace? stackTrace,
  BuildContext? context,
}) {
  final Logger logger = sl<Logger>();
  final message = error is Error || error is Exception
      ? error.toString()
      : error.runtimeType.toString();

  logger.severe('Directory selection failed: $message', error, stackTrace);

  if (context case BuildContext context when context.mounted) {
    context.showSnackBar(message);
  }
}
