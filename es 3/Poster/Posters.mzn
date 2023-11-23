%global model
include "diffn.mzn";

par int: n; %number of posters
par int: w; %width of paper
par int: h; %height of paper

array[1..n] of par int: ws; %widths of posters
array[1..n] of par int: hs; %heights of posters

% left bottom corner of each poster
array[1..n] of var 0..w-min(ws): x; 
array[1..n] of var 0..h-min(hs): y;

%to not exceed the paper roll limit
constraint forall(i in 1..n) (x[i] + ws[i] <= w);
constraint forall(i in 1..n) (y[i] + hs[i] <= h);

%to avoid posters overlapping
constraint diffn(x,y,ws,hs);

%to concatenate x and y arrays
array[1..2*n] of var int: all_vars;
constraint forall (i in 1..n)(
  (all_vars[2*i-1] = x[i])/\(all_vars[2*i] = y[i])
);

solve :: int_search(all_vars, input_order, indomain_min) satisfy;

%solve :: int_search(all_vars, input_order, indomain_random) satisfy;

%solve :: int_search(all_vars, first_fail, indomain_min) satisfy;

%solve :: int_search(all_vars, first_fail, indomain_random) satisfy;

%solve :: int_search(all_vars, dom_w_deg, indomain_min) satisfy;

%solve :: int_search(all_vars, dom_w_deg, indomain_random) satisfy;


