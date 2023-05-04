// ************************************
// Copyright (c) 2022 Alexander Nitiola
// ************************************


part of "package:ruqe/ruqe.dart";

abstract class Option<T> extends Equatable {
  final T? _value;

  const Option([T? value]) : _value = value;

  T unwrap();
}

class Some<T> extends Option<T> {
  const Some(T? value) : super(value);

  @override
  T unwrap() {
    return _value!;
  }

  @override
  List<Object?> get props => [_value];
}

class None<T> extends Option<T> {
  const None();

  /// Note: In the original Rust implementation of the unwrap API,
  /// When unwrap() is called on a result of a None value, the application
  /// panic's. The same use-case can't be applied to Dart/Flutter application
  /// because it mess up the UI.
  ///
  /// Solution: When unwrap is called on a result of a None value, None<void> is
  /// returned instead of throwing an exception of Panic<None<T>>
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
}
