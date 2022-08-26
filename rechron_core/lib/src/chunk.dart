
import 'package:rechron_core/src/value.dart';

enum OpCode {
  durationDay,
  durationHour,
  durationMinute,
  durationSecond,
  durationMoment,

  directionAgo,
  directionIn,

  constant,

  add,
  multiply,

  end;

  static from(int index) => OpCode.values[index];
}

extension ToCode on int {
  OpCode toCode() => OpCode.from(this);
}

class Chunk {
  Chunk();

  final List<int> code = [];
  final List<Value> constants = [];

  void write(OpCode code) {
    this.code.add(code.index);
  }

  void writeRaw(int code) {
    this.code.add(code);
  }

  int addConstant(Value value) {
    constants.add(value);
    return constants.length - 1;
  }
}
