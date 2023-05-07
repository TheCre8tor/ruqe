part of ruqe;

typedef Function0 <A> = A Function();
typedef Function1 <A, B> = B Function(A a);

abstract class Either<L, R> {
  const Either();

  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight);

  Either<L, R> orElse(Either<L, R> Function() other) => fold((_) => other(), (_) => this);

  R getOrElse(R Function() dflt) => fold((_) => dflt(), <A>(A a) => a);

  R operator |(R dflt) => getOrElse(() => dflt);

  Either<L2, R> leftMap<L2>(L2 Function(L l) f) => fold((L l) => left(f(l)), right);

  Option<R> toOption() => fold((L _) => None(), (R data) => Some(data));

  bool isLeft() => fold((_) => true, (_) => false);

  bool isRight() => fold((_) => false, (_) => true);

  L? get getLeft => fold((L left) => left, (r) => null);

  R? get getRight => fold((L lefts) => null, (R right) => right);

  Either<R, L> swap() => fold(right, left);

  Either<L, R2> map<R2>(R2 Function(R r) f) => fold(left, (R r) => right(f(r)));
  Either<L, R2> bind<R2>(Function1<R, Either<L, R2>> f) => fold(left, f);
  Either<L, R2> flatMap<R2>(Function1<R, Either<L, R2>> f) => fold(left, f);
  Either<L, R2> andThen<R2>(Either<L, R2> next) => fold(left, (_) => next);
  Either<L, R> filter(bool Function(R r) predicate, L Function() fallback) => fold((_) => this, (r) => predicate(r) ? this : left(fallback()));
  Either<L, R> where(bool Function(R r) predicate, L Function() fallback) => filter(predicate, fallback);

  @override String toString() => fold((l) => 'Left($l)', (r) => 'Right($r)');

  Either<L, B> mapWithIndex<B>(B Function(int i, R r) f) => map((r) => f(0, r));

  bool all(bool Function(R r) f) => map(f)|true;
  bool every(bool Function(R r) f) => all(f);

  bool any(bool Function(R r) f) => map(f)|false;

  B foldLeft<B>(B z, B Function(B previous, R r) f) => fold((_) => z, (a) => f(z, a));

  B foldLeftWithIndex<B>(B z, B Function(B previous, int i, R r) f) => fold((_) => z, (a) => f(z, 0, a));

  B foldRight<B>(B z, B Function(R r, B previous) f) => fold((_) => z, (a) => f(a, z));

  B foldRightWithIndex<B>(B z, B Function(int i, R r, B previous) f)=> fold((_) => z, (a) => f(0, a, z));

  int length() => fold((_) => 0, (_) => 1);

  Either<L, B> replace<B>(B replacement) => map((_) => replacement);

}

class Left<L, R> extends Either<L, R> {
  final L _l;
  const Left(this._l);
  L get value => _l;
  @override B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifLeft(_l);
  @override bool operator ==(other) => other is Left && other._l == _l;
  @override int get hashCode => _l.hashCode;
}

class Right<L, R> extends Either<L, R> {
  final R _r;
  const Right(this._r);
  R get value => _r;
  @override B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifRight(_r);
  @override bool operator ==(other) => other is Right && other._r == _r;
  @override int get hashCode => _r.hashCode;
}


Either<L, R> left<L, R>(L l) => Left(l);

Either<L, R> right<L, R>(R r) => Right(r);

Either<dynamic, A> catching<A>(A Function() thunk) {
  try {
    return right(thunk());
  } catch(e) {
    return left(e);
  }
}
