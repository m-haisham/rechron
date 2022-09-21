import 'package:test/test.dart';
import 'package:rechron/rechron.dart';

void main() {
  group("parse", () {
    group("en", langEn);
  });
}

void langEn() {
  final cases = {
    'a moment ago': () => DateTime.now(),
    '5 minutes ago': () => DateTime.now().subtract(Duration(minutes: 5)),
    '10 hours ago': () => DateTime.now().subtract(Duration(hours: 10)),
    'a day ago': () => DateTime.now().subtract(Duration(days: 1)),
    'a day, 15 minutes ago': () =>
        DateTime.now().subtract(Duration(days: 1, minutes: 15)),
    'just now': () => DateTime.now(),
    'in 25 seconds': () => DateTime.now().add(Duration(seconds: 25)),
    'in 25 seconds, 6 weeks': () =>
        DateTime.now().add(Duration(days: 6 * 7, seconds: 25)),
    'in 25 seconds 6 weeks': () =>
        DateTime.now().add(Duration(days: 6 * 7, seconds: 25)),
    '2 minutes from 2 minutes ago': () => DateTime.now(),
    '1 minute ago + 2 minutes': () => DateTime.now().add(Duration(minutes: 1)),
    '2 minutes - 1 minute ago': () =>
        DateTime.now().subtract(Duration(minutes: 3)),
  };

  for (var testCase in cases.entries) {
    test(testCase.key, () {
      final parsed = parse<DateTime>(testCase.key).millisecondsSinceEpoch;
      expect(
        testCase.value().millisecondsSinceEpoch,
        closeTo(parsed, 1000),
      );
    });
  }
}
