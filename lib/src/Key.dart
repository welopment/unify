part of unify;

class _Pair {
  _Pair(int first, int second)
      : _first = first,
        _second = second;

  final int _first;

  int get first => _first;

  final int _second;

  int get second => _second;
}

/// For use as a key in a SplayTreeMap,
/// helps factory constructor turn
/// symbolic identity given by [clause] and [id] into object identity
class Key implements Comparable<Key> {
  Key(int clause, int id)
      : _clause = clause,
        _id = id {
    if (_um.containsKey(_Pair(clause, id))) {
      _unique = _um[_Pair(clause, id)];
    } else {
      _unique = _u++;
      _um[_Pair(clause, id)] = _unique;
    }
  }

  /// Return a [Key] from a term given as argument.
  Key.from(Term tt)
      : _clause = tt.clause,
        _id = tt.id {
    if (_um.containsKey(_Pair(clause, id))) {
      _unique = _um[_Pair(clause, id)];
    } else {
      _unique = _u++;
      _um[_Pair(clause, id)] = _unique;
    }
  }

  int _unique = 0;

  static int _u = 0;

  int get unique => _unique;

  final _um = SplayTreeMap<_Pair, int>();

  // Harmonize ([clause] and [id]) with [hashCode].
  @override
  int get hashCode => _unique;

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
      // Think about how to best implement lexical ordering
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
