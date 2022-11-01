import 'package:ruqe/ruqe.dart';

void main() {
  var trigger = triggerError();

  print('awesome: ${trigger.err()}');
}

Result<int, String> triggerError() {
  try {
    var value = int.parse("%65");
    return Ok(value);
  } catch (err) {
    return Err(err.toString());
  }
}
