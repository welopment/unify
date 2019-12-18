part of unify;

/// Unification nach Rusizca Privara

bool mgu(
  _TT s,
  _TT t,
) {
  //print('\n All . All > ' + s.toString() + ' | ' + t.toString());

  bool b = true;
  // Case
  if (s is _T && t is _T) {
    // print('\n _T . _T > ' + s.toString() + ' | ' + t.toString());
    // Vergleich der Namen
    // einzige Aktion die sich auf aktuellen term bezieht, danach nur noch subterme
    if (s.name != t.name) {
      return false;
    }
    // jetzt subterme verarbeiten
    List<_TT> l1 = s.termlist, l2 = t.termlist;

    int len1 = l1.length, len2 = l2.length;

    if (len1 != len2) {
      throw Exception('unify: list of different lengths.');
    }

    for (int i = 0; i < len1; i++) {
      _TT sub1 = l1[i], sub2 = l2[i];

      if (sub1.visited || sub2.visited) {
        b = false;
        //return false;
        // vielleicht den replacedBy nachgehen.
      } else if (sub1.unique != sub2.unique) {
        //print('\nstart visit');

        sub1.visited = true;
        sub2.visited = true;

        b = mgu(sub1, sub2);

        sub1.visited = false;
        sub2.visited = false;
        //print('\nleave visit');
      }
    }
    // wenn die subterme unifizierbar sind, kann der aktuelle term ersetzt werden.
    if (b) {
      //print('\n>> replace: ' + s.toString() + '\n>> durch: ' + t.toString());
      s.replacedBy = t;
    }
  }
  // Case
  else if (s is _V && t is _V) {
    //print('\n _V . _V > ' + s.toString() + ' | ' + t.toString());

    //print('\n>> replace: ' + s.toString() + '\n>>  durch: ' + t.toString());

    s.replacedBy = t;
    b = true;

    // Case
  } else if (s is _V && t is _T) {
    // print('\n _V . _T > ' + s.toString() + ' | ' + t.toString());

    // print('\n>> replace: ' + s.toString() + '\n>>  durch: ' + t.toString());

    s.replacedBy = t;
    b = true;

    // Case
  } else if (s is _T && t is _V) {
    //print('\n _T . _V > ' + s.toString() + ' | ' + t.toString());

    //print('\n>> replace: ' + t.toString() + '\n>> durch: ' + s.toString());

    t.replacedBy = s;
    b = true;

    // No Case
  } else {
    throw Exception('Unknown Case.');
  }
  return b;
}
