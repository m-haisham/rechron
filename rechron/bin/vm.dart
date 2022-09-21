import 'dart:io';

import 'package:rechron/rechron.dart';

class IoReporter extends WriterReporter {
  @override
  void write(Object value) => stdout.write(value);
}

class IoDebugger extends WriteDebugger {
  @override
  void write(Object value) => stdout.write(value);
}

void main(List<String> args) {
  final source = args.isNotEmpty ? args.first : 'day before yesterday';
  final dateTime = parse(
    source,
    reporter: IoReporter(),
    debugger: IoDebugger(),
  );
  print(dateTime);
}
