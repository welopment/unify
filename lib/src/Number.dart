part of unify;

///
class Number extends Constant<num> {
  /// Better use the utility function [n] to construct a number.
  Number(int clause, int id, num n)
      : _n = n,
        super(clause, id, n);
  final num _n;

  @override
  num get value => _n;

  ///
  @override
  String toString() {
    return 'Number'
        '${clause.toString()}.${id.toString()}[$value]';
  }

  /// Equality of numbers requires [value]s to be equal.
  @override
  bool operator ==(dynamic other) {
    if (other is Number) {
      var equalvalues = value == other.value;

      return equalvalues;
    } else {
      return false;
    }
  }
}
