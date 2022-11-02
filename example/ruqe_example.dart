import 'package:ruqe/ruqe.dart';

void main() {
  var trigger = triggerError();

  var result = trigger.match<int?>(
    ok: (value) => value,
    err: (_) => 0,
  );

  print(result);
}

Result<int, String> triggerError() {
  try {
    var value = int.parse("%65");
    return Ok(value);
  } catch (err) {
    return Err("Value is none");
  }
}
