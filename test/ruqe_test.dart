import 'package:ruqe/ruqe.dart';
import 'package:ruqe/src/shared/core/panic.dart';
import 'package:test/test.dart';

void main() {
  group('Result: ', () {
    late Result<int, String> result;
    late Result<String, String> error;

    setUp(() {
      result = Ok(-3);
      error = Err("some error message");
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
      expect(error.err(), Some("some error message"));
    });

    test("Should the contained Ok value, consuming the self value.", () {
      expect(result.unwrap(), -3);
    });

    test("should throw an Exception if unwrap is called on Err type", () {
      error.unwrap();
      expect(error.unwrap, throwsA(isA<Panic>()));
    });
  });
}
