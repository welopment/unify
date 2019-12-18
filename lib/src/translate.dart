part of unify;

/// Translate
/*
_TT translate<A>(Termtype<A, Id> term) {
  //
  if (term is Term<A, Id>) {
    var ret = _T(
        term.id.clause,
        term.id.id,
        term.id.unique,
        (term.termlist).map<_TT>((Termtype<A, Id> sub) {
          return translate<A>(sub);
        }).toList());
    return ret;
    //
  } else if (term is Var<A, Id>) {
    return _V(term.id.clause, term.id.id, term.id.unique);
    //
  } else {
    throw Exception('substitute: unknown');
  }
}
 */
