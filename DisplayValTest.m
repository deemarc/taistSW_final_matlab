function DisplayValTest(handles)
global TestUpdate
TestUpdate = TestUpdate + 1;
if TestUpdate == 8
    TestUpdate = 1;
end

set(handles.Track1,'BackgroundColor','green');
set(handles.Track2,'BackgroundColor','green');
set(handles.Track3,'BackgroundColor','green');

clc;
disp(sprintf('TestUpdate : %d \n',TestUpdate));
disp(sprintf('Lamp Status = %s | %s | %s \n',handles.Lamp1Button.String,handles.Lamp2Button.String,handles.Lamp3Button.String));
disp(sprintf('Air Status     = %s | %s | %s \n',handles.Air1Button.String,handles.Air2Button.String,handles.Air3Button.String));
disp(sprintf('Door Status  = %s | %s | %s \n',handles.Door1Button.String,handles.Door2Button.String,handles.Door3Button.String));

if TestUpdate == 5
    set(handles.TrafficLight1,'BackgroundColor','black');
    set(handles.TrafficLight2,'BackgroundColor','black');
    set(handles.TrafficLight3,'BackgroundColor','yellow');
    set(handles.TrafficLight4,'BackgroundColor','black');
    set(handles.Alarm1,'BackgroundColor','red');
elseif TestUpdate == 6
    set(handles.TrafficLight1,'BackgroundColor','yellow');
    set(handles.TrafficLight2,'BackgroundColor','black');
    set(handles.TrafficLight3,'BackgroundColor','yellow');
    set(handles.TrafficLight4,'BackgroundColor','black');
    set(handles.Alarm1,'BackgroundColor','black');
elseif TestUpdate == 7
    set(handles.TrafficLight1,'BackgroundColor','black');
    set(handles.TrafficLight2,'BackgroundColor','black');
    set(handles.TrafficLight3,'BackgroundColor','black');
    set(handles.TrafficLight4,'BackgroundColor','red');
else
    set(handles.TrafficLight1,'BackgroundColor','black');
    set(handles.TrafficLight2,'BackgroundColor','green');
    set(handles.TrafficLight3,'BackgroundColor','black');
    set(handles.TrafficLight4,'BackgroundColor','black');
end
