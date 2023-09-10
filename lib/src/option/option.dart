// ************************************
// Copyright (c) 2022 Alexander Nitiola
// ************************************

part of "package:ruqe/ruqe.dart";

/// The [SomeArm] represents the Some callback function
typedef SomeArm<R, T> = R Function(T);

/// The [NoneArm] represents the None callback function
typedef NoneArm<R> = R Function();

abstract class Option<T> extends Equatable {
  final T? _value;

  const Option([T? value]) : _value = value;

  T unwrap();

  R match<R>({required SomeArm<R, T?> some, required NoneArm<R> none});
}

class Some<T> extends Option<T> {
  const Some(T? value) : super(value);

  @override
  T unwrap() {
    return _value!;
  }

  @override
  List<Object?> get props => [_value];

  @override
  R match<R>({required SomeArm<R, T?> some, required NoneArm<R> none}) {
    final someArm = some(_value);
    final noneArm = none();

    if (someArm.runtimeType != noneArm.runtimeType) {
      throw ArgumentError("Return types from the [some] and [none] arm must be the same \n [issue]: ${someArm.runtimeType} is not the same as ${noneArm.runtimeType}");
    }

    return some(_value);
  }
}

class None<T> extends Option<T> {
  const None();

  /// Note: In the original Rust implementation of the Option<T> unwrap API,
  /// if unwrap() is called on a result of None value, the application
  /// panic's but the same logic doesn't work well with Flutter application's
  /// because it messes up the UI.
  ///
  /// The new implementation for Flutter application returns None<void> instead
  /// of throwing an exception of Panic<None<T>>.
  ///
  /// @override
  /// T unwrap() {
  ///   throw Panic<None<T>>(
  ///     Some("panicked at 'called `Option::unwrap()` on a `None` value'"),
  ///   );
  /// }
  @override
  T unwrap() {
    return None<void>() as T;
  }

  @override
  List<Object?> get props => [];

  @override
  R match<R>({required SomeArm<R, T?> some, required NoneArm<R> none}) {
    final someArm = some(null);
    final noneArm = none();

    if (someArm.runtimeType != noneArm.runtimeType) {
      throw ArgumentError("Return types from the [some] and [none] arm must be the same \n [issue]: ${someArm.runtimeType} is not the same as ${noneArm.runtimeType}");
    }

    return none();
  }
}
