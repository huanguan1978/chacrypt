part of '../../chapose.dart';

typedef ME = MessageEngine;
typedef ML = MessageLevel;
typedef MD = CliMessageDefinition;

class CliMessageProvider extends MessageProvider<CliMessageDefinition> {
  final String? _locale;

  CliMessageProvider([this._locale]);

  @override
  String resolve(CliMessageDefinition message, {Map<String, Object>? args}) {
    // final methodName = message.key.replaceAll('.', '_');
    return Intl.message(
      message.msg,
      name: message.key,
      args: args?.values.toList(),
      locale: _locale,
    );
  }
}
