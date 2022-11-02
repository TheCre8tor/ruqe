import 'package:equatable/equatable.dart';
import 'package:ruqe/ruqe.dart';

class Panic<Self> extends Equatable {
  final Option<String> _message;

  const Panic(Option<String> message) : _message = message;

  @override
  String toString() {
    if (_message is None) {
      _message.unwrap();
      return "[panics]: $Self() cannot be unwrapped.";
    }

    return _message.unwrap();
  }

  @override
  List<Object?> get props => [_message];
}
