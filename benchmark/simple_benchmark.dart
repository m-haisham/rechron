import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:dateparser/dateparser.dart';

class SimpleBenchmark extends BenchmarkBase {
  const SimpleBenchmark() : super('Simple');

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

void main(List<String> args) {
  const SimpleBenchmark().report();
}
