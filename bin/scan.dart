import 'package:dateparser/src/scanner.dart';
import 'package:dateparser/src/token.dart';

void main(List<String> args) {
  final content = args.first;

  final scanner = Scanner(content);
  while (true) {
    final token = scanner.scanToken();
    if (token.type == TokenType.EOF) {
      break;
    }

    print(token);
  }
}
