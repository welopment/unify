part of unify;

/// Variable _V
class _V extends _TT {
  //
  _V(int clause, int id, int unique) : super(clause, id, unique);

  //
  //
  factory _V.unique(int clause, int id) {
    _TT._unique++;
    if (_TT.identicalId.containsKey(IdKey(clause, id))) {
      _TT v = _TT.identicalId[IdKey(clause, id)];
      if (v is _V) {
        return v;
      } else if (v is _T) {
        throw Exception('_V.unique: Wrong type.');
      } else {
        throw Exception('_V.unique: Unknown case.');
      }
    } else {
      _V i = _V(clause, id, _TT._unique);
      _TT.identicalId[IdKey(clause, id)] = i;
      return i;
    }
  }

  @override
  String toString() {
    return '_V ${clause.toString()}.${id.toString()}|${super.unique.toString()}/replacedBy(${replacedBy})';
  }
}
