include "global_cardinality.mzn";

int: n;
array[0..n-1] of var 0..n-1: X;

% meta constraint
constraint global_cardinality(X, 0..n-1, [X[i] | i in 0..n-1]);
% the second implied constraint
constraint sum(i in 0..n-1)(X[i]*i) = n;

solve satisfy;

output [ "x = \(X);\n" ] ;