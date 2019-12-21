import 'package:unify/unify.dart';

//void unify(  _TT s,  _TT t)

void main() {
  //
/*
  var term1 = t(1, 1, [
    v(1, 2),
    v(1, 2),
  ]);
  //
  var term2 = t(2, 1, [
    v(2, 2),
    t(2, 3, [
      v(2, 22),
    ]),
  ]);
  */
  //
  /*
  _T term1 = t(1, 1, [
    v(1, 2),
  ]);
  //
  _T term2 = t(2, 1, [
    t(2, 3, []),
  ]);
   */
  /*
  //
  print('voher');
  print('\nterm1 > ' + term1.toString());
  print('\nterm2 > ' + term2.toString());
  print('\nnachher');

  bool res = mgu(term1, term2);
  print('\nmgu  > ' + res.toString());
  print('\nterm1 > ' + term1.toString());
  print('\nterm2 > ' + term2.toString());
 */
  /*
  Result res1 = unify(term1, term2);
  print('unifiable > ' + res1.unifiable.toString());
  print('term1 > ' + res1.term1.toString());
  print('term2 > ' + res1.term2.toString());
  */

  testUnify();
}

Result testUnify() {
  var term1 = t(1, 1, [
    v(1, 2),
    v(1, 2),
  ]);
  //
  var term2 = t(2, 1, [
    v(2, 2),
    t(2, 3, [
      v(2, 2),
    ]),
  ]);

  //bool uni = mgu(term1, term2);
  //throw Exception(' end main ');

  var t1 = (term1); // copy
  var t2 = (term2);
  bool unifiable = mgu(term1, term2);

  bool occurs1 = t1.occurs;
  bool occurs2 = t2.occurs;

  if (occurs1 || occurs2) {
    throw Exception('unify: occurs');
  }

  bool notOccursS = !occurs1;
  bool notOccursT = !occurs2;
  bool goAhead = notOccursS && notOccursT && unifiable;

  if (goAhead) {
    // t1.substitute;
    //t2.substitute;
    return Result((t1), (t2), unifiable);
  } else {
    throw Exception('unify: not unifiable');
  }
}
