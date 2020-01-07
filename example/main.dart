import 'package:unify/unify.dart';

void main() {
  var t1 = f(1, 1, [v(1, 2), v(1, 2)]);
  var t2 = f(2, 1, [
    f(2, 2, [v(2, 3)]),
    v(2, 4) // circularity v(2, 3)
  ]);
  var t3 = v(1, 2);
  var t4 = v(2, 1);
  var t5 = f(1, 1, [
    v(1, 2),
    v(1, 2),
    v(1, 3),
    f(1, 4, [
      f(1, 5, [v(1, 3)])
    ]),
    v(1, 3),
  ]);
  var t6 = f(2, 1, [
    f(2, 2, [v(2, 3), n(2, 7, 1.4324), a(2, 8, 'zwei acht')]),
    v(2, 4),
    v(2, 3),
    v(2, 5),
    v(2, 4),
  ]);

//
  var t7 = f(1, 1, [
    v(1, 2),
    v(1, 2),
  ]);
  var t8 = f(2, 1, [
    v(2, 2),
    f(2, 3, [
      v(2, 4), //  circularity: v(2, 2)
    ]),
  ]);

  //
  var t9 = f(3, 1, [
    v(3, 3),
    v(3, 2),
    v(3, 2),
    v(3, 3),
    v(3, 4),
    v(3, 4),
  ]);
  //
  var t10 = f(4, 1, [
    v(4, 6),
    v(4, 2),
    f(4, 3, [
      v(4, 4),
    ]),
    v(4, 5),
    v(4, 2),
    v(4, 6),
  ]);

  unify(t1, t2);
  unify(t3, t4);
  unify(t5, t6);
  unify(t7, t8);
  unify(t9, t10);
}

void unify(t1, t2) {
  var b = Bindings.empty();
  print('-------------------');
  print('Term 1 $t1.');
  print('Term 2 $t2.');
  mgu(t1, t2, b); // side effect on b
  print(b);
  var o1 = t1.occurs(b);
  print('Occurs check for term 1 ${o1}');
  var o2 = t2.occurs(b);
  print('Occurs check for term 2 ${o2}.');
  if (!o1 && !o2) {
    var u1 = t1.substitute(b);
    print('Unified term 1 ${u1}');
    var u2 = t2.substitute(b);
    print('Unified term 2 ${u2}');
  }
}
