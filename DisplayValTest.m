function DisplayValTest(handles)
global time;
global level ;
global v_val;
global x_val;
global a_val;
global v0;
global x0;
global tspan;
global t;
global uval
ip = '192.168.137.90';
handles.NextStation.String = getDestination(ip,handles.TrainSelect.Value);
%handles.RemainBlocks.String = num2str(getRemainBlocks(handles.TrainSelect.Value));


set(handles.Track1,'BackgroundColor','green');
set(handles.Track2,'BackgroundColor','green');
set(handles.Track3,'BackgroundColor','green');

%Lamp/Air/Door status
clc;
disp(sprintf('TestUpdate : %d \n',time));
disp(sprintf('Lamp Status = %s | %s | %s \n',handles.Lamp1Button.String,handles.Lamp2Button.String,handles.Lamp3Button.String));
disp(sprintf('Air Status     = %s | %s | %s \n',handles.Air1Button.String,handles.Air2Button.String,handles.Air3Button.String));
disp(sprintf('Door Status  = %s | %s | %s \n',handles.Door1Button.String,handles.PassengerDoorButton.String,handles.PassengerDoorButton.String));

% simulate acc. level 
if time <= length(level) 

    a_val = [a_val level(time)];
    
    uval = uval + level(time)*2;    
    if uval < 0
        uval = 0;
    elseif uval > 150
        uval = 150;
    end

    %solve for velocity 
    v = ode45(@(t,y) trainModel(t,y,uval), tspan, v0 );          
    velocity= v.y;

    %solve for dx 
    for j = 1:length(velocity)
        d = ode45(@(t,y) trainModeldx(t,y,velocity(j)), v.x, x0 ); 
        dx = d.y;
        x0 = dx(end);   
        x_val = [x_val dx];                 
    end

    v0 = velocity(end);                %update  v0
    v_val = [v_val velocity];         %concatenate 
        
    % limit velocity
    if v0 < 1
        v0 = 0;
    elseif v0 >149
        v0 = 150;
    end
    
    set(handles.AccelerationVal,'string',num2str(level(time)));
    set(handles.VelocityVal,'string',num2str(v0));
    disp(sprintf('=> Acceleration level : %d || velocity = %d ',level(time),v0));

%     figure(1),subplot(1,3,1),scatter(1:time,a_val),title('Acceleration');
%     figure(1),subplot(1,3,2),plot(v_val),title('Velocity');
%     figure(1),subplot(1,3,3),plot(x_val),title('Distance');
%     hold on;
        
%     set(handles.RemainBlocks,'string',num2str(length(level) - time));
%     set(handles.NextStation,'string','Tokyo Station');

    if time == 36
        set(handles.TrafficLight1,'BackgroundColor','black');
        set(handles.TrafficLight2,'BackgroundColor','black');
        set(handles.TrafficLight3,'BackgroundColor','yellow');
        set(handles.TrafficLight4,'BackgroundColor','black');
        set(handles.Alarm1,'BackgroundColor','red');
    elseif time == 40
        set(handles.TrafficLight1,'BackgroundColor','yellow');
        set(handles.TrafficLight2,'BackgroundColor','black');
        set(handles.TrafficLight3,'BackgroundColor','yellow');
        set(handles.TrafficLight4,'BackgroundColor','black');
        set(handles.Alarm1,'BackgroundColor','black');
    elseif time == length(level)
        set(handles.TrafficLight1,'BackgroundColor','black');
        set(handles.TrafficLight2,'BackgroundColor','black');
        set(handles.TrafficLight3,'BackgroundColor','black');
        set(handles.TrafficLight4,'BackgroundColor','red');
    elseif time < 36
        set(handles.TrafficLight1,'BackgroundColor','black');
        set(handles.TrafficLight2,'BackgroundColor','green');
        set(handles.TrafficLight3,'BackgroundColor','black');
        set(handles.TrafficLight4,'BackgroundColor','black');
    end

end

time = time +1;  

