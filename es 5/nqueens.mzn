include "gecode.mzn";
include "alldifferent.mzn";

int: n; % Number of queens
array [1..n] of var 1..n: X; % Variables for queens on the rows (or columns)

var int: total_distance = sum([abs(i-X[i])|i in 1..n]);

constraint alldifferent(X)::domain;
constraint alldifferent([X[i]+i | i in 1..n])::domain;
constraint alldifferent([X[i]-i | i in 1..n])::domain;

%default search
%solve minimize total_distance;

%domWdeg – random value
%solve :: int_search(X,dom_w_deg,indomain_random) minimize total_distance;

%domWdeg – random value + restart
%solve :: int_search(X,dom_w_deg,indomain_random)
%      :: restart_luby(250) minimize total_distance;

%domWdeg – random value + restart + LNS
solve :: int_search(X,dom_w_deg,indomain_random)
      :: restart_luby(250) :: relax_and_reconstruct(X,85) minimize total_distance;

output[show(total_distance)];