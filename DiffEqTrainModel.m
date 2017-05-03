function DiffEqTrainModel(handles)    %,handles2 - for simulating in GUI2
global time;        %% the OUTPUT
global u;
global v_val;
global x_val;
global v0;          %% the OUTPUT
global x0;          %% the OUTPUT
global tspan;
global t;
global Totaltime;
global distance;
global ip;

handles.NextStation.String = getDestination(ip,handles.TrainSelect.Value);
%handles.RemainBlocks.String = num2str(getRemainBlocks(handles.TrainSelect.Value));

%% Loop
if time <= length(u)
% Get u
uval=u(time);                                                                   % in N

% Solve for v
v=ode45(@(t,v)trainModel(t,v,uval),tspan,v0);
vval=v.y;                                                                       % in m/s

for i=1:length(vval)

            %limit velocity
        if vval(i) < 0.5/3.6
            vval(i) = 0;
        elseif vval(i) > 130/3.6
            vval(i) = 130/3.6;
        end
        
    % Solve for x
    x=ode45(@(t,y) trainModeldx(t,y,vval(i)),v.x,x0);
    xval=x.y;                                                                   % in m
    xvalDivLgth=xval/length(vval);                                              % in m

    % Concatenate x
    x_val=[x_val,xvalDivLgth];
    
    % Update x0
    x0=xval(end);                                                               %%% show this value as the latest value in UI
end

% Concatenate v
v_val=[v_val,vval];

% Update v0
v0=vval(end);                                                                   %%% show this value as the latest value in UI

Totaltime=length(u);                                         % in s
timev=0:    (Totaltime)/(length(v_val)-1):    Totaltime;     % in s
timex=0:    (Totaltime)/(length(x_val)-1):    Totaltime;     % in s

%optional
% distance = mean(v_val)*time ;                    % in m
distance = v0;                            %m in 1s
updateDistance(ip,handles.TrainSelect.Value,round(distance));
    %Display value in GUI handles
    set(handles.AccelerationVal,'string',num2str(u(time)/10000));
    set(handles.VelocityVal,'string',num2str(v0*3.6));

%     %%Plot v
%     figure(1),subplot(1,2,1),plot(timev,v_val);
%     ylabel('velocity(m/s)')
% 
%     %hold off;
%     xlabel('time(s)')
% 
%     %%Plot x
%     figure(1),subplot(1,2,2),plot(timex,x_val);
%     xlabel('time(s)')
%     ylabel('distance(m)')

    StatusTrainDisplay(handles)                             %display status train in GUI
%     SimulationTrain(handles,handles2,time);      %display simulation results in another GUI
    
    time = time +1;  
end