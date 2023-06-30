%  Created on: 28/06/2023
%      Author: j-Lago
%
function varargout = foto(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @foto_OpeningFcn, ...
                   'gui_OutputFcn',  @foto_OutputFcn, ...
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


% --- Executes just before foto is made visible.
function foto_OpeningFcn(hObject, eventdata, handles, varargin)


% Choose default command line output for foto
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using foto.
if strcmp(get(hObject,'Visible'),'off')
    plot(rand(5));
end

axes(handles.axes3);
cla;
plot(0,0)

global arranjo_gui; arranjo_gui = ArranjoGUI( 2, 1, 1, 1, 29, 62, 44, 45);

global sombra; sombra = [ .0 .0 .0 ;
                          .0 .0 .0 ;
                          .0 .0 .0 ;
                          .0 .0 .0 ];
global dtemp; dtemp   = [ .0 .0 .0 ;
                          .0 .0 .0 ;
                          .0 .0 .0 ;
                          .0 .0 .0 ];          
config(hObject, eventdata, handles)

% UIWAIT makes foto wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = foto_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)

file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)

printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)

selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)

plot_refresh(hObject, eventdata, handles);


% --- Executes on slider movement.
function vmppt_Callback(hObject, eventdata, handles)
plot_refresh(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function vmppt_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function vinvref_Callback(hObject, eventdata, handles)
plot_refresh(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function vinvref_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor', [.9 .9 .9]);
end


% --- Executes on mouse press over axes background.
function axes2_ButtonDownFcn(hObject, eventdata, handles)

plot_refresh(hObject, eventdata, handles);


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)

coord = get(hObject, 'CurrentPoint')
plot_refresh(hObject, eventdata, handles);



function s1_Callback(hObject, eventdata, handles)
plot_refresh(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function s1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s2_Callback(hObject, eventdata, handles)
plot_refresh(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function s2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s3_Callback(hObject, eventdata, handles)
plot_refresh(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function s3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function deltaref_Callback(hObject, eventdata, handles)
plot_refresh(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function deltaref_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function psun_Callback(hObject, eventdata, handles)
plot_refresh(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function psun_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function tamb_Callback(hObject, eventdata, handles)
plot_refresh(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function tamb_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function irrad_per_Callback(hObject, eventdata, handles)

global arranjo_gui
global sombra

if arranjo_gui.sel(1) > 0 && arranjo_gui.sel(2) > 0
    sombra(arranjo_gui.sel(1), arranjo_gui.sel(2)) = get(hObject,'Value');
end
plot_refresh(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function irrad_per_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in flag_manual.
function flag_manual_Callback(hObject, eventdata, handles)
plot_refresh(hObject, eventdata, handles);


% --- Executes on button press in bypass.
function bypass_Callback(hObject, eventdata, handles)
config(hObject, eventdata, handles);


% --- Executes on button press in blocking.
function blocking_Callback(hObject, eventdata, handles)
config(hObject, eventdata, handles);


% --- Executes on button press in show_paineis.
function show_paineis_Callback(hObject, eventdata, handles)
plot_refresh(hObject, eventdata, handles);


% --- Executes on button press in show_string.
function show_string_Callback(hObject, eventdata, handles)
plot_refresh(hObject, eventdata, handles);


% --- Executes on slider movement.
function dtemp_Callback(hObject, eventdata, handles)
global arranjo_gui
global dtemp

if arranjo_gui.sel(1) > 0 && arranjo_gui.sel(2) > 0
    dtemp(arranjo_gui.sel(1), arranjo_gui.sel(2)) = get(hObject,'Value');
end
plot_refresh(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function dtemp_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dtemp_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function dtemp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dtemp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
plot_refresh(hObject, eventdata, handles);
