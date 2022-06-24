import 'package:dateparser/src/data/translation_data.dart';

void main(List<String> args) {
  final locale = args.isEmpty ? 'en' : args.first;
  final source = args.length < 2 ? '1h2m' : args[1];

  final data = TranslationData(locale);

  print('simplify:');
  print(data.simplify(source));
  print('');
}
