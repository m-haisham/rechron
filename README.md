# Rechron

Dart library for parsing relative date and time.

## Installation

```yaml
dependencies:
  rechron: ^0.1.0
```

## Usage

```dart
import 'package:rechron/rechron' as rechron;

rechron.parse('a moment ago');
// 2022-08-20 19:18:49.761788

rechron.parse('2 hours ago');
// 2022-08-20 17:17:13.154895

rechron.parse('in 2 days, 5 hours');
// 2022-08-23 00:18:35.610707
```

## License

This project is licensed under [BSD-3-Clause].

[bsd-3-clause]: https://github.com/mensch272/rechron/blob/main/LICENSE
