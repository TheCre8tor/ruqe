import 'package:equatable/equatable.dart';

enum ErrorKind { unKnown }

class AppError extends Equatable {
  final ErrorKind _kind;
  final String _message;

  const AppError({ErrorKind? kind, String? message})
      : _kind = kind ?? ErrorKind.unKnown,
        _message = message ?? "[error]: an error occured!";

  @override
  String toString() {
    return _message;
  }

  @override
  List<Object?> get props => [_kind, _message];
}
