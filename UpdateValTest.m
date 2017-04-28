function UpdateValTest(handles)   %,handles2 - for simulating in GUI2
global t;
global v_val;
global x_val;
global a_val;
global v0;
global x0;
global tspan;
global time;
global uval;
global level;
global u;

%initialize value of Train model
tspan = linspace(0,1,100);
v0 = 0;
x0 = 0;
v_val = [];
x_val = [];
a_val = [];
uval = 0;
% u=[(0:0.1:1),0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,(0.8:-0.2:0)]*100000;
u = [(0:0.1:1),0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.7,0.7,0.7,0.6,0.6,0.5,0.5,0.3,0.3,0.3,0.3,0.3,0.3,0.2,0.2,0.2,0.1,0.1,0.1,0.1,0,0,0,0,0,0,0,-0.2,-0.2,-0.2,-0.2,-0.2,-0.2,-0.2,-0.3]*100000;
% level = [0 0 1 1 2 3 3 3 3 5 5 6 6 7 7 8 9 9 9 8 8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -2 -2 -3 -3 -4 -4 -5 -5 -5 -5 -5 -5 -5 -6 -6 -6 -7 -7 -7 -7 -8 -8 -8 0]*10000;   %test value
time = 1;

t = timer;
% t.TimerFcn = @(~,evt) DisplayValTest(handles,handles2);

t.TimerFcn = @(~,evt) DiffEqTrainModel(handles);       %,handles2 - for simulating in GUI2
t.Period = 1;
t.ExecutionMode = 'fixedRate';
start(t)