part of unify;

class Result {
  Result();

  factory Result.bound(SplayTreeMap<Key, Substitution> s, bool u) {
    return Result()
      .._substitution = s
      ..unifiable = u;
  }
  SplayTreeMap<Key, Substitution>? _substitution;

  SplayTreeMap<Key, Substitution>? get substitution => _substitution;

  set substitution(SplayTreeMap<Key, Substitution>? substitution) {
    _substitution = substitution;
  }

  bool? unifiable = false;
}
