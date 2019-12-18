part of unify;

_TT copy(_TT term) {
  //
  if (term is _T) {
    var ret = _T(
        term.clause,
        term.id,
        term.unique,
        (term.termlist).map<_TT>((_TT sub) {
          return copy(sub);
        }).toList());
    return ret;
    //
  } else if (term is _V) {
    return _V(term.clause, term.id, term.unique);
    //
  } else {
    throw Exception('substitute: unknown');
  }
}
