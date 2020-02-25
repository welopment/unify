part of unify;

/// Bindings include logical substitutions as well as substitutions that improve
/// performance. As an example of the first case let a variable to be bound to
/// a [Number]. As an example of the second case a [Compound] can be bound to
/// another [Compound] by calling [bindCC] if the subterms of these [Compound]s
/// are unifiable to avoid unnecessary revisiting of subterms.
class Bindings {
  ///
  Bindings(SplayTreeMap<Key, Substitution> m) : _m = m;
  factory Bindings.empty() {
    var _m = SplayTreeMap<Key, Substitution>();
    return Bindings(_m);
  }

  ///
  final SplayTreeMap<Key, Substitution> _m;
  @override
  String toString() {
    var s = '{';
    for (var i in _m.keys) {
      s += i.toString() + ':' + _m[i].toString() + ', ';
    }
    return s + '}';
  }

  /// Bin ersetzt s durch t
  void bindVC(Variable s, NonVariable t) {
    if (t is Variable) {
      throw Exception('Bindings.bindVC: t must not be Variable');
    }

    // print('${s} ${t}');
    var m = _m;
    var i = Key.from(s);
    var subst = m[i];

    /// Keine substitution für eine der beiden Variablen
    if (subst == null) {
      m[i] = Substitution.bound(s, t);

      /// Substitution existiert nach bind V V
    } else if (subst != null && subst.substitution == null) {
      subst.substitution = t;

      subst.addBackReference = s;

      /// Substitution existiert nach bind V T
      /// der Fall läuft aber wegen getBinding raus auf T T
    } else if (subst != null && subst.substitution != null) {
      throw Exception(
          'mgu, Case 3: der Fall kann nicht eintreten, da er durch reallyGet ausgeschlossen wurde');
    } else {
      throw Exception('mgu, Case 3: unknown case.');
    }
  }

  /// The method [bindCV] performs a logical substitution and by reusing [bindVC] as its mirror case.
  void bindCV(NonVariable s, Variable t) {
    if (s is Variable) {
      throw Exception('Bindings.bindCV: t must not be Variable');
    }
    bindVC(t, s);
  }

  /// The method [bindVV] performs a logical substitution and binds two [Variable]s
  /// together. These [Variable]s become part of the same equivalence class.
  /// Four logical cases:
  /// Case 1:  Both [Variable]s are free. They become part of a new equivalence class
  /// Case 2:  Left [Variable] was free and is now bound. Both are now part of an existing equivalence class.
  /// Case 3:  Right [Variable] was free and ist now bound. Both are now part of an existing equivalence class.
  /// Case 4:  Both [Variable]s were already bound and bindings are fused.

  void bindVV(Variable s, Variable t) {
    var m = _m;

    ///
    var keyS = Key.from(s);
    var keyT = Key.from(t);
    var mS = m[keyS];
    var mT = m[keyT];

    ///
    /// Case 1
    /// für keine Variable [Variable] existiert eine Substitution,
    /// eine solche wäre ausschließlich durch
    /// Bindung zwischen Variablen (V V) möglich.
    if (mS == null && mT == null) {
      var subs = Substitution.free(s, t);
      subs.addBackReference = s;
      subs.addBackReference = t;

      // beide Variablen werden Teil derselben Äquialenz
      m[keyS] = subs;
      m[keyT] = subs;

      ///
      /// Case 2:
      /// substitution ist bereits vorbereitet durch V V
    } else if (mS == null && mT != null) {
      // die Äquivalenzklasse wird erweitert.
      mT.addBackReference = s;
      mT.addBackReference = t;
      m[keyS] = mT;

      ///
      /// Case 3:
      /// substitution ist bereits vorbereitet durch V V
    } else if (mS != null && mT == null) {
      // die Äquivalenzklasse wird erweitert.
      mS.addBackReference = s;
      mS.addBackReference = t;
      m[keyT] = mS;

      ///
      /// Case 4: Verschmelzung von Bindings
    } else if (mS != null && mT != null) {
      var subst = Substitution.add(mS, mT);
      subst.addBackReference = s;
      subst.addBackReference = t;

      /// ggf. redundant
      var br = subst._backReferences;
      for (var i in br) {
        m[i] = subst;
      }

      /// Case x:
    } else {
      throw Exception('Bindings.bindVV, Case x: unknown case.');
    }
  }

  /// The method [bindCC] does not perform a logical substitution but
  /// improves performance by avoiding the unnecessarily repeted unification of
  /// [Comound]s that were already found to be unifiable.
  void bindCC(Compound s, Compound t) {
    ///
    var m = _m;

    ///
    if (m[Key.from(s)] == null) {
      m[Key.from(s)] = Substitution.bound(s, t);

      ///
    } else if (m[Key.from(s)] != null) {
      var ids = Key.from(s);

      /// wenn beide Term ungleiche Namen haben
      if (m[ids].substitution != null && m[ids].substitution.id != t.id) {
        throw Exception('mgu, Case 1: '
            'try to replace with different/wrong Compound.id.');

        /// wenn Substitution leer ist, oder
        /// wenn beide Term gleiche Namen haben
      } else {
        m[Key.from(s)].substitution = t;
      }

      ///
    } else {
      throw Exception('mgu, Case 1: unknown case.');
    }
  }

  /// The method [bind] branches into [bindVV], [bindCV], [bindVC], and [bindCC]
  /// according to the type of the arguments.
  void bind(Term term1, Term term2) {
    if (term1 is Variable && term2 is Variable) {
      bindVV(term1, term2);
    } else if (term1 is Compound && term2 is Variable) {
      bindCV(term1, term2);
    } else if (term1 is Variable && term2 is Compound) {
      bindVC(term1, term2);
    } else if (term1 is Compound && term2 is Compound) {
      bindCC(term1, term2);
    } else {
      throw Exception('Bindings.bind: unknown case.');
    }
  }

  /// Returns the term bound to the variable given as argument.
  Term getBinding(Term s) {
    //print('getBinding: ${s.toString()}');
    var m = _m[Key.from(s)];

    if (m != null) {
      if (m.substitution != null) {
        return m.substitution;
      } else {
        return s;
      }
    } else {
      return s;
    }
  }
}
