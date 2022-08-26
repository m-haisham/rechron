import 'cache.dart' as cache;
import 'en.dart' as en;

void group(String description, void Function() callback) {
  print(description);
  callback();
  print("");
}

void main(List<String> args) {
  cache.run();
  en.run();
}
