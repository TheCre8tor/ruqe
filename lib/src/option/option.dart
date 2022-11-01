abstract class Option<T> {
  const Option();
}

class Some<T> extends Option<T> {
  final T _value;

  const Some(T value) : _value = value;
}

class None<T> extends Option<T> {
  const None();
}
