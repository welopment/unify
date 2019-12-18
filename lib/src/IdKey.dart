part of unify;

/// Identity
/// IdKey
/// für TreeMap, d.h. cache für factory
class IdKey implements Comparable<IdKey> {
  IdKey(int clause, int id)
      : _id = id,
        _clause = clause;
  final int _clause;
  int get clause => _clause;
  //
  final int _id;
  int get id => _id;
  @override
  int compareTo(IdKey other) {
    if (id == other.id && clause == other.clause) {
      return 0;
    } else {
      return (2 * clause.compareTo(other.clause)) + id.compareTo(other.id);
    }
  }

  @override
  bool operator ==(dynamic other) {
    if (other is IdKey) {
      return id == other.id && clause == other.clause;
    } else {
      return false;
    }
  }
}
