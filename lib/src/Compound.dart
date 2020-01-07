part of unify;

/// Funktion oder Prädikat
class Compound extends NonVariable {
  /// not for use in public ;-)
  /// terms with same [clause] and [id]
  /// must have same [unique] and
  /// must be the same object.
  Compound(int clause, int id, List<Term> t)
      : _termlist = t,
        super(clause, id);

  List<Term> _termlist;

  /// gets the list of terms
  List<Term> get termlist => _termlist;

  /// sets the list of terms
  set termlist(List<Term> tl) => _termlist = tl;

  /// returns a string representation of a term object
  @override
  String toString() {
    return 'Compound'
        '${clause.toString()}.${id.toString()}'
        '${termlist}';
  }

  /// equality requires same [clause], [id], and [termlist]s
  @override
  bool operator ==(dynamic other) {
    if (other is Compound) {
      //
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

      // 1. ^ 2. ^ 3. ^ 4.
      return equalclauses && equallengths && equalnames && resultequallist;
    } else {
      return false;
    }
  }
}
