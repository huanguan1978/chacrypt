import 'package:flutter/widgets.dart';

/// Routes are identified by unique integer IDs, acting as fingerprints.
/// The mapping is resolved at runtime to prevent static analysis.
enum ActionRoute {
  archive,
  encrypt,
  decrypt,
  unarchive,
  wipe,
  editCipher,
  editPlain,
  viewImageCipher,
  viewImagePlain,
  viewTextCipher,
  viewTextPlain,
  notesList,
  vaultList;

  int get code {
    switch (this) {
      case ActionRoute.archive:
        return 0x2001;
      case ActionRoute.encrypt:
        return 0x2002;
      case ActionRoute.decrypt:
        return 0x2003;
      case ActionRoute.unarchive:
        return 0x2004;
      case ActionRoute.wipe:
        return 0x2005;
      case ActionRoute.editCipher:
        return 0x2101;
      case ActionRoute.editPlain:
        return 0x2102;
      case ActionRoute.viewImageCipher:
        return 0x2201;
      case ActionRoute.viewImagePlain:
        return 0x2202;
      case ActionRoute.viewTextCipher:
        return 0x2203;
      case ActionRoute.viewTextPlain:
        return 0x2204;
      case ActionRoute.notesList:
        return 0x2301;
      case ActionRoute.vaultList:
        return 0x2302;
    }
  }
}

typedef ActionBuilder = Widget Function(BuildContext context, Object? params);

class ActionRouter {
  static final Map<int, ActionBuilder> _registry = {};

  /// Dynamically register a route handler at runtime.
  /// This decouples the Router from concrete Page classes.
  static void register(ActionRoute route, ActionBuilder builder) {
    _registry[route.code] = builder;
  }

  static void navigate(
    BuildContext context,
    ActionRoute route, {
    Object? params,
  }) {
    final builder = _registry[route.code];
    if (builder != null) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, _) => builder(context, params),
        ),
      );
    }
  }
}
