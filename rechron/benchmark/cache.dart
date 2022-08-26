import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:rechron/rechron.dart';
import 'package:rechron/src/generated_data.dart';

import 'benchmark.dart';

class NoCache extends BenchmarkBase {
  NoCache() : super('NoCache/1000x');

  @override
  void run() {
    parse('1 minute ago');
  }

  @override
  void exercise() {
    for (var i = 0; i < 1000; i++) {
      run();
    }
  }
}

class WithCache extends BenchmarkBase {
  WithCache() : super('WithCache/1000x');

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
  group("Cache:", () {
    WithCache().report();
    NoCache().report();
  });
}
