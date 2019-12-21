part of unify;

/// The term type, from which _T (term) and _V (variable) are derived.
///
class _TT {
  /// The constructor is only for internal use!
  /// Use with care!
  /// Terms that have the same clause and id
  /// must have the same unique must be the same object.
  _TT(int clause, int id, int unique)
      : _id = id,
        _clause = clause,
        _uni = unique {
    // Dieser Constructor wird gebraucht
    if (identicalId.containsKey(IdKey(clause, id))) {
      throw Exception('not unique');
    } // weitere Test
  }

  ///
  /// factory implementiert Identität, aufgrund von claus und id
  /// Use with care! Terms that are given
  /// the same clause and id will be the same object
  factory _TT.unique(int clause, int id) {
    throw Exception('_TT.unique: Not implemented!?');
    _unique++;
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
  String string(int i) {
    var ret =
        '_TT ${clause.toString()}.${id.toString()}|${unique.toString()}/replacedBy(${replacedBy})';
    return ret;
  }

  @override
  String toString() {
    return string(0);
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

  _TT get reallyGet {
    bool Function(_TT) s = iis(<int>{});
    return _reallyGet(this, s);
  }

  // zirkel aware
  _TT _reallyGet(_TT term, bool Function(_TT) testCircular) {
    if (testCircular(term)) {
      throw Exception('_reallyGet: circular in ' +
          term.runtimeType.toString() +
          ' ' +
          term.clause.toString() +
          '.' +
          term.id.toString());
    }

    dynamic sub = term.replacedBy;
    if (sub == null) {
      return term;
    } else if (sub != null && sub is _TT) {
      return _reallyGet(sub, testCircular);
    } else {
      throw Exception('_reallyGet: unknown');
    }
  }

  void pr(String s, _TT term) {
    print(s +
        '  ' +
        term.runtimeType.toString() +
        ' ' +
        term.clause.toString() +
        '.' +
        term.id.toString() +
        ' uni ' +
        term.unique.toString());
  }

  // zyklen entdecken
  // TODO
  bool get occurs => _occurs(this, iis(<int>{}));

  bool _occurs(_TT term, bool Function(_TT) testCircular) {
    _TT t = term.reallyGet; // tests circularity of replacements
    // tests circularity of
    print(" test _occurs ");
    if (testCircular(t)) {
      print(" _occurs ");
      return true;
    }
    if (t is _T) {
      (t.termlist).forEach((_TT sub) {
        _occurs(sub, testCircular);
      });
      return false;
      //
    } else if (t is _V) {
      return false;
      //
    } else {
      throw Exception('_occurs: unknown');
    }
  }

  /*
  bool _occurs(_TT term, bool Function(_TT) testCircular) {
    _TT t = term.reallyGet; // last but null
    //
    if (t is _T) {
      bool ret = (t.termlist).map((_TT sub) {
        return _occurs(sub, testCircular);
      }).fold<bool>(true, (bool acc, bool elem) => acc && elem);
      return ret;
      //
    } else if (t is _V) {
      return testCircular(t);
      //
    } else {
      throw Exception('_occurs: unknown');
    }
  }
  */
// replacements ausführen
  _TT get substitute => _substitute(this);

  _TT _substitute(_TT trm) {
    _TT term = trm.reallyGet; // last but null
    //
    if (term is _T) {
      var ret = t(
          term.clause,
          term.id,
          (term.termlist).map((_TT sub) {
            return _substitute(sub);
          }).toList());
      return ret;
      //
    } else if (term is _V) {
      return term;
      //
    } else {
      throw Exception('substitute: unknown');
    }
  }

  bool Function(_TT) iis(Set<int> start) {
    return (_TT x) {
      if (start.contains(x.unique)) {
        //pr('iis: contains', x);
        return true;
      } else {
        //pr('iis: add', x);

        start.add(x.unique);
        return false;
      }
    };
  }

  //
  bool visited = false;
}
