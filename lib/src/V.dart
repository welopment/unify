part of unify;

/// Variable _V
class _V extends _TT {
  //
  _V(int clause, int id, int unique) : super(clause, id, unique);

  //
  // vereinfachen, auf super beziehen
  factory _V.unique(int clause, int id) {
    _TT._unique++;
    int _uni = _TT._unique;
    var ck = _TT.identicalId.containsKey(IdKey(clause, id));
    var v = _TT.identicalId[IdKey(clause, id)];
    if (ck && v is _V) {
      return v;
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
