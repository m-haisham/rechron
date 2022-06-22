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

  // Literals.
  number,
  identifier,

  error,
  eof,
}
