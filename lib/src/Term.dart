part of unify;

/// Superclass from which all other classes are derived.
class Term {
  /// Terms with the same values of [clause] and [id] represent the same object
  /// and have the same value of [unique]
  Term(int clause, int id)
      : _id = id,
        _clause = clause,
        _unique = _u++;

  final int _unique;

  static int _u = 0;

  int get unique => _unique;

  /// name of the clause, i.e. namespace
  final int _clause;

  int get clause => _clause;

  /// id, i.e. name of the term or variable
  /// identifies a term within the namespace of a clause
  final int _id;
  int get id => _id;

  /// turns an id into a name
  int get name => _id;

  @override
  int get hashCode => Key(clause, id).hashCode;

  /// returns a string representation of the object
  String string(int i) {
    var ret = 'Term'
        '${clause.toString()}.${id.toString()}';
    return ret;
  }

  @override
  String toString() {
    return string(0);
  }

  ///
  Term substitute(Bindings b) => _substitute(this, b);

  ///
  Term _substitute(Term trm, Bindings b) {
    var term = b.getBinding(trm);

    ///Case 1
    if (term is Compound) {
      var tl = term.termlist.map((Term sub) {
        return _substitute(sub, b);
      }).toList();
      return c(term.clause, term.id, tl);

      /// Case 2
    } else if (term is Variable) {
      return v(term.clause, term.id);
      //
    } else if (term is Number) {
      return n(term.clause, term.id, term.value);
      //
    } else if (term is Atom) {
      return a(term.clause, term.id, term.value);

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
  bool _occurs(Term term, Bindings b, SplayTreeSet<Key> sn) {
    var t = b.getBinding(term);
    //print('t ${term}  t ${t} seen ${sn.length}');
    if (sn.contains(Key.from(t))) {
      throw Exception('Zirkel');
    }
    sn.add(Key.from(t));

    /// Case 1
    if (t is Compound) {
      for (var sub in t.termlist) {
        var submap = SplayTreeSet<Key>();
        submap.addAll(sn);
        _occurs(sub, b, submap);
      }
      return false;

      /// Case 2
    } else if (t is Variable) {
      return false;
    } else if (t is NonVariable) {
      return false;

      /// no case
    } else {
      throw Exception('_occurs: unknown case');
    }
  }

  /// to avoid circularity in function [mgu]
  bool visited = false;
}
