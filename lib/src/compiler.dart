import 'dart:io';

import 'package:dateparser/src/debug.dart';
import 'package:dateparser/src/token.dart';
import 'package:dateparser/src/value.dart';

import 'chunk.dart';
import 'scanner.dart';

class Parser {
  Parser(this.source, this.chunk) : scanner = Scanner(source);

  final String source;
  final Chunk chunk;
  final Scanner scanner;

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

    while (true) {
      current = scanner.scanToken();
      if (current.type != TokenType.error) break;

      errorAtCurrent(current.value);
    }
  }

  void consume(TokenType type, String message) {
    if (current.type == type) {
      advance();
      return;
    }

    errorAtCurrent(message);
  }

  void consumeValue(String value, String message) {
    if (current.value == value) {
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

  bool matchValue(String value) {
    if (current.value != value) return false;
    advance();
    return true;
  }

  bool check(TokenType type) {
    return current.type == type;
  }

  void endCompiler() {
    emitReturn();

    // DEBUG: Comment out when testing is done
    if (!hadError) {
      disassembleChunk(chunk, 'code');
    }
    // DEBUG
  }

  // Expressions.

  void expression() {
    relative();
  }

  void relative() {
    if (matchValue("just")) {
      consumeValue("now", "Expect 'now' after 'just'.");
      emitByte(OpCode.PUSH_DATETIME_NOW.index);
    } else {
      relativeDay();
    }
  }

  void relativeDay() {
    if (matchValue("yesterday")) {
      emitConstant(Value.number(1));
      emitByte(OpCode.DURATION_DAYS.index);
      emitByte(OpCode.DIRECTION_AGO.index);
      emitByte(OpCode.INTO_DATE.index);
    } else if (matchValue("today")) {
      emitConstant(Value.number(0));
      emitByte(OpCode.DURATION_DAYS.index);
      emitByte(OpCode.DIRECTION_AGO.index);
      emitByte(OpCode.INTO_DATE.index);
    } else if (matchValue('tomorrow')) {
      emitConstant(Value.number(1));
      emitByte(OpCode.DURATION_DAYS.index);
      emitByte(OpCode.DIRECTION_REMAINING.index);
      emitByte(OpCode.INTO_DATE.index);
    } else {
      exact();
    }
  }

  void exact() {
    duration();
    if (match(TokenType.comma)) {
      bool hitAnd = false;
      do {
        if (matchValue('and')) {
          hitAnd = true;
          break;
        }

        duration();
        emitByte(OpCode.ADD.index);
      } while (match(TokenType.comma));

      if (hitAnd || matchValue('and')) {
        duration();
        emitByte(OpCode.ADD.index);
      }
    }

    direction();
  }

  void duration() {
    if (matchValue('a') || matchValue("an")) {
      emitConstant(Value.number(1));
      timeframe();
    } else if (match(TokenType.number)) {
      emitConstant(Value.number(double.parse(previous.value)));
      timeframe();
    } else {
      errorAtCurrent("Expect a number or 'a'.");
    }
  }

  void timeframe() {
    if (matchValue('moment')) {
      emitByte(OpCode.DURATION_MOMENT.index);
    } else if (matchValue('second') || matchValue('seconds')) {
      emitByte(OpCode.DURATION_SECONDS.index);
    } else if (matchValue('minute') || matchValue('minutes')) {
      emitByte(OpCode.DURATION_MINUTES.index);
    } else if (matchValue('hour') || matchValue('hours')) {
      emitByte(OpCode.DURATION_HOURS.index);
    } else if (matchValue('day') || matchValue('days')) {
      emitByte(OpCode.DURATION_DAYS.index);
    } else if (matchValue('week') || matchValue('weeks')) {
      emitConstant(Value.number(7));
      emitByte(OpCode.MULTIPLY.index);
      emitByte(OpCode.DURATION_DAYS.index);
    } else if (matchValue('month') || matchValue('months')) {
      // TODO: add days depending on calender month
      emitConstant(Value.number(30.437)); // Average days per month.
      emitByte(OpCode.MULTIPLY.index);
      emitByte(OpCode.DURATION_DAYS.index);
    } else {
      errorAtCurrent("Expect a timeframe indicator.");
    }
  }

  void direction() {
    if (matchValue('ago')) {
      emitByte(OpCode.DIRECTION_AGO.index);
    } else if (matchValue('remaining')) {
      emitByte(OpCode.DIRECTION_REMAINING.index);
    } else {
      error("Expect time direction such as 'ago' or 'remaining'.");
    }
  }

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
    emitByte(OpCode.RETURN.index);
  }

  // Constants.

  void emitConstant(Value value) {
    emitBytes(OpCode.CONSTANT.index, makeConstant(value));
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

  void errorAt(Token token, message) {
    if (panicMode) return;
    panicMode = true;

    stdout.write('Error');

    if (token.type == TokenType.eof) {
      stdout.write(' at end');
    } else if (token.type == TokenType.error) {
      // Nothing.
    } else {
      stdout.write(" at '${token.value}'");
    }

    stdout.write(": $message\n");
    hadError = true;
  }
}
