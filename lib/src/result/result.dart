abstract class Result {
  const Result();

  bool isOk();
  bool isErr();
}

class Ok<T> extends Result {
  final T _value;

  const Ok(T value) : _value = value;

  @override
  bool isOk() {
    throw true;
  }

  @override
  bool isErr() {
    throw false;
  }
}

class Err<E> extends Result {
  final E _value;

  const Err(E value) : _value = value;

  @override
  bool isOk() {
    throw false;
  }

  @override
  bool isErr() {
    throw true;
  }
}
