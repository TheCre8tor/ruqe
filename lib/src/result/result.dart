//
// Copyright (c) 2022 Alexander Nitiola
//
// Functions return Result whenever errors are expected and recoverable.
//

import 'package:equatable/equatable.dart';
import 'package:ruqe/src/option/option.dart';

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

  // Implementation for isMatch method.

  R match<R>({required R Function(T?) ok, required R Function(E?) err});

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
  R match<R>({required R Function(T? p1) ok, required R Function(E p1) err}) {
    return ok(super._value);
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
  R match<R>({required R Function(T? p1) ok, required R Function(E? p1) err}) {
    return err(super._error);
  }
}
