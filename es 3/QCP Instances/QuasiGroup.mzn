include "alldifferent.mzn";

par int: N;
set of int: PuzzleRange = 1..N;

array[1..N,1..N] of 0..N: start; 
array[1..N,1..N] of var PuzzleRange: puzzle;

% fill initial board
constraint forall(i,j in PuzzleRange)(
    if start[i,j] > 0 then puzzle[i,j] = start[i,j] else true endif );

% All different in rows 
constraint forall (i in PuzzleRange) (
   alldifferent(
    [ puzzle[i,j] | j in PuzzleRange ]
   )::domain
); 

% All different in columns.
constraint forall (j in PuzzleRange) (
   alldifferent(
     [ puzzle[i,j] | i in PuzzleRange ]
   )::domain
); 

%solve satisfy;
%solve :: int_search(puzzle, dom_w_deg, indomain_random) satisfy;
solve::int_search(puzzle, dom_w_deg, indomain_random)::restart_luby(250) satisfy;
