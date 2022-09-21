import 'package:rechron_core/src/token.dart';
import 'package:rechron_core/src/utils.dart';

/// Language specific data used when parsing.
abstract class LocaleData {
  /// Convert [source] and return a string that can be parsed by
  /// The scanner.
  ///
  /// This may involve translating the [source] into the language
  /// understood by the vm.
  String preprocess(String source) {
    source = simplify(source);
    source = relative(source);
    return source;
  }

  /// Apply [simplifications] and [simplificationsRegex]
  String simplify(String source) {
    source = source
        .toLowerCase()
        .split(' ')
        .map((word) => simplifications[word] ?? word)
        .join(' ');

    for (final entry in simplificationsRegex.entries) {
      source = entry.key.sub(entry.value, source);
    }

    return source;
  }

  /// Apply [relativeType] and [relativeTypeRegex]
  String relative(String source) {
    for (final entry in relativeType.entries.toList()
      ..sort(
        (a, b) => a.key.compareTo(b.key),
      )) {
      source = source.replaceAll(entry.key, entry.value);
    }

    for (final entry in relativeTypeRegex.entries) {
      source = entry.key.sub(entry.value, source);
    }

    return source;
  }

  /// Words that are not recorded in scanner.
  Set<String> get skip;

  /// Extend the keywords understood by the scanner
  Map<String, TokenType> get tokenMap;

  /// Strings for translating relative strings (ex: 'a moment ago')
  Map<String, String> get relativeType;

  /// Patterns for translating the source string.
  Map<RegExp, String> get relativeTypeRegex;

  /// Single word swaps (ex: 'a' to 1)
  Map<String, String> get simplifications;

  /// Patterns for simplifying the source string.
  Map<RegExp, String> get simplificationsRegex;
}
