import 'package:rechron_core/rechron_core.dart';

abstract class Reporter {
  /// Report a compiler error at the [token] with [message].
  void errorAt(Token token, String message);

  /// Report the provided stack
  void stack(List<Value> stack);
}

abstract class WriterReporter extends Reporter {
  /// Override this to change the location of write
  void write(Object value);

  @override
  void errorAt(Token token, String message) {
    write('Error');

    if (token.type == TokenType.eof) {
      write(' at end');
    } else if (token.type == TokenType.error) {
      // Nothing.
    } else {
      write(" at '${token.value}'");
    }

    write(": $message\n");
  }

  @override
  void stack(List<Value> stack) {
    write('     ');
    for (final value in stack.reversed) {
      write('[$value]');
    }
    write('\n');
  }
}
