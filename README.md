# ruqe

**Ruqe** brings the **Result-Oriented Programming** paradigm 🔥 to Flutter and Dart 🎯 programs,
with its main purpose being to simplify development processes. It helps you create predictable
responses from your functions or method operations 🎉.

## What is Result Oriented Programming?

**Result-Oriented programming** is a paradigm that enables you to take a results-focused approach
to your app's architecture and design, giving you control over your application development
processes and expected results ✨.

**Ruqe** provides convenient types and methods such as the `Result`, `Option`, `Either`,
`Pattern Matching`, etc. Additionally, the library provides an excellent `techniques for handling
errors gracefully without resorting to exceptions`.

Dive into **Result-Oriented Programming** with **Ruqe**, ensuring your app remains
`responsive and reliable` 🚀.

**Note:** `The size of the library is 22KB. It's light weight, isn't it?` 😍

## Getting started

In your Dart/Flutter project, add the dependency to your `pubspec.yaml`

```yaml
dependencies:
  ruqe: ^1.4.0
```

import with

```dart
import 'package:ruqe/ruqe.dart';
```

## Basic usage

### #[ How Result-Oriented Programming solves the problem ]

We will begin by firstly defining our data models:

```dart
    class User {
        User({required this.id, required this.name});
        
        final String id;
        final String name;
    }
```

#### Service layer:
```dart
    abstract interface class IAuthService {
        Future<User> getUser(String userId);
    }
```

```dart
    class AuthService implements IAuthService {
        final Client client;

        AuthService(this.client);

        @override
        Future<User> getUser(String userId) async {
            final response = await client.get(Uri.parse("fake-user.com"));
            final json = jsonDecode(response.body);

            if (response.statusCode == 200) {
                return User.fromJson(json["data"]);
            }

            throw Panic(json["message"]);
        }
    }
```

#### Repository Layer:
```dart
    abstract interface class IAuthRepository {
        Future<Result<User, String>> getUser(String userId);
    }
```

```dart
    class AuthRepository implements IAuthRepository {
        final IAuthService service;

        AuthRepository(this.service);

        @override
        Future<Result<User, String>> getUser(String userId) async {
             try {
                 final response = await service.getUser(userId);
                 return Ok(response);
             } on Panic catch (error) {
                 return Err(error.message);
             }
        }
    }
```

#### View Layer:
```dart
    class Contact extends StatefulWidget {
        const Contact({super.key});

        @override
        State<Contact> createState() => _ContactState();
    }

    class _ContactState extends State<Contact> {
        late AuthRepository repository;

        @override
        void initState() {
          repository = AuthRepository(AuthService(Client()));
          super.initState();
        }

        @override
        Widget build(BuildContext context) {
            Result<User, String> user = Ok(User(id: "001-JON", name: "John Doe"));

            return FutureBuilder(
                future: repository.getUser("002-IOS"),
                initialData: user,
                builder: (context, snapshot) {
                    final data = snapshot.data;

                    return data!.match<Widget>(
                      ok: (value) => Text(value?.name ?? ""),
                      err: (_) => const SizedBox.shrink(),
                    );
                }, 
            );
        }
    }
```

### #[ Option instance pattern matching ]

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

### #[ Recoverable and Unrecoverable Errors ]

In **Ruqe**, there is a clear distinction between recoverable and unrecoverable errors.

### 1. Recoverable errors:

Recoverable errors do not cause a program to terminate completely. **Ruqe** makes unrecoverable
error recoverable by matching the returned value of type `Result` and `Option` with the `.match<T>`
convenient method.

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

Unrecoverable errors cause a program to terminate immediately. In **Ruqe**, [Panic] terminates the
program when it comes across with an unrecoverable error.

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
