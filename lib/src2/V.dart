part of unify2;

/// Variable _V
class _V extends _TT {
  /// not for use in public ;-)
  /// terms with same [clause] and [id]
  /// must have same [unique] and
  /// must be the same object.
  _V(int clause, int id, int unique) : super(clause, id, unique);

  /// turns symbolic identity into object identity
  /// terms with same [clause] and [id]
  /// must have same [unique] and
  /// must be the same object.
  factory _V.unique(int clause, int id) {
    if (_TT.identicalId.containsKey(IdKey(clause, id))) {
      var v = _TT.identicalId[IdKey(clause, id)];
      if (v is _V) {
        return v;
      } else if (v is _T) {
        throw Exception('_V.unique: Wrong type.');
      } else {
        throw Exception('_V.unique: Unknown case.');
      }
    } else {
      _TT._unique++;
      var i = _V(clause, id, _TT._unique);
      _TT.identicalId[IdKey(clause, id)] = i;
      return i;
    }
  }

  /// string representation of a variable object
  @override
  String toString() {
    return '_V'
        ' ${clause.toString()}.${id.toString()}'
        '|${super.unique.toString()}'
        '/replacedBy(${replacedBy})';
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
