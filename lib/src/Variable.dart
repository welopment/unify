part of unify;


/// Variable Variable
class Variable extends Term {
  /// not for public use in
  Variable(int clause, int id) : super(clause, id);

  ///
  @override
  String toString() {
    return 'Variable'
        '${clause.toString()}.${id.toString()}';
  }

  /// equality requires same [clause] and [id]
  @override
  bool operator ==(dynamic other) {
    if (other is Compound) {
      /// 1.
      var equalclauses = clause == other.clause;

      /// 2.
      var equalnames = id == other.id;

      /// 1. ^ 2. ^ 3.
      return equalclauses && equalnames;
    } else {
      return false;
    }
  }
}
