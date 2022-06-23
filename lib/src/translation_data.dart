import 'dart:io';

import 'package:yaml/yaml.dart';

abstract class TranslationData {
  Set<String> get skip;
  Map<String, String> get tokenMap;
  Map<RegExp, String> get simplifications;
  Map<String, String> get relativeType;
  Map<RegExp, String> get relativeTypeRegex;
}

class FileData extends TranslationData {
  FileData(this.locale)
      : content = loadYaml(
            File('data/translation_data/$locale.yaml').readAsStringSync());

  final String locale;
  final YamlMap content;

  @override
  Map<String, String> get relativeType {
    return {
      for (final entry in content['relative-type'].entries)
        for (final pattern in entry.value) pattern: entry.key
    };
  }

  @override
  Map<RegExp, String> get relativeTypeRegex {
    return {
      for (final entry in content['relative-type-regex'].entries)
        for (final pattern in entry.value) RegExp(pattern): entry.key
    };
  }

  @override
  Map<RegExp, String> get simplifications {
    return {
      for (final map in content['simplifications'])
        for (final entry in map.entries) RegExp(entry.key): entry.value
    };
  }

  @override
  Set<String> get skip {
    return {for (final value in content['skip']) value};
  }

  @override
  Map<String, String> get tokenMap {
    final nop = {
      'skip',
      'pertain',
      'sentence_splitter_group',
      'relative-type',
      'relative-type-regex',
      'simplifications'
    };

    final keys = content.keys.where((key) => !nop.contains(key));
    return {
      for (final key in keys)
        for (final value in content[key]) value: key
    };
  }
}
