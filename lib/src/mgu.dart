part of unify;

/// Rusizca & Privara's Unification Algorithm

///
bool mgu(Term s1, Term t1, Bindings bindings) {
  // var s = m[Key(s1.clause, s1.id)].substitution ?? s1;
  // var t = m[Key(t1.clause, t1.id)].substitution ?? t1;
  var s = bindings.getBinding(s1);
  var t = bindings.getBinding(t1);

  var b = true;

  /// Case 1
  if (s is Compound && t is Compound) {
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

      // var sub1 = m[ss1].substitution ?? ss1;
      // var sub2 = m[ss2].substitution ?? ss2;
      var sub1 = bindings.getBinding(ss1);
      var sub2 = bindings.getBinding(ss2);
      if (sub1.visited || sub2.visited) {
        b = false;
        // return false;
        // folgende Bedingnung macht den Algorithmus effizienter,
        // sofern auch Compound gegen Compound substituiert wird.
      } else if (sub1.clause != sub2.clause || sub1.id != sub2.id) {
        sub1.visited = true;
        sub2.visited = true;

        b = mgu(sub1, sub2, bindings);

        sub1.visited = false;
        sub2.visited = false;
      }
    }

    // macht den Algorithmus effizienter, da
    // äquivalente Compounds derselben Klasse
    // nicht mehrmals besucht werden.
    if (b) {
      // bindings.bindTT(s, t);
    }
  }

  ///
  /// Case 2
  // s oder t können nur dann Variable sein, wenn
  // getBinding nichts verändert, d.h. wenn die Äquivalenzklasse leer war.
  else if (s is Variable && t is Variable) {
    bindings.bindVV(s, t);

    b = true;

    /// Case 3
    // s kann nur dann Variable sein, wenn
    // getBinding nicht verändert, d.h. wenn die Äquivalenzklasse leer war.
  } else if (s is Variable && t is NonVariable){ //
    // (t is Compound || t is Constant) ) 
    bindings.bindVC(s, t);

    b = true;

    /// Case 4
    // t kann nur dann Variable sein, wenn
    // getBinding nicht verändert, d.h. wenn die Äquivalenzklasse leer war.
  } else if ( s is NonVariable && t is Variable) {
    bindings.bindCV(s, t);

    b = true;

    // No Case
  } else {
    throw Exception('Unknown Case.');
  }
  return b;
}