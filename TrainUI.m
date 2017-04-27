function varargout = TrainUI(varargin)
% TRAINUI MATLAB code for TrainUI.fig
%      TRAINUI, by itself, creates a new TRAINUI or raises the existing
%      singleton*.
%
%      H = TRAINUI returns the handle to a new TRAINUI or the handle to
%      the existing singleton*.
%
%      TRAINUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRAINUI.M with the given input arguments.
%
%      TRAINUI('Property','Value',...) creates a new TRAINUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TrainUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TrainUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TrainUI

% Last Modified by GUIDE v2.5 27-Apr-2017 11:12:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TrainUI_OpeningFcn, ...
                   'gui_OutputFcn',  @TrainUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before TrainUI is made visible.
function TrainUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TrainUI (see VARARGIN)

% Choose default command line output for TrainUI
handles.output = hObject;

%opening
% Train Images
trainimg1 = imread('Train1.png');
axes(handles.Train1Image); 
imshow(trainimg1);
trainimg2 = imread('Train2.png');
axes(handles.Train2Image); 
imshow(trainimg2);
trainimg3 = imread('Train2.png');
axes(handles.Train3Image); 
imshow(trainimg3);
trainimg4 = imread('TrafficLightImage.png');
axes(handles.TrafficLightImage); 
imshow(trainimg4);

%defalt text at buttons
set(handles.Lamp1Button,'string','Lamp1 OFF','enable','on','BackgroundColor',[0.94 0.94 0.94]);
set(handles.Lamp2Button,'string','Lamp2 OFF','enable','on','BackgroundColor',[0.94 0.94 0.94]);
set(handles.Lamp3Button,'string','Lamp3 OFF','enable','on','BackgroundColor',[0.94 0.94 0.94]);
set(handles.Air1Button,'string','Air1 OFF','enable','on','BackgroundColor',[0.94 0.94 0.94]);
set(handles.Air2Button,'string','Air2 OFF','enable','on','BackgroundColor',[0.94 0.94 0.94]);
set(handles.Air3Button,'string','Air3 OFF','enable','on','BackgroundColor',[0.94 0.94 0.94]);
set(handles.Door1Button,'string','Door1 OFF','enable','on','BackgroundColor',[0.94 0.94 0.94]);
set(handles.PassengerDoorButton,'string','Door OFF','enable','on','BackgroundColor',[0.94 0.94 0.94]);
% set(handles.PassengerDoorText,'string','Door2,3','enable','on','BackgroundColor',[0.94 0.94 0.94]);
% set(handles.Door3Button,'string','Door2 OFF','enable','on','BackgroundColor',[0.94 0.94 0.94]);
%defalt start toggle button
set(handles.StartButton,'string',' Start','enable','on','BackgroundColor',[0.94 0.94 0.94]);
%defalt alarm LED
set(handles.Alarm1,'BackgroundColor','black');
set(handles.Alarm2,'BackgroundColor','black');
set(handles.Alarm3,'BackgroundColor','black');
%defalt rail traffic light
set(handles.TrafficLight1,'BackgroundColor','black');
set(handles.TrafficLight2,'BackgroundColor','black');
set(handles.TrafficLight3,'BackgroundColor','black');
set(handles.TrafficLight4,'BackgroundColor','red');

global StartStatus;
StartStatus = 0;

% select train
dropdownTxt = {'Select Train','Narita Line','Yamanote Line'};
set(handles.TrainSelect,'string',dropdownTxt);                      % to update the popup menu items

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TrainUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TrainUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Lamp1Button.
function Lamp1Button_Callback(hObject, eventdata, handles)
% hObject    handle to Lamp1Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Lamp1Button
global StartStatus;

Lamp1Status = get(hObject,'Value'); 

if StartStatus == 1
    if Lamp1Status == 1 
        set(handles.Lamp1Button,'string',' Lamp1 ON','enable','on','BackgroundColor','green');
    elseif Lamp1Status == 0 
        set(handles.Lamp1Button,'string','Lamp1 OFF','enable','on','BackgroundColor',[0.94 0.94 0.94]);
    end
else
    msgbox(sprintf('Please choose train and press start'),'ERROR','ERROR');
end

% --- Executes on button press in Air1Button.
function Air1Button_Callback(hObject, eventdata, handles)
% hObject    handle to Air1Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global StartStatus;
Air1Status = get(hObject,'Value'); 

if StartStatus == 1
    if Air1Status == 1 
        set(handles.Air1Button,'string',' Air1 ON','enable','on','BackgroundColor','green');
    elseif Air1Status == 0 
        set(handles.Air1Button,'string','Air1 OFF','enable','on','BackgroundColor',[0.94 0.94 0.94]);
    end
else
    msgbox(sprintf('Please choose train and press start'),'ERROR','ERROR');
end

% --- Executes on button press in Door1Button.
function Door1Button_Callback(hObject, eventdata, handles)
% hObject    handle to Door1Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global StartStatus;
Door1Status = get(hObject,'Value'); 

if StartStatus == 1
    if Door1Status == 1 
        set(handles.Door1Button,'string',' Door1 ON','enable','on','BackgroundColor','green');
    elseif Door1Status == 0 
        set(handles.Door1Button,'string','Door1 OFF','enable','on','BackgroundColor',[0.94 0.94 0.94]);
    end
else
    msgbox(sprintf('Please choose train and press start'),'ERROR','ERROR');
end

% --- Executes on button press in Lamp2Button.
function Lamp2Button_Callback(hObject, eventdata, handles)
% hObject    handle to Lamp2Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global StartStatus;
Lamp2Status = get(hObject,'Value'); 

if StartStatus == 1
    if Lamp2Status == 1 
        set(handles.Lamp2Button,'string',' Lamp2 ON','enable','on','BackgroundColor','green');
    elseif Lamp2Status == 0 
        set(handles.Lamp2Button,'string','Lamp2 OFF','enable','on','BackgroundColor',[0.94 0.94 0.94]);
    end
else
    msgbox(sprintf('Please choose train and press start'),'ERROR','ERROR');
end

% --- Executes on button press in Air2Button.
function Air2Button_Callback(hObject, eventdata, handles)
% hObject    handle to Air2Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Air2Button
global StartStatus;
Air2Status = get(hObject,'Value'); 

if StartStatus == 1
    if Air2Status == 1 
        set(handles.Air2Button,'string',' Air2 ON','enable','on','BackgroundColor','green');
    elseif Air2Status == 0 
        set(handles.Air2Button,'string','Air2 OFF','enable','on','BackgroundColor',[0.94 0.94 0.94]);
    end
else
    msgbox(sprintf('Please choose train and press start'),'ERROR','ERROR');
end

% --- Executes on button press in PassengerDoorButton.
function PassengerDoorButton_Callback(hObject, eventdata, handles)
% hObject    handle to PassengerDoorButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global StartStatus;
Door2Status = get(hObject,'Value'); 

if StartStatus == 1
    if Door2Status == 1 
        set(handles.PassengerDoorButton,'string','Door ON','enable','on','BackgroundColor','green');
        set(handles.PassengerDoorText,'string','Passenger','enable','on','BackgroundColor','green');
    elseif Door2Status == 0 
        set(handles.PassengerDoorButton,'string','Door OFF','enable','on','BackgroundColor',[0.94 0.94 0.94]);
        set(handles.PassengerDoorText,'string','Passenger','enable','on','BackgroundColor',[0.94 0.94 0.94]);
    end
else
    msgbox(sprintf('Please choose train and press start'),'ERROR','ERROR');
end

% --- Executes on button press in Lamp3Button.
function Lamp3Button_Callback(hObject, eventdata, handles)
% hObject    handle to Lamp3Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global StartStatus;
Lamp3Status = get(hObject,'Value'); 

if StartStatus == 1
    if Lamp3Status == 1 
        set(handles.Lamp3Button,'string',' Lamp3 ON','enable','on','BackgroundColor','green');
    elseif Lamp3Status == 0 
        set(handles.Lamp3Button,'string','Lamp3 OFF','enable','on','BackgroundColor',[0.94 0.94 0.94]);
    end
else
    msgbox(sprintf('Please choose train and press start'),'ERROR','ERROR');
end

% --- Executes on button press in Air3Button.
function Air3Button_Callback(hObject, eventdata, handles)
% hObject    handle to Air3Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global StartStatus;
Air3Status = get(hObject,'Value'); 

if StartStatus == 1
    if Air3Status == 1 
        set(handles.Air3Button,'string',' Air3 ON','enable','on','BackgroundColor','green');
    elseif Air3Status == 0 
        set(handles.Air3Button,'string','Air3 OFF','enable','on','BackgroundColor',[0.94 0.94 0.94]);
    end
else
    msgbox(sprintf('Please choose train and press start'),'ERROR','ERROR');
end

% % --- Executes on button press in Door3Button.
% function Door3Button_Callback(hObject, eventdata, handles)
% % hObject    handle to Door3Button (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% global StartStatus;
% Door3Status = get(hObject,'Value'); 
% 
% if StartStatus == 1
%     if Door3Status == 1 
%         set(handles.Door3Button,'string',' Door3 ON','enable','on','BackgroundColor','green');
%     elseif Door3Status == 0 
%         set(handles.Door3Button,'string','Door3 OFF','enable','on','BackgroundColor',[0.94 0.94 0.94]);
%     end
% else
%     msgbox(sprintf('Please choose train and press start'),'ERROR','ERROR');
% end


% --- Executes on selection change in TrainSelect.
function TrainSelect_Callback(hObject, eventdata, handles)
% hObject    handle to TrainSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TrainSelect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TrainSelect

%selection
global StartStatus
global TrainRoute
if (handles.TrainSelect.Value == 2 || handles.TrainSelect.Value == 3) && StartStatus == 1
    msgbox(sprintf('You cannot change train at this time'),'ERROR','ERROR');
    handles.TrainSelect.Value = TrainRoute;
else
    TrainRoute = handles.TrainSelect.Value;
end


% --- Executes during object creation, after setting all properties.
function TrainSelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TrainSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in StartButton.
function StartButton_Callback(hObject, eventdata, handles)
% hObject    handle to StartButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of StartButton
global StartStatus;
global t;
global TestUpdate;    
TestUpdate = 0;

%No selection
if handles.TrainSelect.Value == 1
    disp('Select Train');
    msgbox(sprintf('Please choose train before press start'),'ERROR','ERROR');
    set(handles.StartButton,'value',0);
    
%Nariata Line
elseif handles.TrainSelect.Value == 2
       
    StartStatus = get(hObject,'Value');
    if StartStatus == 1
        disp('Narita Line');
        UpdateValTest(handles);     %test update values        
        set(handles.StartButton,'string',' Start','enable','on','BackgroundColor','green');
    else
        stop(t);
        set(handles.StartButton,'string',' Start','enable','on','BackgroundColor',[0.94 0.94 0.94]);
    end
    
%Yamanote Line    
elseif handles.TrainSelect.Value == 3
       
    StartStatus = get(hObject,'Value');
    if StartStatus == 1
        disp('Yamanote Line');
        UpdateValTest(handles);
        set(handles.StartButton,'string',' Start','enable','on','BackgroundColor','green');
    else
        stop(t);
        set(handles.StartButton,'string',' Start','enable','on','BackgroundColor',[0.94 0.94 0.94]);
    end

end
