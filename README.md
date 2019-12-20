Unification
===========

A library providing implementations of first-order logical unification for dart and flutter.

# Getting started

Add the dependency to your pubspec.yaml file:

```yaml
dependencies:
  unification: #latest version
```

Add the import statement to your source files:

```dart
import 'package:unification/unification.dart';
```

Or, give it a try and run the example:

```dart
dart ./example/main.dart 
```

Modify the example to test more less simple tasks!

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

[Read more](https://en.wikipedia.org/wiki/Unification) 
about unification in logic on Wikipedia.











