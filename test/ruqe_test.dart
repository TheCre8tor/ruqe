import 'package:ruqe/ruqe.dart';
import 'package:test/test.dart';

void main() {
  group('Result: ', () {
    late Result<int, String> result;
    late Result<String, String> error;

    setUp(() {
      result = Ok(-3);
      error = Err("Some error message");
    });

    test('Should return true if the result is Ok.', () {
      expect(result.isOk(), isTrue);
      expect(error.isOk(), isFalse);
    });

    test("Should return true if the result is Err.", () {
      expect(error.isErr(), isTrue);
      expect(result.isErr(), isFalse);
    });

    test("Should return Some(...) if result is Ok.", () {
      expect(result.ok(), Some(-3));
      expect(error.ok(), None<String>());
    });

    test("Should return Some(...) if result is Err.", () {
      expect(error.err(), Some("Some error message"));
    });
  });
}
