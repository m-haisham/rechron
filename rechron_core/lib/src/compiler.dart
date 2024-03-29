import 'package:rechron_core/rechron_core.dart';

class Parser {
  Parser(
    this.source,
    this.chunk, {
    required this.data,
    this.reporter,
    this.debugger,
  }) : scanner = Scanner(source, data: data);

  final String source;
  final Chunk chunk;
  final Scanner scanner;

  final Reporter? reporter;
  final Debugger? debugger;

  final LocaleData data;

  Token previous = Token.empty();
  Token current = Token.empty();

  bool hadError = false;
  bool panicMode = false;

  bool compile() {
    advance();
    expression();
    consume(TokenType.eof, "Expect end of expression.");
    endCompiler();
    return !hadError;
  }

  void advance() {
    previous = current;

    // Parse until an error has been encountered
    while (!hadError) {
      current = scanner.scanToken();
      if (current.type == TokenType.skip) {
        continue;
      } else if (current.type == TokenType.error) {
        errorAtCurrent(current.value);
      } else {
        break;
      }
    }
  }

  void consume(TokenType type, String message) {
    if (current.type == type) {
      advance();
      return;
    }

    errorAtCurrent(message);
  }

  bool match(TokenType type) {
    if (!check(type)) return false;
    advance();
    return true;
  }

  bool check(TokenType type) {
    return current.type == type;
  }

  void endCompiler() {
    emitReturn();

    if (!hadError) {
      debugger?.chunk(chunk, 'code');
    }
  }

  // Expressions.

  /// [value]
  void expression() {
    value();
    if (match(TokenType.plus)) {
      expression();
      emitByte(OpCode.add.index);
    } else if (match(TokenType.minus)) {
      expression();
      emitByte(OpCode.subtract.index);
    }
  }

  /// [prefix] | [postfix]
  void value() {
    if (match(TokenType.keyIn)) {
      prefix();
    } else {
      postfix();
    }
  }

  /// 'in' [durationChain]
  void prefix() {
    durationChain();
    emitByte(OpCode.directionIn.index);
  }

  /// [durationChain] ( ago | remaining )?
  void postfix() {
    durationChain();
    direction();
  }

  /// [duration] [duration]*
  void durationChain() {
    duration();
    if (match(TokenType.comma) | check(TokenType.number)) {
      duration();
      emitByte(OpCode.add.index);
    }
  }

  /// number [timeframe]
  void duration() {
    if (match(TokenType.number)) {
      emitConstant(Value.number(double.parse(previous.value)));
      timeframe();
    } else {
      errorAtCurrent("Expect a positive number.");
    }
  }

  /// 'second' | 'minute' | 'hour' | 'day' | 'week' |
  /// 'month' | 'year' | 'decade'
  void timeframe() {
    if (match(TokenType.keyMoment)) {
      emitByte(OpCode.durationMoment.index);
    } else if (match(TokenType.keySecond)) {
      emitByte(OpCode.durationSecond.index);
    } else if (match(TokenType.keyMinute)) {
      emitByte(OpCode.durationMinute.index);
    } else if (match(TokenType.keyHour)) {
      emitByte(OpCode.durationHour.index);
    } else if (match(TokenType.keyDay)) {
      emitByte(OpCode.durationDay.index);
    } else if (match(TokenType.keyWeek)) {
      emitConstant(Value.number(7));
      emitByte(OpCode.multiply.index);
      emitByte(OpCode.durationDay.index);
    } else if (match(TokenType.keyMonth)) {
      // TODO: add days depending on calender month
      emitConstant(Value.number(30.437)); // Average days per month.
      emitByte(OpCode.multiply.index);
      emitByte(OpCode.durationDay.index);
    } else if (match(TokenType.keyYear)) {
      // TODO: account for leap year.
      emitConstant(Value.number(365.25)); // Average days per year.
      emitByte(OpCode.multiply.index);
      emitByte(OpCode.durationDay.index);
    } else if (match(TokenType.keyDecade)) {
      // TODO: account for leap year.
      final dayCount = (8.0 * 365.0) + (2.0 * 366.0);
      emitConstant(Value.number(dayCount));
      emitByte(OpCode.multiply.index);
      emitByte(OpCode.durationDay.index);
    } else {
      errorAtCurrent("Expect a timeframe indicator.");
    }
  }

  /// 'ago' | 'remaining'
  void direction() {
    if (match(TokenType.keyAgo)) {
      emitByte(OpCode.directionAgo.index);
    } else if (match(TokenType.keyIn)) {
      emitByte(OpCode.directionIn.index);
    }
  }

  /// Parse a number literal
  void number() {
    final value = double.parse(previous.value);
    emitConstant(Value.number(value));
  }

  // Byte.

  void emitByte(int byte) {
    chunk.writeRaw(byte);
  }

  void emitBytes(int byte1, int byte2) {
    chunk.writeRaw(byte1);
    chunk.writeRaw(byte2);
  }

  void emitReturn() {
    emitByte(OpCode.end.index);
  }

  // Constants.

  void emitConstant(Value value) {
    emitBytes(OpCode.constant.index, makeConstant(value));
  }

  int makeConstant(Value value) {
    final constant = chunk.addConstant(value);
    return constant;
  }

  // Errors.

  void errorAtCurrent(String message) {
    errorAt(current, message);
  }

  void error(String message) {
    errorAt(previous, message);
  }

  void errorAt(Token token, String message) {
    if (panicMode) return;
    panicMode = true;

    reporter?.errorAt(token, message);
    hadError = true;
  }
}
