import 'package:dateparser/src/data/translation_data.dart';
import 'package:dateparser/src/scanner.dart';
import '../packages/dateparser_core/lib/src/token.dart';

void main(List<String> args) {
  final data = TranslationData('en');
  final content = data.preprocess(args.first);

  final scanner = Scanner(content, data: data);
  while (true) {
    final token = scanner.scanToken();
    if (token.type == TokenType.CT_EOF) {
      break;
    }

    print(token);
  }
}
