part of unify;

/// For use in a TreeMap,
/// helps factory constructor turn
/// symbolic identity (clause, id) into object identity
class Key implements Comparable<Key> {
  Key(int clause, int id)
      : _clause = clause,
        _id = id;
  Key.from(_TT tt)
      : _clause = tt.clause,
        _id = tt.id;
  // clause
  final int _clause;
  int get clause => _clause;
  // id, i.e. name
  final int _id;
  int get id => _id;
  //
  @override
  int compareTo(Key other) {
    if (clause == other.clause && id == other.id) {
      return 0;
    } else {
      // implements lexical ordering
      return (2 * clause.compareTo(other.clause)) + id.compareTo(other.id);
    }
  }

  @override
  bool operator ==(dynamic other) {
    //
    if (other is Key) {
      return clause == other.clause && id == other.id;
      //
    } else {
      return false;
    }
  }

  @override
  String toString() {
    return clause.toString() + '.' + id.toString();
  }
}
