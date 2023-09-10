import 'package:ruqe/ruqe.dart';
import 'package:test/test.dart';

void main() {
  group('Result:', () {
    late Result<int, String> result;
    late Result<String, String> error;

    setUp(() {
      result = Ok(-3);
      error = Err("some error message");
    });

    test('should return true if the result is Ok.', () {
      expect(result.isOk(), isTrue);
      expect(error.isOk(), isFalse);
    });

    test("should return true if the result is Err.", () {
      expect(error.isErr(), isTrue);
      expect(result.isErr(), isFalse);
    });

    test("should return Some(...) if result is Ok.", () {
      expect(result.ok(), Some(-3));
      expect(error.ok(), None<String>());
    });

    test("should return Some(...) if result is Err.", () {
      expect(error.err(), Some("some error message"));
    });

    test("should contained Ok value, consuming the self value.", () {
      expect(result.unwrap(), -3);
    });

    test("should panic if unwrap is called on Err type", () {
      expect(error.unwrap, throwsA(isA<Panic>()));
    });
  });
}
