part of unify1;

class Substitution {
  /// nicht direkt verwenden
  Substitution(int uni) : _unique = uni;

  ///
  factory Substitution.bound(_T s) {
    Substitution._uni++;

    return Substitution(_uni).._substitution = s;
  }

  ///
  factory Substitution.free() {
    Substitution._uni++;

    return Substitution(_uni);
  }

  ///
  static int _uni = 0;
  int _unique;

  ///
  _T? _substitution;

  _T? get substitution => _substitution;

  set substitution(_T? substitution) {
    _substitution = substitution;
  }
}
