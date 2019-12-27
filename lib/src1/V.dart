part of unify1;

/// Variable _V
class _V extends _TT {
  /// not for use in public ;-)
  /// terms with same [clause] and [id]
  /// must have same [unique] and
  /// must be the same object.
  _V(int clause, int id) : super(clause, id);

  /// turns symbolic identity into object identity
  /// terms with same [clause] and [id]
  /// must have same [unique] and
  /// must be the same object.

  /// string representation of a variable object
  @override
  String toString() {
    return '_V'
        ' ${clause.toString()}.${id.toString()}'
        ''
        '';
  }

  /// equality requires same [clause] and [id]
  @override
  bool operator ==(dynamic other) {
    if (other is _T) {
      // 1.
      var equalclauses = clause == other.clause;

      // 2.
      var equalnames = id == other.id;

      // 1. + 2. + 3.
      return equalclauses && equalnames;
    } else {
      return false;
    }
  }
}
