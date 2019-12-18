part of unify;

Result unify(
  _TT s1,
  _TT t1,
) {
  _TT s = copy(s1); // copy
  _TT t = copy(t1);
  bool unifiable = mgu(s, t);

  bool occursS = s.occurs;
  bool occursT = t.occurs;

  if (occursS || occursT) {
    throw Exception('unify: occurs');
  }

  bool notOccursS = !occursS;
  bool notOccursT = !occursT;
  bool goAhead = notOccursS && notOccursT && unifiable;
  if (goAhead) {
    s.substitute;
    t.substitute;
    return Result((s), (t), unifiable);
  } else {
    throw Exception('unify: not unifiable');
  }
  // kopieren nicht nötig?
}
