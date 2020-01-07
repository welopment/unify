part of unify;


///
class Number extends Constant<num> {
  /// not for public use in
  Number(int clause, int id, num n)
      : _n = n,
        super(clause, id, n);
  final num _n;

  @override
  num get value => _n;

  ///
  @override
  String toString() {
    return 'Number'
        '${clause.toString()}.${id.toString()}[$value]';
  }

  /// equality requires same [clause] and [id]
  @override
  bool operator ==(dynamic other) {
    if (other is Number) {
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
