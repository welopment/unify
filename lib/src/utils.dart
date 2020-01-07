part of unify;

/// factory-like functions, for public use

/// constructs terms [Compound]
Compound f(int c, int i, List<Term> l) => Compound(c, i, l);
Compound c(int c, int i, List<Term> l) => Compound(c, i, l);
/// constructs variables [Variable]
Variable v(int c, int i) => Variable(c, i);

/// constructs variables [Variable]
Number n(int c, int i, num n) => Number(c, i, n);

/// constructs variables [Variable]
Atom a(int c, int i, String s) => Atom(c, i, s);
