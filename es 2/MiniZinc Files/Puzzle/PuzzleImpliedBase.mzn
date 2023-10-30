int: n;
array[0..n-1] of var 0..n-1: X;

% meta constraint
constraint forall(i in 0..n-1) (X[i] = ( sum(j in 0..n-1)(X[j]=i) ) );

% the second implied constraint
constraint sum(i in 0..n-1)(X[i]*i) = n;

solve satisfy;

output [ "x = \(X);\n" ] ;

