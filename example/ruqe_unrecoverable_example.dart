import 'package:ruqe/ruqe.dart';

typedef ListMap = List<Map<String, String>>;
typedef AppError = String;

var data = [
  {"first_name": "Tunbnad", "last_name": "Smart"},
  {"first_name": "Lambo", "last_name": "Turnner"}
];

void main() {
  var firstNames1 = getFirstName(data);
  print(firstNames1.unwrap()); // [Tunbnad, Lambo]

  /// Unwrapping a value of [Option] that is [None]
  /// will trigger a [Panic] and terminate the program.
  var firstNames2 = getFirstName([]);
  firstNames2.unwrap(); // panic with `[error]: an error occured!`
}

/// Returns a [Result] that is [Err] if [ListMap] is empty.
Result<List<String?>, AppError> getFirstName(ListMap data) {
  if (data.isNotEmpty) {
    return Ok(data.map((user) => user["first_name"]).toList());
  } else {
    return Err("[error]: an error occured!");
  }
}
