part of unify;

/// An atomic formula is a formula with no deeper propositional structure,
/// that is, a formula that contains no logical connectives or equivalently
/// a formula that has no strict subformulas.
/// Atoms are thus the simplest well-formed formulas of the logic.
class Atom extends Constant<String> {
  /// Better use the utility function [a] to construct a number.
  Atom(int clause, int id, String s)
      : _s = s,
        super(clause, id, s);
  final String _s;

  @override
  String get value => _s;

  ///
  @override
  String toString() {
    return 'Atom'
        '${clause.toString()}.${id.toString()}[$value]';
  }

  /// Equality fo [Atom]s requires [values] to be equal.
  @override
  bool operator ==(dynamic other) {
    if (other is Atom) {
      var equalvalues = value == other.value;

      return equalvalues;
    } else {
      return false;
    }
  }
}
