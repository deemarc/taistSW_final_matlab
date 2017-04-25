function UpdateValTest(handles)
global t;
t = timer;
t.TimerFcn = @(~,evt) DisplayValTest(handles);
t.Period = 2;
t.ExecutionMode = 'fixedRate';
start(t)