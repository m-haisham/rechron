import 'package:dateparser/generated/generated.dart' as generated;
import 'package:dateparser/src/cache_mixin.dart';
import 'package:dateparser_core/dateparser_core.dart';

class GeneratedData extends LocaleData with CacheMixin {
  GeneratedData(this.locale) : data = generated.data[_getLang(locale)]!;

  final String locale;
  final Map<String, dynamic> data;

  String get lang => _getLang(locale);

  @override
  Map<String, String> get relativeType => data['relativeType'];

  @override
  Map<RegExp, String> get relativeTypeRegex {
    return cachedData(
      'relativeTypeRegex',
      () => {
        for (final entry in data['relativeTypeRegex'].entries)
          RegExp(entry.key): entry.value
      },
    );
  }

  @override
  Map<String, String> get simplifications => data['simplifications'];

  @override
  Map<RegExp, String> get simplificationsRegex {
    return cachedData(
      'simplificationsRegex',
      () => {
        for (final entry in data['simplificationsRegex'].entries)
          RegExp(entry.key): entry.value
      },
    );
  }

  @override
  Set<String> get skip => data['skip'];

  @override
  Map<String, TokenType> get tokenMap => data['tokenMap'];
}

String _getLang(String lang) =>
    lang.contains('-') ? lang.split('-').first : lang;
