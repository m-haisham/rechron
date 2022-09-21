import 'package:rechron_core/src/value.dart';

/// The collection of operation codes used by rechron virtual machine
enum OpCode {
  /// Duration with stack value in day
  durationDay,

  /// Duration with stack value in hour
  durationHour,

  /// Duration with stack value in minute
  durationMinute,

  /// Duration with stack value in second
  durationSecond,

  /// Empty duration
  durationMoment,

  /// DateTime by subtracting stack value from now
  directionAgo,

  /// DateTime by adding stack value to now
  directionIn,

  /// Push constant to stack
  constant,

  /// Add two stack values
  add,

  /// Multiply two stack values
  multiply,

  /// Subtract first stack value from second
  subtract,

  /// End runtime
  end;

  static from(int index) => OpCode.values[index];
}

extension ToCode on int {
  OpCode toCode() => OpCode.from(this);
}

/// A rechron compiled chunk
class Chunk {
  Chunk();

  final List<int> code = [];
  final List<Value> constants = [];

  /// Add [code] to the chunk
  void write(OpCode code) {
    this.code.add(code.index);
  }

  /// Add [code] to the chunk
  void writeRaw(int code) {
    this.code.add(code);
  }

  /// Add [value] to [constants] and return its index
  int addConstant(Value value) {
    constants.add(value);
    return constants.length - 1;
  }
}
