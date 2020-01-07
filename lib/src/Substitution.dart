part of unify;

class Substitution {
  /// nicht direkt verwenden
  Substitution(int uni)
      : _unique = uni,
        _backReferences = SplayTreeSet<Key>((Key i1, Key i2) {
          if (i1.clause == i2.clause && i1.id == i2.id) {
            return 0;
          } else {
            // implements lexical ordering
            return (2 * i1.clause.compareTo(i2.clause)) +
                i1.id.compareTo(i2.id);
          }
        });

  factory Substitution.add(Substitution s1, Substitution s2) {
    /// die Rückverweise
    var re = <Key>{};
    var s1Copy = s1.getBackReference.map((Key x) => Key(x.clause, x.id));
    var s2Copy = s2.getBackReference.map((Key x) => Key(x.clause, x.id));
    re.addAll(s1Copy);
    re.addAll(s2Copy);

    /// beide nicht null aber ungleiche namen
    if (s1.substitution != null &&
        s2.substitution != null &&
        s1.substitution.id != s2.substitution.id) {
      throw Exception('Substitution.add: different Compound.id');

      /// gleich oder gleich machbar
    } else if ((s1.substitution != null &&
            s2.substitution != null &&
            s1.substitution.id == s2.substitution.id) ||
        (s1.substitution != null && s2.substitution == null) ||
        (s1.substitution == null && s2.substitution != null)) {
      ///
      var su;
      if (s1.substitution != null) {
        su = s1.substitution;
      } else {
        su = s2.substitution;
      }

      Substitution._uni++;
      var ret = Substitution(_uni)
        .._substitution = su
        .._backReferences = re;
      return ret;

      ///
    } else if (s1.substitution == null && s2.substitution == null) {
      /// keine Substitution vorhanden
      Substitution._uni++;
      var ret = Substitution(_uni).._backReferences = re;
      return ret;
    } else {
      throw Exception('Substitution.add: unknown case.');
    }
  }

  ///

  factory Substitution.bound(Term t, Term s) {
    Substitution._uni++;

    var su = Substitution(_uni);
    su._substitution = s;
    su.addBackReference = t;
    return su;
  }

  ///
  factory Substitution.free(t1, t2) {
    Substitution._uni++;

    var s = Substitution(_uni);
    s.addBackReference = t1;
    s.addBackReference = t2;
    return s;
  }

  ///
  static int _uni = 0;

  int _unique;

  ///
  Set<Key> _backReferences;

  set addBackReference(Term t) {
    _backReferences.add(Key.from(t));
  }

  Set<Key> get getBackReference {
    return _backReferences;
  }

  ///
  dynamic _substitution;

  Compound get substitution => _substitution;

  set substitution(Term substitution) {
    _substitution = substitution;
  }

  @override
  String toString() {
    var s = _substitution.toString();
    var r = _backReferences.toString();

    return '{ #' + _unique.toString() + ' s:' + s + ' br:' + r + '} ';
  }
}
