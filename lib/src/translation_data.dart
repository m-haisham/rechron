import 'dart:io';

import 'package:yaml/yaml.dart';

extension Sub on RegExp {
  String sub(String replacement, String source) {
    return source.replaceAllMapped(this, (match) {
      if (match.groupCount > 0) {
        var value = replacement;
        for (var i = 1; i <= match.groupCount; i++) {
          value = value.replaceAll('\\$i', match[i]!);
        }

        return value;
      } else {
        return replacement;
      }
    });
  }
}

abstract class SupplementaryData {
  Set<String> get skip;
  Map<String, String> get tokenMap;
  Map<String, String> get simplifications;
  Map<String, String> get simplificationsRegex;
  Map<String, String> get relativeType;
  Map<RegExp, String> get relativeTypeRegex;

  String simplify(String source) {
    source = source.toLowerCase();
    source = source
        .split(' ')
        .map((word) => simplifications[word] ?? word)
        .join(' ');

    for (final entry in simplificationsRegex.entries) {
      source = RegExp(entry.key).sub(entry.value, source);
    }

    return source;
  }
}

class FileData extends SupplementaryData {
  FileData(this.locale)
      : content = loadYaml(
            File('data/supplementary_data/$locale.yaml').readAsStringSync());

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
  Map<String, String> get simplifications {
    return {
      for (final map in content['simplifications'])
        for (final entry in map.entries) entry.key: entry.value
    };
  }

  @override
  Map<String, String> get simplificationsRegex {
    return {
      for (final map in content['simplifications-regex'])
        for (final entry in map.entries) entry.key: entry.value
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
      'simplifications',
      'simplifications-regex'
    };

    final keys = content.keys.where((key) => !nop.contains(key));
    return {
      for (final key in keys)
        for (final value in content[key]) value: key
    };
  }
}
