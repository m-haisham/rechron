import 'dart:convert';
import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dateparser_core/dateparser_core.dart';
import 'package:yaml/yaml.dart';

class Data {
  const Data(this.lang, this.info, this.others);

  static Future<Data> fromLang(String lang) async {
    return Data(
      lang,
      jsonDecode(
        await File('data/translation_data/$lang.json').readAsString(),
      ),
      Map.from(loadYaml(
        await File('data/supplementary_data/$lang.yaml').readAsString(),
      )),
    );
  }

  final String lang;
  final Map<String, dynamic> info;
  final Map<String, dynamic> others;

  Set<String> get skip => {for (final value in others['skip']) value};

  Map<String, Expression> get tokenMap {
    final map = <String, Expression>{};

    for (final entry in keywords.entries) {
      for (final value in info[entry.key] ?? const []) {
        map[value] = CodeExpression(Code(entry.value.toString()));
      }

      for (final value in others[entry.key] ?? const []) {
        map[value] = CodeExpression(Code(entry.value.toString()));
      }
    }

    return map;
  }

  Map<String, String> get relativeType {
    final map = <String, String>{
      for (final entry in info['relative-type']?.entries ?? [])
        for (final value in entry.value) value: entry.key,
      for (final entry in others['relative-type']?.entries ?? [])
        for (final value in entry.value) value: entry.key,
    };

    return Map.fromEntries(
      map.entries.toList()
        ..sort(
          (a, b) => b.key.length.compareTo(a.key.length),
        ),
    );
  }

  Map<Expression, Expression> get relativeTypeRegex {
    final map = <Expression, Expression>{
      for (final entry in info['relative-type-regex']?.entries ?? [])
        for (final value in entry.value)
          literalString(value, raw: true): literalString(entry.key, raw: true),
      for (final entry in others['relative-type-regex']?.entries ?? [])
        for (final value in entry.value)
          literalString(value, raw: true): literalString(entry.key, raw: true),
    };

    return Map.fromEntries(
      map.entries.toList()
        ..sort(
          (a, b) => b.key.code.toString().compareTo(a.key.code.toString()),
        ),
    );
  }

  Map<String, String> get simplifications {
    return {
      for (final map in others['simplifications']!)
        for (final entry in map.entries) entry.key: entry.value
    };
  }

  Map<Expression, Expression> get simplificationsRegex {
    final map = {
      for (final map in others['simplifications-regex']!)
        for (final entry in map.entries)
          literalString(entry.key, raw: true):
              literalString(entry.value, raw: true)
    };

    return Map.fromEntries(
      map.entries.toList()
        ..sort(
          (a, b) => b.key.code.toString().compareTo(a.key.code.toString()),
        ),
    );
  }

  String build() {
    final emitter = DartEmitter.scoped();
    final packageName = 'dateparser_core';

    final data = literal({
      'skip': literal(skip),
      'tokenMap': literal(tokenMap),
      'relativeType': literal(relativeType),
      'relativeTypeRegex': literal(relativeTypeRegex),
      'simplifications': literal(simplifications),
      'simplificationsRegex': literal(simplificationsRegex),
    });

    final library = Library(
      (b) => b.body.addAll([
        Directive.import(
          'package:$packageName/$packageName.dart',
          show: ['TokenType'],
        ),
        Code('const data = <String, dynamic>${data.accept(emitter)};'),
      ]),
    );

    return library.accept(emitter).toString();
  }

  String safeEscape(String value) => value.replaceAll(r'\', r'\\');
}
