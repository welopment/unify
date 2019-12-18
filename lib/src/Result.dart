part of unify;

class Result {
  Result(_TT t1, _TT t2, bool unifiable)
      : _t1 = t1,
        _t2 = t2,
        _unifiable = unifiable;

  final _TT _t1;
  _TT get term1 => _t1;

  final _TT _t2;
  _TT get term2 => _t2;

  final bool _unifiable;
  bool get unifiable => _unifiable;
}
