part of "package:ruqe/ruqe.dart";

/// {@template ruqe.Panic }
/// [Panic] terminates the program when it comes across with an [unrecoverable error].
///
/// In other word [Panic] is associated with critical error.
/// - thrown when unwrapping a [Result] that is [Err].
/// - thrown when unwrapping an [Option] that is [None].
///
/// ```dart
/// throw Panic("panic with `${super._error}`");
/// ```
/// {@template}
class Panic extends Equatable implements Exception {
  final String? message;

  const Panic(String this.message);

  @override
  List<Object?> get props => [message];
}
