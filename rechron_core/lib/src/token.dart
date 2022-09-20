class Token {
  const Token(this.type, this.value, this.line);
  const Token.empty() : this(TokenType.error, "", 0);

  final int line;
  final TokenType type;
  final String value;

  @override
  String toString() {
    return '$runtimeType($type, $value, $line)';
  }
}

enum TokenType {
  // Single-character tokens.
  comma,

  // Timeframe.
  keyDecade,
  keyYear,
  keyMonth,
  keyWeek,
  keyDay,
  keyHour,
  keyMinute,
  keySecond,

  // Relative.
  keyAgo,
  keyIn,

  keyAnd,

  // Literals.
  number,

  skip,
  error,
  eof,
}

const keywords = <String, TokenType>{
  // Timeframes.
  'decade': TokenType.keyDecade,
  'year': TokenType.keyYear,
  'month': TokenType.keyMonth,
  'week': TokenType.keyWeek,
  'day': TokenType.keyDay,
  'hour': TokenType.keyHour,
  'minute': TokenType.keyMinute,
  'second': TokenType.keySecond,

  // Relative.
  'ago': TokenType.keyAgo,
  'in': TokenType.keyIn,

  // Other.
  'and': TokenType.keyAnd,
};
