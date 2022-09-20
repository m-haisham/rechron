/// Return whether the [year] is a leap year
bool isLeapYear(int year) =>
    (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

extension RegSub on RegExp {
  /// Return the string obtained by replacing the leftmost non-overlapping
  /// occurences of pattern in string by the replacement.
  String sub(String replacement, String source) {
    return source.replaceAllMapped(this, (match) {
      if (match.groupCount > 0) {
        var value = replacement;
        for (var i = 1; i <= match.groupCount; i++) {
          value = value.replaceAll('\\$i', match[i]!);
        }

        return value;
      } else {
        return replacement;
      }
    });
  }
}
