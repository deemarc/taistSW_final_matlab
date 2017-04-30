global u;
global state;
global v_val;
global x_val;
global v0;
global x0;
global tspan;
global time;
global Totaltime;
global distance;

%initialize value
time = 1;
tspan = linspace(0,1,100);
v0 = 0;
x0 = 0;
v_val = [];
x_val = [];
state =1;
u=[(0:0.1:1),(0.8:-0.2:0)]*100000;

t = timer;
% t.TimerFcn = @(~,evt) DiffEqTrainModel;
t.TimerFcn = @(~,evt) DiffEqTrainModel;
t.Period = 1;
t.ExecutionMode = 'fixedRate';
start(t)