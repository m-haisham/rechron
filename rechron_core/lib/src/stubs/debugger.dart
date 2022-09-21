import 'package:rechron_core/rechron_core.dart';

abstract class Debugger {
  /// Disassemble the byte code of the chunk in a readable way
  void chunk(Chunk chunk, String name);

  /// Disassemble the instruction and dependant constant values.
  int instruction(Chunk chunk, int offset);
}

abstract class WriterDebugger extends Debugger {
  /// Write the given [value]
  void write(Object value);

  /// Disassemble the byte code of the chunk in a readable way
  @override
  void chunk(Chunk chunk, String name) {
    write("== $name ==\n");
    for (var offset = 0; offset < chunk.code.length;) {
      offset = instruction(chunk, offset);
    }
  }

  /// Disassemble the instruction and dependant constant values.
  @override
  int instruction(Chunk chunk, int offset) {
    write('${offset.toString().padLeft(4, "0")} ');

    final instruction = chunk.code[offset].toCode();
    switch (instruction) {
      case OpCode.durationDay:
        return _simpleInstruction('OP_DURATION_DAYS', offset);
      case OpCode.durationHour:
        return _simpleInstruction('OP_DURATION_HOURS', offset);
      case OpCode.durationMinute:
        return _simpleInstruction('OP_DURATION_MINUTES', offset);
      case OpCode.durationSecond:
        return _simpleInstruction('OP_DURATION_SECONDS', offset);
      case OpCode.durationMoment:
        return _simpleInstruction('OP_DURATION_MOMENT', offset);

      case OpCode.directionAgo:
        return _simpleInstruction('OP_DIRECTION_AGO', offset);
      case OpCode.directionIn:
        return _simpleInstruction('OP_DIRECTION_REMAINING', offset);

      case OpCode.constant:
        return _constantInstruction('OP_CONSTANT', chunk, offset);

      case OpCode.add:
        return _simpleInstruction('OP_ADD', offset);
      case OpCode.multiply:
        return _simpleInstruction('OP_MULTIPLY', offset);
      case OpCode.subtract:
        return _simpleInstruction('OP_SUBTRACT', offset);

      case OpCode.end:
        return _simpleInstruction('OP_RETURN', offset);

      default:
        write("Unknown opcode $instruction\n");
        return offset + 1;
    }
  }

  /// Write a constant instruction
  int _constantInstruction(String name, Chunk chunk, int offset) {
    int constant = chunk.code[offset + 1];
    write(
        '${name.toString().padRight(16, " ")} ${constant.toString().padLeft(4, "0")} \'');
    write(chunk.constants[constant]);
    write("'\n");
    return offset + 2;
  }

  /// Write a simple instruction
  int _simpleInstruction(String name, int offset) {
    write('$name\n');
    return offset + 1;
  }
}
