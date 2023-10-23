% Alldifferent model

include "alldifferent.mzn";
include "lex_lesseq.mzn";

int: n; % Number of queens
array [1..n] of var 1..n: q; % Variables for queens on the rows (or columns)

% Column attack constraints using the alldifferent constraint.
% Append ::domain to the end.  
constraint alldifferent(q)::domain;
constraint alldifferent([ q[i] + i | i in 1..n ])::domain;
constraint alldifferent([ q[i] - i | i in 1..n ])::domain;
% Search for all solutions, using N = 8, 9, 10, and 12.
constraint symmetry_breaking_constraint(
  let { 
    array[1..n,1..n] of var bool: B; 
  } in
      % Channeling constraint
      forall (i,j in 1..n) ( B[i,j] <-> (q[i]=j) )
      % Lexicographic symmetry breaking constraints
  /\  lex_lesseq(array1d(B), [ B[j,i] | i,j in 1..n ])
  /\  lex_lesseq(array1d(B), [ B[i,j] | i in reverse(1..n), j in 1..n ])
  /\  lex_lesseq(array1d(B), [ B[j,i] | i in 1..n, j in reverse(1..n) ])
  /\  lex_lesseq(array1d(B), [ B[i,j] | i in 1..n, j in reverse(1..n) ])
  /\  lex_lesseq(array1d(B), [ B[j,i] | i in reverse(1..n), j in 1..n ])
  /\  lex_lesseq(array1d(B), [ B[i,j] | i,j in reverse(1..n) ])
  /\  lex_lesseq(array1d(B), [ B[j,i] | i,j in reverse(1..n) ])
);
solve satisfy;