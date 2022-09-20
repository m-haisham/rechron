library rechron;

import 'package:rechron/src/generated_data.dart';
import 'package:rechron_core/rechron_core.dart';

export 'package:rechron_core/rechron_core.dart';

/// Parse a duration or datetime from a human readable date string.
///
/// # Warnings
///
/// The function only supports [double], [Duration], or [DateTime] for [T].
/// Otherwise, it will always throw [UnexpectedResultException]
T parse<T>(String source, {LocaleData? locale}) {
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
  if (value is! Value<T>) {
    throw UnexpectedResultException();
  }

  return value.value;
}

/// Try to parse a human readable date string and return null when failed.
///
/// # Warnings
///
/// All the same warnings from [parse] apply to this function. But instead of
/// [UnexpectedResultException], [null] is return
T? tryParse<T>(String source, {LocaleData? locale}) {
  try {
    return parse(source);
  } on RechronException {
    return null;
  }
}
