# ruqe

**Ruqe** brings the **Result-Oriented Programming** paradigm to Flutter and Dart programs, with its main 
purpose being to simplify development processes. It helps you create predictable responses from your functions 
or method operations.

## What is Result Oriented Programming?
**Result-Oriented programming** is a paradigm that enables you to take a results-focused approach 
to your app's architecture and design, giving you control over your application development processes 
and expected results.

**Ruqe** provides convenient types and methods such as the `Result`, `Option`, `Either`, `Pattern Matching`, etc. 
Additionally, the library provides an excellent `techniques for handling errors gracefully without resorting 
to exceptions`.

Dive into **Result-Oriented Programming** with **Ruqe**, ensuring your app remains `responsive and reliable`.

**Note:** `The size of the library is 22KB. It's light weight, isn't it?`

## Getting started

In your Dart/Flutter project, add the dependency to your `pubspec.yaml`

```yaml
dependencies:
  ruqe: ^1.3.2
```

import with

```dart
import 'package:ruqe/ruqe.dart';
```

## Basic usage

### #[ Recoverable and Unrecoverable Errors ]

In **Ruqe**, there is a clear distinction between recoverable and unrecoverable errors.

### 1. Recoverable errors:

Recoverable errors do not cause a program to terminate completely. **Ruqe** makes unrecoverable error recoverable by matching the returned value of type `Result` and `Option` with the `.match<T>` convenient method.

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

### 2. Unrecoverable errors:

Unrecoverable errors cause a program to terminate immediately. In **Ruqe**, [Panic] terminates the program when it comes across with an unrecoverable error.

`What can trigger a panic?`

```dart
typedef ListMap = List<Map<String, String>>;
typedef AppError = String;

var data = [
  {"first_name": "Tunbnad", "last_name": "Smart"},
  {"first_name": "Lambo", "last_name": "Turnner"}
];

void main() {
  var firstNames1 = getFirstName(data);
  print(firstNames1.unwrap()); // [Tunbnad, Lambo]

  /// Unwrapping a value of [Option] that is [None]
  /// will trigger a [Panic] and terminate the program.
  var firstNames2 = getFirstName([]);
  firstNames2.unwrap(); // panic with `[error]: an error occured!`
}

/// Returns a [Result] that is [Err] if [ListMap] is empty.
Result<List<String?>, AppError> getFirstName(ListMap data) {
  if (data.isNotEmpty) {
    return Ok(data.map((user) => user["first_name"]).toList());
  } else {
    return Err("[error]: an error occurred!");
  }
}
```

### 3. Option instance pattern matching: 

This `match` method allows developers to perform pattern matching operations on
Option instances, simplifying conditional logic and enhancing code readability.

```dart
final Option<String> asData = None();

final data = asData.match(
    ok: (value) => value,
    err: () => null
);

print(data);
```
