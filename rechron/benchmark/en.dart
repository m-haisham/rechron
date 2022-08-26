import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:rechron/rechron.dart';
import 'package:rechron/src/generated_data.dart';

import 'benchmark.dart';

class En extends BenchmarkBase {
  En() : super('en/1000x');

  final data = GeneratedData('en');

  @override
  void run() {
    parse('1 minute ago', locale: data);
  }

  @override
  void exercise() {
    for (var i = 0; i < 1000; i++) {
      run();
    }
  }
}

class EnSG extends BenchmarkBase {
  EnSG() : super('en-SG/1000x');

  final data = GeneratedData('en-SG');

  @override
  void run() {
    parse('1 minute ago', locale: data);
  }

  @override
  void exercise() {
    for (var i = 0; i < 1000; i++) {
      run();
    }
  }
}

void run() {
  group("En:", () {
    En().report();
    EnSG().report();
  });
}
