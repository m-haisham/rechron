library rechron;

import 'package:rechron/src/generated_data.dart';
import 'package:rechron_core/rechron_core.dart';

export 'package:rechron_core/rechron_core.dart';

DateTime parse(String source, {LocaleData? locale}) {
  final data = locale ?? GeneratedData('en');
  source = data.preprocess(source);

  final chunk = Chunk();
  final parser = Parser(source, chunk, data: data);
  if (!parser.compile()) {
    throw CompileException();
  }

  final vm = VM(chunk);
  final result = vm.run();
  switch (result) {
    case InterpretResult.ok:
      break;
    case InterpretResult.compileError:
    case InterpretResult.runtimeError:
      throw RuntimeException();
  }

  final value = vm.stack.removeLast();
  if (value is! DateTimeValue) {
    throw UnexpectedResultException();
  }

  return value.value;
}
