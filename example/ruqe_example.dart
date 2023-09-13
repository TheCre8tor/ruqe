import 'package:ruqe/ruqe.dart';

void main() {
  /// Calling [stringToNum] with an alphanumeric
  /// data will trigger an exception.
  var trigger = stringToNum("%65");

  /// With pattern matching, we were able to recover from the
  /// exception thrown from calling [int.parse()] and return
  /// 0 instead.
  var match = trigger.match<int?>(
    ok: (value) => value,
    err: (_) => 0,
  );

  print("Result: $match"); // Result: 0

  /// Optional pattern matching
  final Option<String> option = None();
  final data =
      option.match<String?>(some: (value) => value, none: () => "empty data");

  print("Option value: $data");

  /// Result pattern matching
  final Result<int, String> result = Err("24");
  final value = result.match<int?>(
      ok: (value) => value, err: (value) => int.tryParse(value ?? ""));

  print("Result value: $value");
}

Result<int, String> stringToNum(String str) {
  try {
    var value = int.parse(str);
    return Ok(value);
  } catch (err) {
    return Err("Value is none");
  }
}
