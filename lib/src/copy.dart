part of unify;

_TT copy(_TT term) {
  //
  if (term is _T) {
    var ret = t(
        // TODO Problem
        term.clause,
        term.id, // TODO Problem
        (term.termlist).map<_TT>((_TT sub) {
          return copy(sub);
        }).toList());
    return ret;
    //
  } else if (term is _V) {
    // TODO Problem
    return v(term.clause, term.id); // TODO Problem
    //
  } else {
    throw Exception('substitute: unknown');
  }
}
