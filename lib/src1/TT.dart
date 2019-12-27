part of unify1;

/// term type, from which _T (term) and _V (variable) are derived.
///
class _TT {
  /// not for use in public ;-)
  /// terms with same [clause] and [id]
  /// must have same [unique] and
  /// must be the same object.
  _TT(int clause, int id)
      : _id = id,
        _clause = clause;

  /// number of the clause, like a namespace for id
  final int _clause;
  int get clause => _clause;

  /// id, i.e. name of the term,
  /// identifies a term within the namespace of a clause
  final int _id;
  int get id => _id;

  /// turns an id into a name
  int get name => _id;

  /// returns a string representation of the object
  String string(int i) {
    var ret = '_TT'
        ' ${clause.toString()}.${id.toString()}';
    return ret;
  }

  @override
  String toString() {
    return string(0);
  }

/*
  /// post occurs check
  /// tests for circularity
  bool get occurs => _occurs(this, seen(<IdKey>{}));

  /// post occurs check
  /// tests for circularity
  bool _occurs(_TT term, bool Function(_TT) testCircular) {
    var t = term.reallyGet;

    if (testCircular(t)) {
      return true;
    }
    // Case 1
    if (t is _T) {
      (t.termlist).forEach((_TT sub) {
        _occurs(sub, testCircular);
      });
      return false;
      // Case 2
    } else if (t is _V) {
      return false;
      // no case
    } else {
      throw Exception('_occurs: unknown case');
    }
  }


  /// data structure for test of preoccurrance
  bool Function(_TT) seen(Set<IdKey> start) {
    return (_TT x) {
      if (start.contains(IdKey(x.clause, x.id ))) {
        return true;
      } else {
        start.add(IdKey(x.clause, x.id ));
        return false;
      }
    };
  }
 */
  /// to avoid circularity in function [mgu]
  bool visited = false;
}
