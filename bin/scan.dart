import 'package:dateparser/src/data/translation_data.dart';
import 'package:dateparser/src/scanner.dart';
import 'package:dateparser/src/token.dart';

void main(List<String> args) {
  final translationData = TranslationData('en');
  final content = translationData.simplify(args.first);

  final scanner = Scanner(content, data: translationData);
  while (true) {
    final token = scanner.scanToken();
    if (token.type == TokenType.EOF) {
      break;
    }

    print(token);
  }
}
