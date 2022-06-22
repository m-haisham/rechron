import 'package:dateparser/dateparser.dart';
import 'package:dateparser/src/chunk.dart';
import 'package:dateparser/src/debug.dart';
import 'package:dateparser/src/vm.dart';

void main(List<String> args) {
  final dateTime = parse(args.first);

  print('');
  print('result: $dateTime');
}
