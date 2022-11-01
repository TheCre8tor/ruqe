//
// Copyright (c) 2022 Alexander Nitiola
//

import 'package:ruqe/src/option/option.dart';

abstract class Result<T, E> {
  const Result();

  bool isOk();
  bool isErr();
  Option<T> ok();
  Option<E> err();
}

class Ok<T, E> extends Result<T, E> {
  final T _value;

  const Ok(T value) : _value = value;

  @override
  bool isOk() => true;

  @override
  bool isErr() => false;

  @override
  Option<T> ok() => Some(_value);

  @override
  Option<E> err() => None();
}

class Err<T, E> extends Result<T, E> {
  final E _value;

  const Err(E value) : _value = value;

  @override
  bool isOk() => false;

  @override
  bool isErr() => true;

  @override
  Option<T> ok() => None();

  @override
  Option<E> err() => Some(_value);
}
