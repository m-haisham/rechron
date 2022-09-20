/// Represents a token returned by the scanner
class Token {
  const Token(this.type, this.value, this.line);

  /// An empty token
  const Token.empty() : this(TokenType.error, "", 0);

  /// The line where the token was read from.
  final int line;

  /// The type of token.
  final TokenType type;

  /// The value of the extracted from the source.
  final String value;

  @override
  String toString() {
    return '$runtimeType($type, $value, $line)';
  }
}

/// The token types supported by scanner.
enum TokenType {
  // Single-character tokens.
  comma,
  plus,
  minus,

  // Timeframe.
  keyDecade,
  keyYear,
  keyMonth,
  keyWeek,
  keyDay,
  keyHour,
  keyMinute,
  keySecond,
  keyMoment,

  // Relative.
  keyAgo,
  keyIn,

  // Literals.
  number,

  skip,
  error,
  eof,
}

/// The base keywords that are recognized by the scanner.
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
  'moment': TokenType.keyMoment,

  // Relative.
  'ago': TokenType.keyAgo,
  'in': TokenType.keyIn,

  // Single character tokens.
  ',': TokenType.comma,
  '+': TokenType.plus,
  '-': TokenType.minus,
};
