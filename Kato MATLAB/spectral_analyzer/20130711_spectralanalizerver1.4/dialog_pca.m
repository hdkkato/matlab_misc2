function varargout = dialog_pca(varargin)
% DIALOG_PCA MATLAB code for dialog_pca.fig
%      DIALOG_PCA, by itself, creates a new DIALOG_PCA or raises the existing
%      singleton*.
%
%      H = DIALOG_PCA returns the handle to a new DIALOG_PCA or the handle to
%      the existing singleton*.
%
%      DIALOG_PCA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIALOG_PCA.M with the given input arguments.
%
%      DIALOG_PCA('Property','Value',...) creates a new DIALOG_PCA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sgder2_dialog_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sgder2_dialog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dialog_pca

% Last Modified by GUIDE v2.5 08-Jul-2013 10:40:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dialog_pca_OpeningFcn, ...
                   'gui_OutputFcn',  @dialog_pca_OutputFcn, ...
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


% --- Executes just before dialog_pca is made visible.
function dialog_pca_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dialog_pca (see VARARGIN)
handles.maxpcnum = 5;
handles.label = varargin{1};
handles.wave = varargin{2};
handles.spec = varargin{3};

% Update handles structure
guidata(hObject, handles);

uiwait(handles.dialog_pca)

% UIWAIT makes dialog_pca wait for user response (see UIRESUME)
% uiwait(handles.dialog_pca);


% --- Outputs from this function are returned to the command line.
function varargout = dialog_pca_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = [];

delete(hObject);

% --- Executes during object creation, after setting all properties.
function dialog_pca_CreateFcn(hObject, eventdata, handles)
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


function maxpcnum_Callback(hObject, eventdata, handles)
% hObject    handle to maxpcnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(hObject,'String'));
handles.maxpcnum = val;

% Update handles structure
guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of maxpcnum as text
%        str2double(get(hObject,'String')) returns contents of maxpcnum as a double


% --- Executes during object creation, after setting all properties.
function maxpcnum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxpcnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pca_run.
function pca_run_Callback(hObject, eventdata, handles)
% hObject    handle to pca_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fmax = handles.maxpcnum;

[T, P, tau] = PCANIPALS(handles.spec,fmax);

figure;
plot(handles.wave,P);
figure;
plot(handles.label,T);

% Update handles structure
guidata(hObject, handles);

uiresume(handles.dialog_pca);


% --- Executes on button press in pca_buttoncancel.
function pca_buttoncancel_Callback(hObject, eventdata, handles)
% hObject    handle to pca_buttoncancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.dialog_pca);

function dialog_pca_CloseRequestFcn(hObject,eventdata,handles)
% hObject    handle to pca_buttoncancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%uiresume(dialog_pca);
uiresume(hObject);
