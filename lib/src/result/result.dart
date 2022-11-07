//
// Copyright (c) 2022 Alexander Nitiola
//
// Functions return Result whenever errors are expected and recoverable.
//

import 'package:equatable/equatable.dart';
import 'package:ruqe/src/option/option.dart';
import 'package:ruqe/src/shared/core/panic.dart';

/// {@template ruqe.OkArm}
/// The [OkArm] represents the Ok callback function
/// {@endtemplate}
typedef OkArm<R, T> = R Function(T);

/// {@template ruqe.ErrArm}
/// The [ErrArm] represents the Err callback function
/// {@endtemplate}
typedef ErrArm<R, E> = R Function(E);

abstract class Result<T, E> extends Equatable {
  final T? _value;
  final E? _error;

  const Result({T? ok, E? error})
      : _value = ok,
        _error = error;

  bool isOk();
  bool isErr();
  Option<T> ok();
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
