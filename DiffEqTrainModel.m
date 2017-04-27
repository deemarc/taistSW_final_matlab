function DiffEqTrainModel
global time;        %% the OUTPUT
global u ;
global v_val;
global x_val;
global v0;          %% the OUTPUT
global x0;          %% the OUTPUT
global tspan;
global t;


%% Loop

% Get u
uval=u(time);                                                                   % in N

% Solve for v
v=ode45(@(t,v)trainModel(t,v,uval),tspan,v0);
vval=v.y;                                                                       % in m/s

for i=1:length(vval)
    % Solve for x
    x=ode45(@(t,y) trainModelX(t,y,vval(i)),v.x,x0);
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
distance = mean(v_val)*Totaltime;                      % in m

%hold on;

%%Plot v
subplot(1,2,1),plot(timev,v_val);
xlabel('time(s)')
ylabel('velocity(m/s)')

hold off;

%%Plot x
subplot(1,2,2),plot(timex,x_val);
xlabel('time(s)')
ylabel('distance(m)')



if time == length(u) 
    stop(t);
else
    time = time +1;  
end