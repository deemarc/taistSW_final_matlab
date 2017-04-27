
%%prepare data
% velocity
v0=0;                                                                           % in m/s
tspan=linspace(0,1,100);                                                        % in 1 s????
%tspan=0:1:563647;    
%u=[(0:0.1:1),(0.8:-0.2:0)];
u=[(0:0.1:1),0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,(0.8:-0.2:0)]*100000;       % in N ( eg. to move 127005.864 RAILROAD CAR we use 1245.5 N when The coefficient of rolling friction for a wheel-rail interface is approximately 0.001, while the coefficient of static friction for a steel-on-steel interface is approximately 0.5.)
%u=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
val=[];

% distance
x0=0;                                                                           % in m
%u2=val;
val2=[];

%% Loop
for i=1:length(u)
    % Get u
    uval=u(i);
    
    % Solve for v
    v=ode45(@(t,v)trainModel(t,v,uval),tspan,v0);
    vval=v.y;                                                                   % in m/s
    
    %%%test
    %vval=[0 1 2 3 4 5 6 7 8 9 10];
    
    for i2=1:length(vval)
        % Get u
        uval2=vval(i2);

        % Solve for x
        x=ode45(@(t,y) trainModelX(t,y,uval2),v.x,x0);
        xval=x.y;                                                                   % in m
        xvalDivLgth=xval/length(vval);                                              % in m
        
        % Concatenate x
        val2=[val2,xvalDivLgth];     

        % Update x0
        x0=xval(end);
    end
    
    % Concatenate v
    val=[val,vval];                                                             
    
    % Update v0
    v0=vval(end);
end

time=length(u);                                 % in s
timev=0:    (time)/(length(val)-1):   time;     % in s
timex=0:    (time)/(length(val2)-1):  time;     % in s

%optional
distance = mean(val)*time;                      % in m

%%Plot v
subplot(1,2,1),plot(timev,val);
xlabel('time(s)')
ylabel('velocity(m/s)')
%%Plot x
subplot(1,2,2),plot(timex,val2);
xlabel('time(s)')
ylabel('distance(m)')