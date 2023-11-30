include "globals.mzn";

int: M;     %number of machines = number of tasks
int: J;     %number of jobs
set of int: MACH = 1..M;
set of int: TASK = 1..M; 
set of int: JOB = 1..J;
array[JOB,TASK] of MACH: machine;    % machine[j, i] required from task i of job j
array[JOB,MACH] of int: duration;     % duration[j, i] of job j on machine i


int: total_duration = sum(duration);
array[JOB,TASK] of var 0..total_duration: start;


var 0..total_duration: makespan;

%per ogni lavoro, per ogni task
constraint forall(j in JOB)
  %k=t=m
  (forall(k in 1..M-1)
    % L'inizio del task k del job j
    % + la durata del job j, usando la macchina giusta <= start della prossima task  
    (start[j, k] + duration[j, machine[j, k]] <= start[j, k+1])
    % l'inizio e la durata dell'ultimo task di j deve essere <= del makespan 
    /\ start[j, M] + duration[j, machine[j, M]] <= makespan
  );
%Per ogni macchina
constraint forall(m in MACH) (
%Requires that a set of tasks given by start times s and durations d do not overlap in time. Tasks with duration 0 can be scheduled at any time, even in the middle of other tasks.   
  %l'inizio di ogni task su quella macchina non deve overlap
  disjunctive(
    [start[j,k] | j in JOB, k in TASK where machine[j,k]=m],
    [duration[j,m] | j in JOB])
);


solve minimize makespan;