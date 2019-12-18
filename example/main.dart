import 'package:unify/unify.dart';

//void unify(  _TT s,  _TT t)

void main() {
  //

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
  //
  print('voher');
  print('term1 > ' + term1.toString());
  print('term2 > ' + term2.toString());
  print('\nnachher');

  bool res = mgu(term1, term2);

  print('term1 > ' + term1.toString());
  print('term2 > ' + term2.toString());

  /*
  Result res1 = unify(term1, term2);
  print('unifiable > ' + res1.unifiable.toString());
  print('term1 > ' + res1.term1.toString());
  print('term2 > ' + res1.term2.toString());
  */
}
