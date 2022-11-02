# ruqe

**Ruqe** brings the convenient types and methods found in Rust into Dart, such as
the `Result`, `Option`, `pattern-matching`, etc. Additionally, the library provides
an excellent concept for `modeling errors without resorting to exceptions`.

## Getting started

In your Dart/Flutter project, add the dependency to your `pubspec.yaml`

```yaml
dependencies:
  ruqe: ^0.0.1
```

import with

```dart
import 'package:ruqe/ruqe.dart';
```

### Basic usage

To create a Result use

```dart

void main() {
  var trigger = triggerError();

  var result = trigger.match<int?>(
    ok: (value) => value,
    err: (_) => 0,
  );

  print(result);
}

Result<int, String> triggerError() {
  try {
    var value = int.parse("%65");
    return Ok(value);
  } catch (err) {
    return Err("Value is none");
  }
}
```
