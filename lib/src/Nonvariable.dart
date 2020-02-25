part of unify;

/// This is the Superclass of [Constant] and [Compound].
/// NonVariable is used as identifier to avoid the name clash
/// with [Constant]. You will not want to use this directly in your code.
class NonVariable extends Term {
  /// You will not want to use this directly in your code.
  NonVariable(int clause, int id) : super(clause, id);
}
