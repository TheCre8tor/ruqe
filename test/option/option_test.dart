import 'package:ruqe/ruqe.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group("Option: ", () {
    test("should return None<void> if unwrap is called on a value of None", () {
      // ::arrange ->
      final value = None();

      // ::act ->
      final result = value.unwrap();

      // ::assert ->
      assert(result is None<void>);
      expect(result, None<void>());
    });
  });
}
