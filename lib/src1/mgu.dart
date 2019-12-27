part of unify1;

/// Rusizca & Privara's Unification Algorithm
bool mgu(
    _TT s1, _TT t1, SplayTreeMap<IdKey, Substitution> m, Bindings bindings) {
  var s = m[IdKey(s1.clause, s1.id)].substitution ?? s1;
  var t = m[IdKey(t1.clause, t1.id)].substitution ?? t1;
  //var s0 = bindings.reallyGetBinding(s1);
  //var t0 = bindings.reallyGetBinding(t1);

  var b = true;
  // Case 1
  if (s is _T && t is _T) {
    if (s.name != t.name) {
      return false;
    }
    // unify subterms
    var l1 = s.termlist, l2 = t.termlist;

    var len1 = l1.length, len2 = l2.length;

    if (len1 != len2) {
      throw Exception('unify: lists of different lengths');
    }

    for (var i = 0; i < len1; i++) {
      var ss1 = l1[i], ss2 = l2[i];

      // really get muß immer 'versucht' werden
      var sub1 = m[ss1].substitution ?? ss1;
      var sub2 = m[ss2].substitution ?? ss2;

      if (sub1.visited || sub2.visited) {
        b = false;
        //return false;
        //nicht dieselben terme, mindestens ein Unterschied
      } else if (sub1.id != sub2.id || sub1.clause != sub2.clause) {
        sub1.visited = true;
        sub2.visited = true;

        b = mgu(sub1, sub2, m, bindings); // TODO: feed the right m

        sub1.visited = false;
        sub2.visited = false;
      }
    }

    // replace term, if subterms unifiable
    // ist das überhaupt erforderlich?
    // ===>   Lösung:   eine gemeinsame Substitution finden, die könnte
    // ein term nach logischer Substitution sein.
    if (b) {
      //folgende Test sind vermutlich redundant, da vorher
      // schon getestet wurde

      bindings.bindTT(s, t);
      /*
      if (m[IdKey(s.id, s.clause)] == null) {
        m[IdKey(s.id, s.clause)] = Substitution.bound(t);
      } else if (m[IdKey(s.id, s.clause)] != null) {
        /// Test was passiert, wenn beide gleich sind
        if (m[IdKey(s.id, s.clause)].substitution != null &&
            m[IdKey(s.id, s.clause)].substitution?.id != t.id) {
          throw Exception(
              'mgu, Case 1: try to replace with different/wrong _T.id.');
        }
        m[IdKey(s.id, s.clause)].substitution = t;
      } else {
        throw Exception('mgu, Case 1: unknown case.');
      }
      //s.replacedBy = t;
      */
    }
  }

  // Case 2 TODO:
  // s oder t können nur dann _V sein, wenn
  // reallyGet nicht verändert, d.h. wenn die Substitution leer war.
  else if (s is _V && t is _V) {
    bindings.bindVV(s, t);
    /*
    // Case 2.1:
    if (m[IdKey(s.id, s.clause)] == null && m[IdKey(t.id, t.clause)] == null) {
      var subs = Substitution.free();
      m[IdKey(s.id, s.clause)] = subs;
      m[IdKey(t.id, t.clause)] = subs;
      // TODO: geht nicht
      // Case 2.2:
    } else if (m[IdKey(s.id, s.clause)] == null &&
        m[IdKey(t.id, t.clause)] != null) {
      m[IdKey(s.id, s.clause)] = m[IdKey(t.id, t.clause)];
      // Case 2.3:
    } else if (m[IdKey(s.id, s.clause)] != null &&
        m[IdKey(t.id, t.clause)] == null) {
      m[IdKey(t.id, t.clause)] = m[IdKey(s.id, s.clause)];
      // Case 2.x:
    } else {
      throw Exception('mgu, Case 2: unknown case.');
    }
    */
    //s.replacedBy = t;
    b = true;

    // Case 3 TODO:
    // s kann nur dann _V sein, wenn
    // reallyGet nicht verändert, d.h. wenn die Substitution leer war.
  } else if (s is _V && t is _T) {
    bindings.bindVT(s, t);
    /*
    if (m[IdKey(s.id, s.clause)] == null) {
      m[IdKey(s.id, s.clause)] = Substitution.bound(t); // TODO: geht nicht
    } else if (m[IdKey(s.id, s.clause)] != null &&
        m[IdKey(s.id, s.clause)].substitution == null) {
      m[IdKey(s.id, s.clause)].substitution = t;
    } else if (m[IdKey(s.id, s.clause)] != null &&
        m[IdKey(s.id, s.clause)].substitution != null) {
      throw Exception(
          'mgu, Case 3: der Fall kann nicht eintreten, da er durch reallyGet ausgeschlossen wurde');
    } else {
      throw Exception('mgu, Case 3: unknown case.');
    }
    */
    //s.replacedBy = t;
    b = true;

    // Case 4 TODO:
    // t kann nur dann _V sein, wenn
    // reallyGet nicht verändert, d.h. wenn die Substitution leer war.
  } else if (s is _T && t is _V) {
    bindings.bindTV(s, t);
    /*
    if (m[IdKey(t.id, t.clause)] == null) {
      m[IdKey(t.id, t.clause)] = Substitution.bound(s); // TODO: geht nicht
    } else if (m[IdKey(t.id, t.clause)] != null &&
        m[IdKey(t.id, t.clause)].substitution == null) {
      m[IdKey(t.id, t.clause)].substitution = s;
    } else if (m[IdKey(t.id, t.clause)] != null &&
        m[IdKey(t.id, t.clause)].substitution != null) {
      throw Exception(
          'mgu, Case 4: der Fall kann nicht eintreten, da er durch reallyGet ausgeschlossen wurde');
    } else {
      throw Exception('mgu, Case 4: unknown case.');
    }
    */
    //t.replacedBy = s;
    b = true;

    // No Case
  } else {
    throw Exception('Unknown Case.');
  }
  return b;
}
