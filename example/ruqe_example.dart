import 'package:ruqe/ruqe.dart';

void main() {
  var trigger = triggerError();

  trigger.match(
    ok: (value) => print(value),
    err: (e) => print(e),
  );

  // print(value);
}

Result<int, String> triggerError() {
  try {
    var value = int.parse("65");
    return Ok(value);
  } catch (err) {
    return Err("Value is none");
  }
}
