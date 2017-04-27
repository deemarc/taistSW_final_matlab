function UpdateValTest(handles)
global t;
global v_val;
global x_val;
global a_val;
global v0;
global x0;
global tspan;
global time;
global uval;
global level

%initialize value of Train model
tspan = linspace(0,1,100);
v0 = 0;
x0 = 0;
v_val = [];
x_val = [];
a_val = [];
uval = 0;
level = [0 0 1 1 2 3 3 3 3 5 5 6 6 7 7 8 9 9 9 8 8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -2 -2 -3 -3 -4 -4 -5 -5 -5 -6 -6 -6 -7 -7 -7 -7 -8 -8 0];   %test value
time = 1;

t = timer;
t.TimerFcn = @(~,evt) DisplayValTest(handles);

% t.TimerFcn = @(~,evt) DiffEqTrainModel(handles);
t.Period = 1;
t.ExecutionMode = 'fixedRate';
start(t)