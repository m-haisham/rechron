library dateparser;

import 'package:dateparser/src/chunk.dart';
import 'package:dateparser/src/compiler.dart';
import 'package:dateparser/src/value.dart';
import 'package:dateparser/src/vm.dart';

DateTime parse(String source) {
  final chunk = Chunk();
  final parser = Parser(source, chunk);
  if (!parser.compile()) {
    throw Exception(); // FIXME: custom exception class
  }

  final vm = VM(chunk);
  final result = vm.run();
  switch (result) {
    case InterpretResult.ok:
      break;
    case InterpretResult.compileError:
    case InterpretResult.runtimeError:
      throw Exception(); // FIXME: custom exception class
  }

  final value = vm.stack.removeLast();
  if (value is! DateTimeValue) {
    throw Exception(); // FIXME: custom exception class
  }

  return value.value;
}
