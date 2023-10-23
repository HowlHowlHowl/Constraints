int: n; % Number of queens
array [1..n] of var 1..n: q; % Variables for queens on the rows (or columns)

% Column attack constraints using the alldifferent constraint.
% Append ::domain to the end.  
%constraint alldifferent(q)::domain;
constraint forall(i, j in 1..n where i < j)(q[i] != q[j]);

constraint forall(i, j in 1..n where i < j)(
  q[i] + i != q[j] + j
);

constraint forall(i, j in 1..n where i < j)(
  q[i] - i != q[j] - j
);

% Search for all solutions, using N = 8, 9, 10, and 12.
solve satisfy;