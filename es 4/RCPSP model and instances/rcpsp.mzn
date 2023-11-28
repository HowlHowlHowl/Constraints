include "globals.mzn";

int: n_tasks;   % Number of tasks
set of int: TASKS = 1..n_tasks;  
array[TASKS] of int: duration; % Task durations

int: n_res;   % Number of resources
set of int: RESOURCES = 1..n_res; 
array[RESOURCES] of int: L; % Resource capacities
array[RESOURCES,TASKS] of int: req; %Resource requirements of tasks

int: p;       % Number of precedence relations
set of int: PREC = 1..p;
array[PREC,1..2] of TASKS: pre; % Precedence relations

%Total time required for the exec of all tasks
int: total_time_req = sum(duration);

%Array for the starts
array[TASKS] of var 0..total_time_req: start;

constraint forall(i in PREC)
  % a.start + a.duration <= b.start
  (start[pre[i,1]] + duration[pre[i,1]] <= start[pre[i,2]]);
  
constraint forall(i in RESOURCES)
  (cumulative(
    start, 
    duration, 
    [req[i,j]|j in TASKS],  %For each resource, for each task, resource requirement
    L[i]  %limit of capacity for each resource
    )
  );
  
%default search - Minimize the maximum Si + di
%solve minimize max([start[i] + duration[i] | i in TASKS]);

solve::int_search(start, smallest, indomain_min) 
        minimize max([start[i]+ duration[i] | i in TASKS]);


output[ 
  "Starts: ", show(start), "\n",
  "Total Duration: ", show(max([start[i] + duration[i] | i in TASKS]))
]
