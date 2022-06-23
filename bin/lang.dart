import 'package:dateparser/src/translation_data.dart';

void main(List<String> args) {
  final locale = args.isEmpty ? 'en' : args.first;

  final data = FileData(locale);

  print('skip:');
  print(data.skip);
  print('');

  print('tokenMap:');
  print(data.tokenMap);
  print('');

  print('relative-type:');
  print(data.relativeType);
  print('');

  print('relative-type-regex:');
  print(data.relativeTypeRegex);
  print('');

  print('simplifications:');
  print(data.simplifications);
  print('');
}
