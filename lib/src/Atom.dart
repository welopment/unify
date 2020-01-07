part of unify;

// TODO: intern -> int
/// Variable Variable
class Atom extends Constant<String> {
  /// not for public use in
  Atom(int clause, int id, String s)
      : _s = s,
        super(clause, id, s);
  final String _s;

  @override
  String get value => _s;

  ///
  @override
  String toString() {
    return 'Atom'
        '${clause.toString()}.${id.toString()}[$value]';
  }

  /// equality requires same [clause] and [id]
  @override
  bool operator ==(dynamic other) {
    if (other is Atom) {
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
