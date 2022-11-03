import 'package:equatable/equatable.dart';
import 'package:ruqe/ruqe.dart';

/// {@template ruqe.Panic }
/// [Panic] terminates the program when it comes across with an [unrecoverable error].
///
/// In other word [Panic] is associated with critical error.
/// - thrown when unwrapping a [Result] that is [Err].
/// - thrown when unwrapping an [Option] that is [None].
///
/// ```dart
/// throw Panic<Result<T, E>>(Some("panic with `${super._error}`"));
/// throw Panic<Option<T>>(None());
/// ```
/// {@endtemplate}
class Panic<Self> extends Equatable {
  final Option<String> _message;

  const Panic(Option<String> message) : _message = message;

  @override
  String toString() {
    if (_message is None) {
      return "[panics]: $Self() cannot be unwrapped.";
    }

    return _message.unwrap();
  }

  @override
  List<Object?> get props => [_message];
}
