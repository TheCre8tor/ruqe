import 'package:ruqe/ruqe.dart';

void main() {
  var trigger = triggerError();

  print(trigger.ok());
}

Result<int, String> triggerError() {
  try {
    var value = int.parse("65");
    return Ok(value);
  } catch (err) {
    return Err("Value is none");
  }
}
