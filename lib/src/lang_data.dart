import 'package:dateparser/generated/generated.dart' as generated;
import 'package:dateparser_core/dateparser_core.dart';

class GeneratedData extends LangData {
  GeneratedData(this.lang) : data = generated.data[_getLocale(lang)]!;

  final String lang;
  final Map<String, dynamic> data;

  String get locale => _getLocale(lang);

  @override
  Map<String, String> get relativeType => data['relative-type'];

  @override
  Map<RegExp, String> get relativeTypeRegex => data['relative-type-regex'];

  @override
  Map<String, String> get simplifications => data['simplifications'];

  @override
  Map<RegExp, String> get simplificationsRegex => data['simplifications-regex'];

  @override
  Set<String> get skip => data['skip'];

  @override
  Map<String, TokenType> get tokenMap => data['tokenMap'];
}

String _getLocale(String lang) =>
    lang.contains('-') ? lang.split('-').first : lang;
