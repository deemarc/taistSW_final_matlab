function StatusTrainDisplay(handles)
global u;
global time;
global distance;
global v0;
%Tracking status 
set(handles.Track1,'BackgroundColor','green');
set(handles.Track2,'BackgroundColor','green');
set(handles.Track3,'BackgroundColor','green');

%Lamp/Air/Door status
clc;
disp(sprintf('TestUpdate : %d \n',time));
disp(sprintf('Lamp Status = %s | %s | %s \n',handles.Lamp1Button.String,handles.Lamp2Button.String,handles.Lamp3Button.String));
disp(sprintf('Air Status     = %s | %s | %s \n',handles.Air1Button.String,handles.Air2Button.String,handles.Air3Button.String));
disp(sprintf('Door Status  = %s | %s | %s \n',handles.Door1Button.String,handles.PassengerDoorButton.String,handles.PassengerDoorButton.String));
disp(sprintf('=> distance in 1 sec : %d m',round(distance)));
disp(sprintf('=> Acceleration level : %d || velocity = %d km/hr ',u(time)/10000,round(v0*3.6)));

    set(handles.RemainBlocks,'string',num2str(length(u) - time));    
    set(handles.NextStation,'string','Harajuku Station');
    
    if time == 3*length(u)/4 -10
        set(handles.TrafficLight1,'BackgroundColor','black');
        set(handles.TrafficLight2,'BackgroundColor','black');
        set(handles.TrafficLight3,'BackgroundColor','yellow');
        set(handles.TrafficLight4,'BackgroundColor','black');
        set(handles.Alarm1,'BackgroundColor','red');
    elseif time == 3*length(u)/4
        set(handles.TrafficLight1,'BackgroundColor','yellow');
        set(handles.TrafficLight2,'BackgroundColor','black');
        set(handles.TrafficLight3,'BackgroundColor','yellow');
        set(handles.TrafficLight4,'BackgroundColor','black');
        set(handles.Alarm1,'BackgroundColor','black');
    elseif time == length(u)-1
        set(handles.TrafficLight1,'BackgroundColor','black');
        set(handles.TrafficLight2,'BackgroundColor','black');
        set(handles.TrafficLight3,'BackgroundColor','black');
        set(handles.TrafficLight4,'BackgroundColor','red');
    elseif time < 3*length(u)/4 -10
        set(handles.TrafficLight1,'BackgroundColor','black');
        set(handles.TrafficLight2,'BackgroundColor','green');
        set(handles.TrafficLight3,'BackgroundColor','black');
        set(handles.TrafficLight4,'BackgroundColor','black');
    end
    
    
    