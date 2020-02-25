Unify
=====

An implementation of Ruzicka und Privara's algorithm of logical unification for dart and flutter.

This algorithm is an optimization of Corbin and Bidoit's algorithm, which itself is based on Robinson's well known algorithm available as 'package:unification'.

Robinson's algorithm is inefficient if the same subterm is given in several locations of a term, leading to unnecessarily repeated calculations. Ruzicka und Privara's algorithm takes the structure of the term into account by using a directed acyclic graph [DAG] instead of the original term tree to avoid such unnecessarily repeated calculations. Ideally, in this reduced DAG all equal subterms are represented by one identical subgraph, i.e. one and the same term object.

The current implementation is an approximation of Ruzicka und Privara's algorithm. 

# Getting started

Add the dependency to your pubspec.yaml file:

```yaml
dependencies:
  unify: #latest version
```

Add the import statement to your source files:

```dart
 import 'package:unify/unify.dart';
```

Or, give it a try and run the example:

```dart
dart ./example/main.dart 
```

Modify the example to test more complex tasks!

# Examples:

```dart
 import 'package:unify/unify.dart';

// set up the unification procedure
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

// run some examples
void main() {
  // Always use different numbers for differents clauses!

  //1. 
  var t1 = t(1, 1, [v(1, 2), v(1, 2)]);
  var t2 = t(2, 1, [
    t(2, 2, [v(2, 3)]),
    v(2, 3) // no circularity v(2, 4)
  ]);
  unify(t1, t2);

  //2. 
  var t3 = v(1, 2);
  var t4 = v(2, 1);
  unify(t3, t4);

  //3. 
  var t5 = t(1, 1, [
    v(1, 2),
    v(1, 2),
    v(1, 3),
    t(1, 4, [
      t(1, 5, [v(1, 3)])
    ]),
    v(1, 3),
  ]);
  var t6 = t(2, 1, [
    t(2, 2, [v(2, 3)]),
    v(2, 4),
    v(2, 3),
    v(2, 5),
    v(2, 4),
  ]);
  unify(t5, t6);

  //4. 
  var t7 = t(1, 1, [
    v(1, 2),
    v(1, 2),
  ]);
  var t8 = t(2, 1, [
    v(2, 2),
    t(2, 3, [
      v(2, 4), //  circularity: v(2, 2)
    ]),
  ]);
  unify(t7, t8);

  //5. 
  var t9 = t(3, 1, [
    v(3, 3),
    v(3, 2),
    v(3, 2),
    v(3, 3),
    v(3, 4),
    v(3, 4),
  ]);
  var t10 = t(4, 1, [
    v(4, 6),
    v(4, 2),
    t(4, 3, [
      v(4, 4),
    ]),
    v(4, 5),
    v(4, 2),
    v(4, 6),
  ]);
  unify(t9, t10);
}
```