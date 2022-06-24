import 'package:dateparser/generated/generated.dart' as generated;
import 'package:dateparser/src/token.dart';
import 'package:dateparser/src/utils.dart';

// TODO: optimize
class TranslationData {
  TranslationData(String locale)
      : info = generated.data[locale]!['translation']!,
        others = generated.data[locale]!['supplementary']!;

  final Map<String, dynamic> info;
  final Map<String, dynamic> others;

  String preprocess(String source) {
    source = simplify(source);
    source = relative(source);
    return source;
  }

  String simplify(String source) {
    source = source
        .toLowerCase()
        .split(' ')
        .map((word) => _simplificationsData[word] ?? word)
        .join(' ');

    for (final entry in _simplificationsRegex.entries) {
      source = RegExp(entry.key).sub(entry.value, source);
    }

    return source;
  }

  Map<String, String> get _simplificationsData {
    return {
      for (final map in others['simplifications']!)
        for (final entry in map.entries) entry.key: entry.value
    };
  }

  Map<String, String> get _simplificationsRegex {
    return {
      for (final map in others['simplifications-regex']!)
        for (final entry in map.entries) entry.key: entry.value
    };
  }

  String relative(String source) {
    for (final entry in relativeTypeData.entries) {
      source = source.replaceAll(entry.key, entry.value);
    }

    return source;
  }

  Map<String, String> get relativeTypeData {
    final data = <String, String>{};
    for (final entry in info['relative-type'].entries) {
      for (final value in entry.value) {
        data[value] = entry.key;
      }
    }

    for (final entry in others['relative-type'].entries) {
      for (final value in entry.value) {
        data[value] = entry.key;
      }
    }

    return data;
  }

  Map<String, TokenType>? _tokenMapCache;
  Map<String, TokenType> get tokenMap {
    if (_tokenMapCache == null) {
      _tokenMapCache = {};
      for (final entry in keywords.entries) {
        for (final value in info[entry.key] ?? const []) {
          _tokenMapCache![value] = entry.value;
        }

        for (final value in others[entry.key] ?? const []) {
          _tokenMapCache![value] = entry.value;
        }
      }
    }

    return _tokenMapCache!;
  }
}
