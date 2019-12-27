part of unify1;

class Result {
  Result();

  factory Result.bound(SplayTreeMap<IdKey, Substitution> s, bool u) {
    return Result()
      .._substitution = s
      ..unifiable = u;
  }
  SplayTreeMap<IdKey, Substitution>? _substitution;

  SplayTreeMap<IdKey, Substitution>? get substitution => _substitution;

  set substitution(SplayTreeMap<IdKey, Substitution>? substitution) {
    _substitution = substitution;
  }

  bool? unifiable = false;
}
