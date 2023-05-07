import 'package:ruqe/ruqe.dart';
import 'package:ruqe/src/shared/core/panic.dart';

void main() {
  /// Calling [stringToNum] with an alphanumeric
  /// data will trigger an exception.
  var trigger = stringToNum("%65");

  /// With pattern matching, we were able to recover from the
  /// exception thrown from calling [int.parse()] and return
  /// 0 instead.
  var result = trigger.match<int?>(
    ok: (value) => value,
    err: (_) => 0,
  );

  print("Result: $result"); // Result: 0
}

Result<int, String> stringToNum(String str) {
  try {
    var value = int.parse(str);
    return Ok(value);
  } catch (err) {
    return Err("Value is none");
  }
}
