part of unify;

/// term type, from which _T (term) and _V (variable) are derived.
///
class _TT {
  /// not for public use
  _TT(int clause, int id)
      : _id = id,
        _clause = clause;

  /// name of the clause, i.e. namespace
  final int _clause;
  int get clause => _clause;

  /// id, i.e. name of the term or variable
  /// identifies a term within the namespace of a clause
  final int _id;
  int get id => _id;

  /// turns an id into a name
  int get name => _id;

  /// returns a string representation of the object
  String string(int i) {
    var ret = '_TT'
        '${clause.toString()}.${id.toString()}';
    return ret;
  }

  @override
  String toString() {
    return string(0);
  }

  ///
  _TT substitute(Bindings b) => _substitute(this, b);

  ///
  _TT _substitute(_TT trm, Bindings b) {
    var term = b.getBinding(trm);

    ///Case 1
    if (term is _T) {
      var tl = term.termlist.map((_TT sub) {
        return _substitute(sub, b);
      }).toList();
      return t(term.clause, term.id, tl);

      /// Case 2
    } else if (term is _V) {
      return v(term.clause, term.id);

      ///
    } else {
      throw Exception('substitute: unknown case');
    }
  }

  /// post occurs check
  /// tests for circularity
  bool occurs(Bindings b) {
    final _m = SplayTreeSet<Key>();
    try {
      _occurs(this, b, _m);
      return false;
    } catch (e) {
      return true;
    }
  }

  /// post occurs check
  /// tests for circularity
  bool _occurs(_TT term, Bindings b, SplayTreeSet<Key> sn) {
    var t = b.getBinding(term);
    //print('t ${term}  t ${t} seen ${sn.length}');
    if (sn.contains(Key.from(t))) {
      throw Exception('Zirkel');
    }
    sn.add(Key.from(t));

    /// Case 1
    if (t is _T) {
      for (_TT sub in t.termlist) {
        var submap = SplayTreeSet<Key>();
        submap.addAll(sn);
        _occurs(sub, b, submap);
      }
      return false;

      /// Case 2
    } else if (t is _V) {
      return false;

      /// no case
    } else {
      throw Exception('_occurs: unknown case');
    }
  }

  /// to avoid circularity in function [mgu]
  bool visited = false;
}
