part of unify;

/// Rusizca & Privara's Unification Algorithm
bool mgu(
  _TT s1,
  _TT t1,
) {
  var s = s1.reallyGet;
  var t = t1.reallyGet;

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
      var s1 = l1[i], s2 = l2[i];

      var sub1 = s1.reallyGet;
      var sub2 = s2.reallyGet;

      if (sub1.visited || sub2.visited) {
        b = false;
        //return false;
      } else if (sub1.unique != sub2.unique) {
        sub1.visited = true;
        sub2.visited = true;

        b = mgu(sub1, sub2);

        sub1.visited = false;
        sub2.visited = false;
      }
    }
    // replace term, if subterms unifiable
    if (b) {
      s.replacedBy = t;
    }
  }
  // Case 2
  else if (s is _V && t is _V) {
    s.replacedBy = t;
    b = true;

    // Case 3
  } else if (s is _V && t is _T) {
    s.replacedBy = t;
    b = true;

    // Case 4
  } else if (s is _T && t is _V) {
    t.replacedBy = s;
    b = true;

    // No Case
  } else {
    throw Exception('Unknown Case.');
  }
  return b;
}
