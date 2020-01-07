part of unify;

/// Konstantensymbol. Nicht-logisches Symbol. 
class Constant<T> extends NonVariable {
  /// not for public use in
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

  /// equality requires same [clause] and [id]
  @override
  bool operator ==(dynamic other) {
    if (other is Constant) {
      /// 1.
      var equalclauses = clause == other.clause;

      /// 2.
      var equalnames = id == other.id;

      /// 3.
      var equalvalues = value == other.value;

      /// 1. ^ 2. ^ 3.
      return equalclauses && equalnames && equalvalues;
    } else {
      return false;
    }
  }
}
