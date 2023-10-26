int: n;
array[0..n-1] of var 0..n-1: X;

% meta constraint
constraint forall(i in 0..n-1) (X[i] = ( sum(j in 0..n-1)(X[j]=i) ) );

solve satisfy;

output [ "x = \(X);\n" ] ;