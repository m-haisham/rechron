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

```text
Copyright 2022 Mohamed Haisham

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
