part of unify;

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

  /// ersetzt s durch t
  void bindVT(_V s, _T t) {
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

  /// Wiederverwendung
  void bindTV(_T s, _V t) => bindVT(t, s);

  ///
  void bindVV(_V s, _V t) {
    var m = _m;

    ///
    var keyS = Key.from(s);
    var keyT = Key.from(t);
    var mS = m[keyS];
    var mT = m[keyT];

    ///
    /// Case 1
    /// für keine Variable [_V] existiert eine Substitution,
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
      for (Key i in br) {
        m[i] = subst;
      }

      /// Case x:
    } else {
      throw Exception('Bindings.bindVV, Case x: unknown case.');
    }
  }

  /// der Effiziez wegen

  void bindTT(_T s, _T t) {
    ///
    var m = _m;

    ///
    if (m[Key.from(s)] == null) {
      m[Key.from(s)] = Substitution.bound(s, t);

      ///
    } else if (m[Key.from(s)] != null) {
      var ids = Key.from(s);

      /// wenn beide _TT ungleiche Namen haben
      if (m[ids].substitution != null && m[ids].substitution?.id != t.id) {
        throw Exception('mgu, Case 1: '
            'try to replace with different/wrong _T.id.');

        /// wenn Substitution leer ist, oder
        /// wenn beide _TT gleiche Namen haben
      } else {
        m[Key.from(s)].substitution = t;
      }

      ///
    } else {
      throw Exception('mgu, Case 1: unknown case.');
    }
  }

  ///  Verallgemeinerung
  void bind(_TT term1, _TT term2) {
    if (term1 is _V && term2 is _V) {
      bindVV(term1, term2);
    } else if (term1 is _T && term2 is _V) {
      bindTV(term1, term2);
    } else if (term1 is _V && term2 is _T) {
      bindVT(term1, term2);
    } else if (term1 is _T && term2 is _T) {
      bindTT(term1, term2);
    } else {
      throw Exception('Bindings.bind: unknown case.');
    }
  }

  _TT getBinding(_TT s) {
    //print('getBinding: ${s.toString()}');
    var m = _m[Key.from(s)];

    if (m != null) {
      return m.substitution ?? s;
    } else {
      return s;
    }
  }
}
