//
// Copyright (c) 2022 Alexander Nitiola
//

import 'package:equatable/equatable.dart';
import 'package:ruqe/src/shared/core/panic.dart';

abstract class Option<T> extends Equatable {
  final T? _value;

  const Option([T? value]) : _value = value;

  T unwrap();
}

class Some<T> extends Option<T> {
  const Some(T? value) : super(value);

  @override
  List<Object?> get props => [_value];

  @override
  T unwrap() {
    return _value!;
  }
}

class None<T> extends Option<T> {
  const None();

  @override
  T unwrap() {
    throw Panic<None<T>>(
      Some("panicked at 'called `Option::unwrap()` on a `None` value'"),
    );
  }

  @override
  List<Object?> get props => [];
}
