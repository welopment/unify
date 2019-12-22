part of unify;

/// factory constructor-like functions, made public

/// constructs terms [_T]
_T t(int c, int i, List<_TT> l) => _T.unique(c, i, l);

/// constructs variables [_V]
_V v(int c, int i) => _V.unique(c, i);
