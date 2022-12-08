//
// Copyright (c) 2022 Alexander Nitiola
//
// Functions return Result whenever errors are expected and recoverable.
//

import 'package:equatable/equatable.dart';
import 'package:ruqe/src/option/option.dart';
import 'package:ruqe/src/shared/core/panic.dart';

/// The [OkArm] represents the Ok callback function
typedef OkArm<R, T> = R Function(T);

/// The [ErrArm] represents the Err callback function
typedef ErrArm<R, E> = R Function(E);

/// [Result] is the type used for returning and propagating errors.
/// It is an enum with the variants, Ok(T), representing success and containing a value,
/// and Err(E), representing error and containing an error value.
abstract class Result<T, E> extends Equatable {
  final T? _value;
  final E? _error;

  const Result({T? ok, E? error})
      : _value = ok,
        _error = error;

  /// Returns `true` if the result is `Ok`.
  /// ```dart
  /// final Result<int, String> x = Ok(21);
  /// assert(x.isOk() == true);
  ///
  /// final Result<int, String> x = Err("an error occured.");
  /// assert(x.isOk() == false);
  /// ```
  /// run: dart --enable-asserts example/ruqe_example.dart
  bool isOk();

  /// Returns `false` if the result is `Err`.
  /// ```dart
  /// final Result<int, String> x = Ok(21);
  /// assert(x.isErr() == false);
  ///
  /// final Result<int, String> x = Err("an error occured.");
  /// assert(x.isErr() == true);
  /// ```
  /// run: dart --enable-asserts example/ruqe_example.dart
  bool isErr();

  /// Converts from `Result<T, E>` to `Option<T>`.
  Option<T> ok();

  /// Converts from `Result<T, E>` to `Option<E>`.
  Option<E> err();

  T unwrap();

  R match<R>({required OkArm<R, T?> ok, required ErrArm<R, E?> err});

  @override
  List<Object?> get props => [_value, _error];
}

class Ok<T, E> extends Result<T, E> {
  const Ok(T value) : super(ok: value);

  @override
  bool isOk() => true;

  @override
  bool isErr() => false;

  @override
  Option<T> ok() => Some(super._value);

  @override
  Option<E> err() => None();

  @override
  R match<R>({required OkArm<R, T?> ok, required ErrArm<R, E> err}) {
    return ok(super._value);
  }

  @override
  T unwrap() {
    return super._value!;
  }
}

class Err<T, E> extends Result<T, E> {
  const Err(E value) : super(error: value);

  @override
  bool isOk() => false;

  @override
  bool isErr() => true;

  @override
  Option<T> ok() => None();

  @override
  Option<E> err() => Some(super._error);

  @override
  List<Object?> get props => [_value];

  @override
  R match<R>({required OkArm<R, T> ok, required ErrArm<R, E?> err}) {
    return err(super._error);
  }

  @override
  T unwrap() {
    throw Panic<Result<T, E>>(Some("panic with `${super._error}`"));
  }
}
