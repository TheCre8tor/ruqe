part of ruqe;

typedef Function0<A> = A Function();
typedef Function1<A, B> = B Function(A a);

abstract class Either<L, R> {
  const Either();

  bool isRight() => this is Right<L, R>;

  bool isLeft() => this is Left<L, R>;

  L get left => fold(
      (left) => left,
      (right) => throw Panic(
          Some('[ILLEGAL USE]: check isLeft is true before calling')));

  R get right => fold(
      (left) => throw Panic(
          Some('[ILLEGAL USE]: check isRight is true before calling')),
      (right) => right);

  B fold<B>(B Function(L left) ifLeft, B Function(R right) ifRight);

  Either<L, R> orElse(Either<L, R> Function() other) =>
      fold((_) => other(), (_) => this);

  R getOrElse(R Function() dflt) => fold((_) => dflt(), <A>(A a) => a);

  R operator |(R dflt) => getOrElse(() => dflt);

  Either<L2, R> leftMap<L2>(L2 Function(L left) func) {
    return fold((L left) => Left(func(left)), (R right) => Right(right));
  }

  Option<R> toOption() => fold((L _) => None(), (R data) => Some(data));

  Either<L, R2> map<R2>(R2 Function(R r) func) =>
      fold((L ifLeft) => Left(ifLeft), (R r) => Right(func(r)));
  Either<L, R2> bind<R2>(Function1<R, Either<L, R2>> f) =>
      fold((L ifLeft) => Left(ifLeft), f);
  Either<L, R2> flatMap<R2>(Function1<R, Either<L, R2>> f) =>
      fold((L ifLeft) => Left(ifLeft), f);
  Either<L, R2> andThen<R2>(Either<L, R2> next) =>
      fold((L ifLeft) => Left(ifLeft), (_) => next);
  Either<L, R> filter(bool Function(R r) predicate, L Function() fallback) =>
      fold((_) => this, (r) => predicate(r) ? this : Left(fallback()));
  Either<L, R> where(bool Function(R r) predicate, L Function() fallback) =>
      filter(predicate, fallback);

  @override
  String toString() => fold((l) => 'Left($l)', (r) => 'Right($r)');

  Either<L, B> mapWithIndex<B>(B Function(int i, R r) f) => map((r) => f(0, r));

  bool all(bool Function(R r) f) => map(f) | true;
  bool every(bool Function(R r) f) => all(f);

  bool any(bool Function(R r) f) => map(f) | false;

  B foldLeft<B>(B z, B Function(B previous, R r) f) =>
      fold((_) => z, (a) => f(z, a));

  B foldLeftWithIndex<B>(B z, B Function(B previous, int i, R r) f) =>
      fold((_) => z, (a) => f(z, 0, a));

  B foldRight<B>(B z, B Function(R r, B previous) f) =>
      fold((_) => z, (a) => f(a, z));

  B foldRightWithIndex<B>(B z, B Function(int i, R r, B previous) f) =>
      fold((_) => z, (a) => f(0, a, z));

  int length() => fold((_) => 0, (_) => 1);

  Either<L, B> replace<B>(B replacement) => map((_) => replacement);
}

class Left<L, R> extends Either<L, R> {
  const Left(this._l);
  final L _l;
  L get value => _l;
  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifLeft(_l);
  @override
  bool operator ==(other) => other is Left && other._l == _l;
  @override
  int get hashCode => _l.hashCode;
}

class Right<L, R> extends Either<L, R> {
  const Right(this._right);
  final R _right;
  R get value => _right;
  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifRight(_right);
  @override
  bool operator ==(other) => other is Right && other._right == _right;
  @override
  int get hashCode => _right.hashCode;
}
