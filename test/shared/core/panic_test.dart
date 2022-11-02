import 'package:ruqe/ruqe.dart';
import 'package:ruqe/src/shared/core/panic.dart';
import 'package:test/test.dart';

void main() {
  var slice = "should return the content of";

  group("Panic:", () {
    test("$slice `Some` type when .toString() is called on the result", () {
      var actual = Panic(Some("emergency failure"));

      expect(actual.toString(), "emergency failure");
    });

    test(
      "should return a panic message if .toString() is called on a None type",
      () {
        var actual = Panic<Option<String>>(None());

        expect(
          actual.toString(),
          "[panics]: Option<String>() cannot be unwrapped.",
        );
      },
    );
  });
}
