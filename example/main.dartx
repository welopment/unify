import 'package:unify/unify.dart';

void main() {
  // Clause 1
  var term1 = t(1, 1, [
    v(1, 2),
    v(1, 2),
  ]);
  // Clause 2
  var term2 = t(2, 1, [
    v(2, 2),
    t(2, 3, [
      v(2, 4), // circularity: v(2, 2)
    ]),
  ]);

  // Always use different numbers for differents clauses!
  // Clause 3
  //var term3 =
  t(3, 1, [
    v(3, 3),
    v(3, 2),
    v(3, 2),
    v(3, 3),
    v(3, 4),
    v(3, 4),
  ]);
  // Clause 4
  //var term4 =
  t(4, 1, [
    v(4, 6),
    v(4, 2),
    t(4, 3, [
      v(4, 4),
    ]),
    v(4, 5),
    v(4, 2),
    v(4, 6),
  ]);

  // unification modifies terms!
  print('unifiable: ' + mgu(term1, term2).toString());
  //
  print('term1    : ' + term1.toString());
  print('term2    : ' + term2.toString());
  //
  print('term1    : ' + term1.substitute.toString());
  print('term2    : ' + term2.substitute.toString());
}
