part of unify2;

/// term type, from which _T (term) and _V (variable) are derived.
///
class _TT {
  /// not for use in public ;-)
  /// terms with same [clause] and [id]
  /// must have same [unique] and
  /// must be the same object.
  _TT(int clause, int id, int unique)
      : _id = id,
        _clause = clause,
        _uni = unique {
    // Dieser Constructor wird gebraucht
    if (identicalId.containsKey(Key(clause, id))) {
      throw Exception('not unique');
    } // weitere Test
  }

  /// turns symbolic identity into object identity
  /// terms with same [clause] and [id]
  /// must have same [unique] and
  /// must be the same object.
  factory _TT.unique(int clause, int id) {
    //throw Exception('_TT.unique: Not implemented!?');

    if (identicalId.containsKey(Key(clause, id))) {
      var ret = identicalId[Key(clause, id)];
      if (ret is _TT) {
        return ret;
      } else {
        throw Exception(' _TT.unique: der falsche Type wird zurückgegeben.');
      }
    } else {
      _unique++;
      var i = _TT(clause, id, _unique);
      identicalId[Key(clause, id)] = i;
      return i;
    }
  }

  static SplayTreeMap<Key, _TT> identicalId = SplayTreeMap<Key, _TT>();

  /// number of the clause, like a namespace for id
  final int _clause;
  int get clause => _clause;

  /// id, i.e. name of the term,
  /// identifies a term within the namespace of a clause
  final int _id;
  int get id => _id;

  /// turns an id into a name
  int get name => _id;

  /// implements the unique identity of a term object
  /// like a hashCode
  int _uni = 0;

  /// counter to make [unique] unique
  static int _unique = 0;

  /// like a hashCode
  int get unique => _uni;

  /// turns [unique] into a [hashCode]
  @override
  int get hashCode => _uni;

  /// returns a string representation of the object
  String string(int i) {
    var ret = '_TT'
        ' ${clause.toString()}.${id.toString()}'
        '|${unique.toString()}'
        '/replacedBy(${replacedBy})';
    return ret;
  }

  @override
  String toString() {
    return string(0);
  }

  /// print 'replaced by'
  String printReplacedBy(_TT t) {
    var s = seen(<int>{});
    return _printReplacedBy(t, s);
  }

  /// print 'replaced by'
  String _printReplacedBy(_TT term, bool Function(_TT) testCircular) {
    if (testCircular(term)) {
      throw Exception('_reallyGet: circular  ');
    }
    var dieser =
        '${term.runtimeType.toString()}${term.clause.toString()}.${term.id.toString()} -> ';
    dynamic sub = term.replacedBy;
    if (sub == null) {
      return dieser + 'null';
    } else if (sub != null && sub is _TT) {
      return dieser + _printReplacedBy(sub, testCircular);
    } else {
      throw Exception('_reallyGet: unknown');
    }
  }

  /// replacements are generalized bindings or substitutions,
  /// that can substitute non-variables, too
  dynamic _replacedBy;

  /// gets the direct replacement (generalized binding)
  dynamic get replacedBy => _replacedBy;

  /// sets a new direct replacement (generalized binding)
  set replacedBy(_TT o) {
    var thisToBeReplaced = reallyGet;
    var otherToBeReplaced = o.reallyGet;

    /// excludes circularity originating from other than symbolic identity
    if (thisToBeReplaced.unique == otherToBeReplaced.unique) {
      var thisToBeReplacedPre = reallyGetPre;

      thisToBeReplacedPre._replacedBy = otherToBeReplaced;
      otherToBeReplaced._replacedBy = thisToBeReplaced;
    } else {
      thisToBeReplaced._replacedBy = o;
    }
  }

  /// realize bindings
  _TT get reallyGet {
    var s = seen(<int>{});
    return _reallyGet(this, s);
  }

  _TT _reallyGet(_TT term, bool Function(_TT) testCircular) {
    if (testCircular(term)) {
      throw Exception('_reallyGet: circularity');
    }

    dynamic sub = term.replacedBy;
    if (sub == null) {
      return term;
    } else if (sub != null && sub is _TT) {
      return _reallyGet(sub, testCircular);
    } else {
      throw Exception('_reallyGet: unknown case');
    }
  }

  /// realize bindings to previous
  _TT get reallyGetPre {
    var s = seen(<int>{});
    return _reallyGetPre(this, s);
  }

  /// realize bindings
  _TT _reallyGetPre(_TT term, bool Function(_TT) testCircular) {
    if (testCircular(term)) {
      throw Exception('_reallyGetPre: circularity');
    }
    dynamic sub = term.replacedBy;
    if (sub != null && sub is _TT) {
      dynamic subsub = sub.replacedBy;
      if (subsub == null) {
        return term;
      } else if (subsub != null) {
        return _reallyGetPre(sub, testCircular);
      } else {
        throw Exception('_reallyGet: unknown 1');
      }
    } else {
      throw Exception('_reallyGet: unknown 2');
    }
  }

  /// post occurs check
  /// tests for circularity
  bool get occurs => _occurs(this, seen(<int>{}));

  /// post occurs check
  /// tests for circularity
  bool _occurs(_TT term, bool Function(_TT) testCircular) {
    var t = term.reallyGet;

    if (testCircular(t)) {
      return true;
    }
    // Case 1
    if (t is _T) {
      (t.termlist).forEach((_TT sub) {
        _occurs(sub, testCircular);
      });
      return false;
      // Case 2
    } else if (t is _V) {
      return false;
      // no case
    } else {
      throw Exception('_occurs: unknown case');
    }
  }

  /// realize bindings, i.e. substitute
  _TT get substitute => _substitute(this);

  /// realize bindings, i.e. substitute
  _TT _substitute(_TT trm) {
    var term = trm.reallyGet;
    //Case 1
    if (term is _T) {
      var tl = term.termlist.map((_TT sub) {
        return _substitute(sub);
      }).toList();
      term.termlist = tl;
      return term;
      // Case 2
    } else if (term is _V) {
      return term;
      //
    } else {
      throw Exception('substitute: unknown case');
    }
  }

  /// data structure for test of preoccurrance
  bool Function(_TT) seen(Set<int> start) {
    return (_TT x) {
      if (start.contains(x.unique)) {
        return true;
      } else {
        start.add(x.unique);
        return false;
      }
    };
  }

  /// to avoid circularity in function [mgu]
  bool visited = false;
}
