part of unify;

// TODO
class Argument extends Term {
  /// not for public use
  Argument(int clause, int id) : super(clause, id);
}

// TODO
class InArgument extends Argument {
  /// not for public use
  InArgument(int clause, int id) : super(clause, id);
}

// TODO
class OutArgument extends Argument {
  /// not for public use
  OutArgument(int clause, int id) : super(clause, id);
}
