abstract class Result<T, E> {
  const Result();

  bool isOk();
  bool isErr();
  T ok();
  E err();
}

class Ok<T, E> extends Result<T, E> {
  final T _value;

  const Ok(T value) : _value = value;

  T get value => _value;

  @override
  bool isOk() => true;

  @override
  bool isErr() => false;

  @override
  E err() {
    // TODO: implement err
    throw UnimplementedError();
  }

  @override
  T ok() {
    // TODO: implement ok
    throw UnimplementedError();
  }
}

class Err<E> extends Result {
  final E _value;

  const Err(E value) : _value = value;

  E get value => _value;

  @override
  bool isOk() => false;

  @override
  bool isErr() => true;
}
