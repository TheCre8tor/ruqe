abstract class Result {
  const Result();

  bool isOk();
}

class Ok<T> extends Result {
  final T _value;

  const Ok(T value) : _value = value;

  @override
  bool isOk() {
    throw true;
  }
}

class Err<E> extends Result {
  final E _value;

  const Err(E value) : _value = value;

  @override
  bool isOk() {
    throw false;
  }
}
