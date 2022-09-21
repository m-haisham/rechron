import 'package:rechron_core/rechron_core.dart';

enum InterpretResult {
  ok,
  compileError,
  runtimeError,
}

class VM {
  VM(this.chunk, {this.reporter, this.debugger});

  final Reporter? reporter;
  final Debugger? debugger;

  final Chunk chunk;
  final List<Value> stack = [];

  int ip = 0;

  InterpretResult run() {
    while (true) {
      reporter?.stack(stack);
      debugger?.disassembleIntruction(chunk, ip);

      final instruction = read().toCode();
      switch (instruction) {
        case OpCode.durationDay:
          final count = (pop() as NumberValue).value;
          final duration = Duration(days: count.toInt());
          push(Value.duration(duration));
          break;
        case OpCode.durationHour:
          final count = (pop() as NumberValue).value;
          final duration = Duration(hours: count.toInt());
          push(Value.duration(duration));
          break;
        case OpCode.durationMinute:
          final count = (pop() as NumberValue).value;
          final duration = Duration(minutes: count.toInt());
          push(Value.duration(duration));
          break;
        case OpCode.durationSecond:
          final count = (pop() as NumberValue).value;
          final duration = Duration(seconds: count.toInt());
          push(Value.duration(duration));
          break;
        case OpCode.durationMoment:
          pop();
          push(Value.duration(Duration()));
          break;

        case OpCode.directionAgo:
          final duration = pop() as DurationValue;
          final dateTime = DateTime.now().subtract(duration.value);
          push(Value.dateTime(dateTime));
          break;
        case OpCode.directionIn:
          final duration = pop() as DurationValue;
          final dateTime = DateTime.now().add(duration.value);
          push(Value.dateTime(dateTime));
          break;

        case OpCode.constant:
          final constant = readConstant();
          push(constant);
          break;

        case OpCode.add:
          final b = pop();
          final a = pop();

          try {
            push(a + b);
          } on TypeError {
            return InterpretResult.runtimeError;
          }
          break;
        case OpCode.multiply:
          final b = pop();
          final a = pop();

          try {
            push(a * b);
          } on TypeError {
            return InterpretResult.runtimeError;
          }
          break;
        case OpCode.subtract:
          final b = pop();
          final a = pop();

          try {
            push(a - b);
          } on TypeError {
            return InterpretResult.runtimeError;
          }
          break;

        case OpCode.end:
          return InterpretResult.ok;
      }
    }
  }

  int read() {
    return chunk.code[ip++];
  }

  Value readConstant() {
    return chunk.constants[read()];
  }

  void push(Value value) => stack.add(value);
  Value pop() => stack.removeLast();
}
