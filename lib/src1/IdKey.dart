part of unify1;

/// For use in a TreeMap,
/// helps factory constructor turn
/// symbolic identity (clause, id) into object identity
class IdKey implements Comparable<IdKey> {
  IdKey(int clause, int id)
      : _id = id,
        _clause = clause;
  // clause
  final int _clause;
  int get clause => _clause;
  // id, i.e. name
  final int _id;
  int get id => _id;
  //
  @override
  int compareTo(IdKey other) {
    if (id == other.id && clause == other.clause) {
      return 0;
    } else {
      // implements lexical ordering
      return (2 * clause.compareTo(other.clause)) + id.compareTo(other.id);
    }
  }

  @override
  bool operator ==(dynamic other) {
    //
    if (other is IdKey) {
      return id == other.id && clause == other.clause;
      //
    } else {
      return false;
    }
  }
}
