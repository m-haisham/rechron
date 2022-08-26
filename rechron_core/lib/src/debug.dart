import 'dart:io';

import 'chunk.dart';

void disassembleChunk(Chunk chunk, String name) {
  print("== $name ==");
  for (var offset = 0; offset < chunk.code.length;) {
    offset = disassembleIntruction(chunk, offset);
  }
}

int disassembleIntruction(Chunk chunk, int offset) {
  stdout.write('${offset.toString().padLeft(4, "0")} ');

  final instruction = chunk.code[offset].toCode();
  switch (instruction) {
    case OpCode.durationDay:
      return simpleInstruction('OP_DURATION_DAYS', offset);
    case OpCode.durationHour:
      return simpleInstruction('OP_DURATION_HOURS', offset);
    case OpCode.durationMinute:
      return simpleInstruction('OP_DURATION_MINUTES', offset);
    case OpCode.durationSecond:
      return simpleInstruction('OP_DURATION_SECONDS', offset);
    case OpCode.durationMoment:
      return simpleInstruction('OP_DURATION_MOMENT', offset);

    case OpCode.directionAgo:
      return simpleInstruction('OP_DIRECTION_AGO', offset);
    case OpCode.directionIn:
      return simpleInstruction('OP_DIRECTION_REMAINING', offset);

    case OpCode.constant:
      return constantInstruction('OP_CONSTANT', chunk, offset);

    case OpCode.add:
      return simpleInstruction('OP_ADD', offset);
    case OpCode.multiply:
      return simpleInstruction('OP_MULTIPLY', offset);

    case OpCode.end:
      return simpleInstruction('OP_RETURN', offset);

    default:
      stdout.write("Unknown opcode $instruction\n");
      return offset + 1;
  }
}

int constantInstruction(String name, Chunk chunk, int offset) {
  int constant = chunk.code[offset + 1];
  stdout.write(
      '${name.toString().padRight(16, " ")} ${constant.toString().padLeft(4, "0")} \'');
  stdout.write(chunk.constants[constant]);
  stdout.write("'\n");
  return offset + 2;
}

int simpleInstruction(String name, int offset) {
  stdout.write('$name\n');
  return offset + 1;
}
