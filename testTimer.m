stopglobal sharedVar;
sharedVar=0;

t=timer;
%t.TimerFcn=@(~,evt) disp('Aha');
t.TimerFcn=@(~,evt) timerFcn;
t.Period=0.2;
t.ExecutionMode='fixedRate';
%t.TasksToExecute=2;
start(t)

%stop(t)