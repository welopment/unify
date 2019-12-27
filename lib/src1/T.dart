part of unify1;

/// Term _T
class _T extends _TT {
  /// not for use in public ;-)
  /// terms with same [clause] and [id]
  /// must have same [unique] and
  /// must be the same object.
  _T(int clause, int id, int unique, List<_TT> t)
      : _termlist = t,
        super(clause, id);

  List<_TT> _termlist;

  /// gets the list of terms
  List<_TT> get termlist => _termlist;

  /// sets the list of terms
  set termlist(List<_TT> tl) => _termlist = tl;

  /// returns a string representation of a term object
  @override
  String toString() {
    return '_T '
        '${clause.toString()}.${id.toString()}|'
        ''
        ''
        '${termlist}';
  }

  /// equality requires same [clause], [id], and [termlist]s

  @override
  bool operator ==(dynamic other) {
    if (other is _T) {
      // ????
      // 1.
      var equalclauses = clause == other.clause;

      // 2.
      var tl = termlist.length;
      var otl = other.termlist.length;
      var equallengths = tl == otl;

      // 3.
      var equalnames = id == other.id;

      // 4.
      var resultequallist = true;
      for (var i = 0; i < tl; i++) {
        var equallist = termlist[i] == other.termlist[i];
        resultequallist && equallist
            ? resultequallist = true
            : resultequallist = false;
      }

      // 1. + 2. + 3. + 4.
      return equalclauses && equallengths && equalnames && resultequallist;
    } else {
      return false;
    }
  }
}
