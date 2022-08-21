import 'package:rechron/rechron.dart';

void main(List<String> args) {
  RechronConfig.isDebug = true;

  final source = args.isNotEmpty ? args.first : 'day before yesterday';
  final dateTime = parse(source);
  print(dateTime);
}
