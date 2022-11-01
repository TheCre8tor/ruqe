import 'package:ruqe/ruqe.dart';
import 'package:test/test.dart';

void main() {
  group('Result: ', () {
    Result<String, int> result = Ok("Some error message");

    setUp(() {
      // Additional setup goes here.
    });

    test('Should return true if the result is Ok.', () {
      expect(result.isOk(), isTrue);
    });

    test("Should return Some(...) if result is Ok.", () {
      expect(result.ok(), Some("Some error message"));
    });
  });
}
