import 'package:rechron/src/generated_data.dart';
import 'package:rechron_core/rechron_core.dart';

void main(List<String> args) {
  final data = GeneratedData('en');
  final content = data.preprocess(args.first);

  final scanner = Scanner(content, data: data);
  while (true) {
    final token = scanner.scanToken();
    if (token.type == TokenType.eof) {
      break;
    }

    print(token);
  }
}
