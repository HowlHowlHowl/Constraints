%Naive model

%include "19x19.dzn";
include "20x20.dzn";
 
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

%to avoid posters overlapping: la posizione iniziale di uno + la sua  dimensione (in x o y) non devono toccare la posizione inziale di nessun altro (eccetto se stesso ovviamente)
constraint forall(i,j in 1..n where i < j)
  (
    (x[i]+ws[i]<=x[j]) \/ 
    (x[j]+ws[j]<=x[i]) \/ 
    (y[i]+hs[i]<=y[j]) \/ 
    (y[j]+hs[j]<=y[i])
  );
    
solve satisfy;