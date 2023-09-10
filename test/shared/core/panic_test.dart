import 'package:ruqe/ruqe.dart';
import 'package:test/test.dart';

void main() {
  var slice = "should return the content of";

  group("Panic:", () {
    test("$slice `Some` type when .toString() is called on the result", () {
      var actual = Panic("emergency failure");

      expect(actual.message, "emergency failure");
    });
  });
}
