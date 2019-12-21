part of unify;

/// Term _T
class _T extends _TT {
  //
  _T(int clause, int id, int unique, List<_TT> t)
      : _termlist = t,
        super(clause, id, unique);

  //
  factory _T.unique(int clause, int id, List<_TT> list) {
    _TT._unique++;
    if (_TT.identicalId.containsKey(IdKey(clause, id))) {
      _TT t = _TT.identicalId[IdKey(clause, id)];
      if (t is _T) {
        return t;
      } else if (t is _V) {
        throw Exception('_T.unique: Wrong type.');
      } else {
        throw Exception('_T.unique: Unknown case.');
      }
    } else {
      _T i = _T(clause, id, _TT._unique, list);
      _TT.identicalId[IdKey(clause, id)] = i;
      return i;
    }
  }

  final List<_TT> _termlist;

  List<_TT> get termlist => _termlist;

  @override
  String toString() {
    return '_T '
        '${clause.toString()}.${id.toString()}|'
        '${super.unique.toString()}'
        '/replacedBy(${replacedBy})'
        '${termlist}';
  }

  @override
  bool operator ==(dynamic other) {
    if (other is _T) {
      int tl = termlist.length;
      int otl = other.termlist.length;

      // 1.
      bool equallengths = tl == otl;

      // 2.
      bool equalnames = id == other.id;

      // 3.
      bool resultequallist = true;
      for (int i = 0; i < tl; i++) {
        bool equallist = termlist[i] == other.termlist[i];
        resultequallist && equallist
            ? resultequallist = true
            : resultequallist = false;
      }

      // 1. + 2. + 3.
      return equallengths && equalnames && resultequallist;
    } else {
      return false;
    }
  }
}
