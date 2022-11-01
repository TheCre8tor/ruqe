import 'package:ruqe/ruqe.dart';

void main() {
  var trigger = triggerError();

  var value = trigger.match<int?>(
    ok: (value) => value,
    err: (e) => 0,
  );

  print(value);
}

Result<int, String> triggerError() {
  try {
    var value = int.parse("%65");
    return Ok(value);
  } catch (err) {
    return Err("Value is none");
  }
}
