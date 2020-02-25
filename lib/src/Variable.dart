part of unify;

/// A logical [Variable].
class Variable extends Term {
  /// Variables with the same [clause] and [id] represent the same object.
  /// Better use the utility function [v] to construct a Variable.
  Variable(int clause, int id) : super(clause, id);

  ///
  @override
  String toString() {
    return 'Variable'
        '${clause.toString()}.${id.toString()}';
  }

  /// Equality of [Variable]s requires [clause] and [id] to be equal
  @override
  bool operator ==(dynamic other) {
    if (other is Compound) {
      // 1.
      var equalclauses = clause == other.clause;

      // 2.
      var equalnames = id == other.id;

      // 1. ^ 2.
      return equalclauses && equalnames;
    } else {
      return false;
    }
  }
}
