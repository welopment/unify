Unify
=====

An implementation of Ruzicka und Privara' algorithm of logical unification for dart and flutter.

This algorithm is an optimization of the algorithm by Corbin und Bidoit, which itself is based on Robinson's algorithmus.

Robinson's algorithm is inefficient if subterms are contained in several locations of a term tree, leading to unnecessary calculations. Ruzicka und Privara's algorithm takes the structure of terms into account by using directed acyclic graphs instead of the original term trees to avoid unnecessary calculations.

Ideally, in this reduced DAG all equal subterms are represented by one identical subgraph.

Additionally, the occurs check is executed after the actual unification as search for cylces in the resulting DAG.

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

# Example:

```dart
 import 'package:unify/unify.dart';

void main() {
  

  // occurs check positive:

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
  print('\nterm1      > ' + term1.toString());
  print('\nterm2      > ' + term2.toString());
  
  bool res = mgu(term1, term2);
  
  print('\nunifiable  > ' + res.toString());
  print('\nterm1      > ' + term1.toString());
  print('\nterm2      > ' + term2.toString());

}
```













