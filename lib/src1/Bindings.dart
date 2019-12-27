part of unify1;

class Bindings {
  ///
  Bindings(SplayTreeMap<IdKey, Substitution> m) : _map = m;

  ///
  final SplayTreeMap<IdKey, Substitution> _map;

  /// ersetzt s durch t,
  void bindVT(_V s, _T t) {
    var m = _map;

    /// noch keine substitutin für eine Variable vorbereitet
    if (m[IdKey(s.id, s.clause)] == null) {
      m[IdKey(s.id, s.clause)] = Substitution.bound(t);

      /// substitution ist bereits vorbereitet durch V V
    } else if (m[IdKey(s.id, s.clause)] != null &&
        m[IdKey(s.id, s.clause)].substitution == null) {
      m[IdKey(s.id, s.clause)].substitution = t;

      /// substitution ist bereits vorbereitet durch V T
      /// der Fall läuft aber wegen reallyGet raus auf T T

    } else if (m[IdKey(s.id, s.clause)] != null &&
        m[IdKey(s.id, s.clause)].substitution != null) {
      throw Exception(
          'mgu, Case 3: der Fall kann nicht eintreten, da er durch reallyGet ausgeschlossen wurde');
    } else {
      throw Exception('mgu, Case 3: unknown case.');
    }
  }

  /// Wiederverwenden
  void bindTV(_T s, _V t) => bindVT(t, s);

  ///
  void bindVV(_V s, _V t) {
    var m = _map;
    var keyS = IdKey(s.id, s.clause);
    var keyT = IdKey(t.id, t.clause);
    var mS = m[keyS];
    var mT = m[keyT];

    /// Case 1
    /// keine V hat eine Substitution vorbereitet,
    ///  eine solche Vorbereitung wäre ausschließlich durch V V möglich.
    if (mS == null && mT == null) {
      var subs = Substitution.free();
      m[keyS] = subs;
      m[keyT] = subs;

      /// Case 2:
      /// substitution ist bereits vorbereitet durch V V

    } else if (mS == null && mT != null) {
      m[keyS] = mT;

      /// Case 3:
      /// substitution ist bereits vorbereitet durch V V
    } else if (mS != null && mT == null) {
      m[keyT] = mS;

      /// Case 4: Verschmelzung von Bindings
      /// Das muß in class Substitution geregelt werden.
      /// TODO:
    } else if (mS != null && mT != null) {
      mT.add(mS);
      // Case x:

    } else {
      throw Exception('Bindings.bindVV, Case x: unknown case.');
    }
  }

  /// braucht man nicht, nur der Effiziez wegen, wenn man
  void bindTT(_T s, _T t) {
    //
    var m = _map;
    if (m[IdKey(s.id, s.clause)] == null) {
      m[IdKey(s.id, s.clause)] = Substitution.bound(t);
    } else if (m[IdKey(s.id, s.clause)] != null) {
      /// wenn beide ungleiche Namen haben
      if (m[IdKey(s.id, s.clause)].substitution != null &&
          m[IdKey(s.id, s.clause)].substitution?.id != t.id) {
        throw Exception(
            'mgu, Case 1: try to replace with different/wrong _T.id.');

        /// wenn beide gleiche Namen haben.
      } else {
        m[IdKey(s.id, s.clause)].substitution = t;
      }
    } else {
      throw Exception('mgu, Case 1: unknown case.');
    }
  }

  ///  versuch ein allgemeines bind zu machen
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

  ///
  /// bind sollte die einzige set methode sein.
  ///
  /// die anderen sollten von bind benutzt werden,
  /// je nach Ergebnis der tests
  ///

  void addFree(int clause, int id, _T term) =>
      _map[IdKey(clause, id)] = Substitution.free();

  ///
  void addFreeTT(_TT t, _T term) =>
      _map[IdKey(t.clause, t.id)] = Substitution.free();

  ///
  void addBinding(int clause, int id, _T term) =>
      _map[IdKey(clause, id)] = Substitution.bound(term);

  ///
  void addBindingTT(_TT t, _T term) =>
      _map[IdKey(t.clause, t.id)] = Substitution.bound(term);

  ///
  void updateBinding(int clause, int id, _T term) =>
      _map[IdKey(clause, id)].substitution = term;

  ///
  void updateBindingTT(_TT t, _T term) =>
      _map[IdKey(t.clause, t._id)].substitution = term;

  ///
  bool hasBinding(int clause, int id, _T term) =>
      _map.containsKey(IdKey(clause, id));

  ///
  bool hasBindingTT(_TT t, _T term) => _map.containsKey(IdKey(t.clause, t.id));

  ///
  _T? getBinding(int clause, int id) => _map[IdKey(clause, id)].substitution;

  _TT reallyGetBinding(_TT s) {
    return _map[IdKey(s.clause, s.id)].substitution ?? s;
  }
}
