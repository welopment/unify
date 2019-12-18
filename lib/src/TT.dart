part of unify;



/// The super class, from which Term and Var are derived
/// Term
class _TT {
  /// Konstruktor nur für internen Gebrauch
  /// sollte privat sein
  _TT(int clause, int id, int unique)
      : _id = id,
        _clause = clause,
        _uni = unique {
    if (identicalId.containsKey(IdKey(clause, id))) {
      throw Exception('not unique');
    }
  }

  ///
  /// factory implementiert Identität, aufgrund von claus und id
  factory _TT.unique(int clause, int id) {
    _unique++;
    int _uni = _unique;

    if (identicalId.containsKey(IdKey(clause, id))) {
      return identicalId[IdKey(clause, id)];
    } else {
      _TT i = _TT(clause, id, _unique);
      identicalId[IdKey(clause, id)] = i;
      return i;
    }
  }

  static SplayTreeMap<IdKey, _TT> identicalId = SplayTreeMap<IdKey, _TT>();

  /// In welcher Klausel, d.h. Namensraum
  final int _clause;
  int get clause => _clause;

  /// Id innerhalb einer Klausel.
  final int _id;
  int get id => _id;

  /// Id ist name innerhalb eines Namensraums
  int get name => _id;

  /// Feld der Instanz für Zähler
  int _uni = 0;

  /// Zähler für unique == HashCode
  static int _unique = 0;

  //
  int get unique => _uni;

  @override
  int get hashCode => _uni;

  @override
  String toString() {
    return '_TT ${clause.toString()}.${id.toString()}|${unique.toString()}/replacedBy(${replacedBy})';
  }

  /// Replacements, zunächst null
  dynamic _replacedBy;

  dynamic get replacedBy => _replacedBy;

  set replacedBy(dynamic o) {
    // Tests? Posttests?
    // push down
    _TT tbr = reallyGet;
    tbr._replacedBy = o;
  }

  _TT get reallyGet => _reallyGet(this);
  _TT _reallyGet(_TT term) {
    dynamic sub = term.replacedBy;
    if (sub == null) {
      return term;
    } else if (sub != null && sub is _TT) {
      return _reallyGet(sub);
    } else {
      throw Exception('_reallyGet: unknown');
    }
  }

  // zyklen entdecken
  //_TT runThrough(_TT Function(_TT) f) => _runThrough(this, f);
  bool get occurs => _occurs(this, iis(<int>{}));

  bool _occurs(_TT term, bool Function(_TT) f) {
    var t = term.reallyGet; // last but null
    //
    if (t is _T) {
      bool ret = (t.termlist).map((_TT sub) {
        return _occurs(sub, f);
      }).fold<bool>(true, (bool acc, bool elem) => acc && elem);
      return ret;
      //
    } else if (t is _V) {
      return f(t);
      //
    } else {
      throw Exception('_occurs: unknown');
    }
  }

// replacements ausführen
  _TT get substitute => _substitute(this);

  _TT _substitute(_TT term) {
    var t = term.reallyGet; // last but null
    //
    if (t is _T) {
      var ret = _T(
          t.clause,
          t.id,
          t.unique,
          (t.termlist).map((_TT sub) {
            return _substitute(sub);
          }).toList());
      return ret;
      //
    } else if (t is _V) {
      return t;
      //
    } else {
      throw Exception('substitute: unknown');
    }
  }

  bool Function(_TT) iis(Set<int> start) {
    return (_TT x) {
      if (start.contains(x.unique)) {
        return true;
      } else {
        start.add(x.unique);
        return false;
      }
    };
  }

  //
  bool visited = false;
}
