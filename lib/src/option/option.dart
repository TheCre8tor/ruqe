//
// Copyright (c) 2022 Alexander Nitiola
//

import 'package:equatable/equatable.dart';

abstract class Option<T> extends Equatable {
  const Option();
}

class Some<T> extends Option<T> {
  final T? _value;

  const Some(T? value) : _value = value;

  @override
  List<Object?> get props => [_value];
}

class None<T> extends Option<T> {
  const None();

  @override
  List<Object?> get props => [];
}
