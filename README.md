# ruqe

**Ruqe** brings the convenient types and methods found in Rust into Dart, such as
the `Result`, `Option`, `pattern-matching`, etc. Additionally, the library provides
an excellent concept for `modeling errors without resorting to exceptions`.

## Getting started

In your Dart/Flutter project, add the dependency to your `pubspec.yaml`

```yaml
dependencies:
  ruqe: ^1.0.0
```

import with

```dart
import 'package:ruqe/ruqe.dart';
```

## Basic usage

### #[ `Recoverable and Unrecoverable Errors` ]

In **`Ruqe`**, there is a clear distinction between recoverable and unrecoverable errors.

### `1. Recoverable errors:`

Recoverable errors do not cause a program to terminate completely. **`Ruqe`** makes unrecoverable error recoverable by matching the returned value of type `Result` and `Option` with the `.match<T>` convenient method.

```dart

void main() {
  /// Calling [stringToNum] with an alphanumeric
  /// data will trigger an exception.
  var trigger = stringToNum("%65");

  /// With pattern matching, we were able to recover from the
  /// exception thrown from calling [int.parse()] and return
  /// 0 instead.
  var result = trigger.match<int?>(
    ok: (value) => value,
    err: (_) => 0,
  );

  print("Result: $result"); // Result: 0
}

Result<int, String> stringToNum(String str) {
  try {
    var value = int.parse(str);
    return Ok(value);
  } catch (err) {
    return Err("Value is none");
  }
}
```

### `2. Unrecoverable errors:`

Unrecoverable errors cause a program to terminate immediately.
