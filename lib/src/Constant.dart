part of unify;

/// [Constant]s are either [Number]s or [Atom]s.
class Constant<T> extends NonVariable {
  Constant(int clause, int id, T c)
      : _c = c,
        super(clause, id);
  final T _c;

  T get value => _c;

  ///
  @override
  String toString() {
    return 'Constant'
        '${clause.toString()}.${id.toString()}[$value]';
  }

  /// Equality of Constants requires [values] to be equal.
  @override
  bool operator ==(dynamic other) {
    if (other is Constant) {
      var equalvalues = value == other.value;

      return equalvalues;
    } else {
      return false;
    }
  }
}
