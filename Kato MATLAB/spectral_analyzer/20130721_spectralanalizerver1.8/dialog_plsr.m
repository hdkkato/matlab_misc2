function varargout = dialog_plsr(varargin)
% DIALOG_plsr MATLAB code for dialog_plsr.fig
%      DIALOG_plsr, by itself, creates a new DIALOG_plsr or raises the existing
%      singleton*.
%
%      H = DIALOG_plsr returns the handle to a new DIALOG_plsr or the handle to
%      the existing singleton*.
%
%      DIALOG_plsr('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIALOG_plsr.M with the given input arguments.
%
%      DIALOG_plsr('Property','Value',...) creates a new DIALOG_plsr or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sgder2_dialog_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sgder2_dialog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dialog_plsr

% Last Modified by GUIDE v2.5 11-Jul-2013 11:32:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dialog_plsr_OpeningFcn, ...
                   'gui_OutputFcn',  @dialog_plsr_OutputFcn, ...
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


% --- Executes just before dialog_plsr is made visible.
function dialog_plsr_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dialog_plsr (see VARARGIN)

handles.label = varargin{1};
handles.wave = varargin{2};
handles.spec = varargin{3};

if length(varargin) > 3
    handles.ref = varargin{4};
end

handles.maxlvnum = 5;

if length(varargin) > 4
   handles.maxlvnum = varargin{5};
end

% Update handles structure
guidata(hObject, handles);

uiwait(handles.dialog_plsr)

% UIWAIT makes dialog_plsr wait for user response (see UIRESUME)
% uiwait(handles.dialog_plsr);


% --- Outputs from this function are returned to the command line.
function varargout = dialog_plsr_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = [];

delete(hObject);

% --- Executes during object creation, after setting all properties.
function dialog_plsr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editChangeMe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Update handles structure
guidata(hObject, handles);


function maxlvnum_Callback(hObject, eventdata, handles)
% hObject    handle to maxlvnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(hObject,'String'));
handles.maxlvnum = val;

% Update handles structure
guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of maxlvnum as text
%        str2double(get(hObject,'String')) returns contents of maxlvnum as a double


% --- Executes during object creation, after setting all properties.
function maxlvnum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxlvnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plsr_run.
function plsr_run_Callback(hObject, eventdata, handles)
% hObject    handle to plsr_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fmax = handles.maxlvnum;

[Result,Y1] = plsr(handles.spec, handles.ref,fmax);


% Update handles structure
guidata(hObject, handles);

uiresume(handles.dialog_plsr);


% --- Executes on button press in plsr_buttoncancel.
function plsr_buttoncancel_Callback(hObject, eventdata, handles)
% hObject    handle to plsr_buttoncancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.dialog_plsr);

function dialog_plsr_CloseRequestFcn(hObject,eventdata,handles)
% hObject    handle to plsr_buttoncancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%uiresume(dialog_plsr);
uiresume(hObject);


% --- Executes on button press in pushbutton_openreffernce.
function pushbutton_openreffernce_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_openreffernce (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname, dpath, findex] = uigetfile('*.*');
if findex~=0 
    fpath = fullfile(dpath, fname);

    %importing only numerical text or csv data
    if isempty(strfind(fpath, '.txt')) || isempty(strfind(fpath, '.csv'))
        handles.ref = importdata(fpath);
        
    end
    
else
    disp('The file does not exist.');
end;

% Update handles structure
guidata(hObject, handles);