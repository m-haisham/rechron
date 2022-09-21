import 'package:characters/characters.dart';
import 'package:rechron_core/rechron_core.dart';

class Scanner {
  Scanner(String content, {required this.data})
      : characters = content.characters.toList();

  /// List of characters of content respecting grapheme clusters.
  final List<String> characters;

  /// Locale specific data.
  final LocaleData data;

  /// The starting character index of the current token.
  int start = 0;

  /// The index of the current character inside [characters].
  int current = 0;

  /// The line where the scanner is reading from.
  int line = 1;

  /// Scan and return next token.
  ///
  /// Will return [TokenType.eof] when scanning is completed.
  Token scanToken() {
    skipWhitespace();
    start = current;

    if (isAtEnd) return makeToken(TokenType.eof);

    final c = advance();

    switch (c) {
      case ",":
        return makeToken(TokenType.comma);
      case "+":
        return makeToken(TokenType.plus);
      case "-":
        return makeToken(TokenType.minus);
      default:
        if (isDigit(c)) {
          return number();
        } else {
          return identifier();
        }
    }
  }

  /// Return whether [current] pointer is at the end [characters]
  bool get isAtEnd => current >= characters.length;

  /// Return the [current] character without advaning the pointer.
  String peek() {
    return characters[current];
  }

  /// Return next character after [current] without advancing pointer
  ///
  /// Will return null if current is the last character.
  String? peekNext() {
    if (isAtEnd) return null;
    return characters[current + 1];
  }

  /// Return the [current] character and advance [current] pointer
  String advance() {
    return characters[current++];
  }

  /// Return a new token of [type] with value starting from [start]
  /// and ending at [current]
  Token makeToken(TokenType type) {
    return Token(type, characters.sublist(start, current).join(), line);
  }

  /// Return a new [TokenType.error] with [value]
  Token errorToken(String value) {
    return Token(TokenType.error, value, line);
  }

  /// Forward the cursor while skipping whitespace.
  ///
  /// This properly advances line changes.
  void skipWhitespace() {
    while (!isAtEnd) {
      final c = peek();
      switch (c) {
        case " ":
        case "\r":
        case "\t":
          advance();
          break;
        case "\n":
          line++;
          advance();
          break;
        default:
          return;
      }
    }
  }

  /// Return whether [c] is a number character (0-9)
  bool isDigit(String? c) {
    switch (c) {
      case "0":
      case "1":
      case "2":
      case "3":
      case "4":
      case "5":
      case "6":
      case "7":
      case "8":
      case "9":
        return true;
      default:
        return false;
    }
  }

  /// Returns whether [c] is a whitespace character
  bool isWhitespace(String c) {
    switch (c) {
      case " ":
      case "\r":
      case "\t":
        return true;
      default:
        return false;
    }
  }

  // Literals.

  /// Parse a new keyword token.
  ///
  /// This function can return a [TokenType.skip] if value is present
  /// in [data.skip].
  ///
  /// It checks [keywords] and [data.tokenMap] for any keyword matches
  /// and returns the corresponding token.
  ///
  /// # Errors
  ///
  /// If the value is not skipped and not recognized as a keyword an error is raised.
  Token identifier() {
    while (!isAtEnd) {
      final c = peek();
      if (isDigit(c) || isWhitespace(c) || c == ',' || c == '+' || c == '-') {
        break;
      }

      advance();
    }

    final value = characters.sublist(start, current).join();
    if (data.skip.contains(value)) {
      return makeToken(TokenType.skip);
    }

    final keyword = keywords[value] ?? data.tokenMap[value];
    if (keyword != null) {
      return makeToken(keyword);
    }

    return errorToken("Unrecognized keyword");
  }

  /// Parse a new number token. This will parse both intergers and floats.
  Token number() {
    while (isDigit(peek())) {
      advance();
    }

    if (peek() == "." && isDigit(peekNext())) {
      // Consume the ".".
      advance();

      while (isDigit(peek())) {
        advance();
      }
    }

    return makeToken(TokenType.number);
  }
}
