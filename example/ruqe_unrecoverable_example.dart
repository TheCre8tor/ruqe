import 'package:ruqe/ruqe.dart';

typedef ListMap = List<Map<String, String>>;
typedef AppError = String;

void main() {
  var data = [
    {"first_name": "Tunbnad", "last_name": "Smart"},
    {"first_name": "Lambo", "last_name": "Turnner"}
  ];

  var firstNames1 = getFirstName(data);
  print(firstNames1.unwrap()); // [Tunbnad, Lambo]

  var firstNames2 = getFirstName([]);
  firstNames2.unwrap(); // panic with `[error]: an error occured!`
}

Result<List<String?>, AppError> getFirstName(ListMap data) {
  if (data.isNotEmpty) {
    return Ok(data.map((user) => user["first_name"]).toList());
  } else {
    return Err("[error]: an error occured!");
  }
}
