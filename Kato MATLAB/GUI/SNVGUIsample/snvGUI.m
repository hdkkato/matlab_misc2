function varargout = snvGUI(varargin)
% SNVGUI MATLAB code for snvGUI.fig
%      SNVGUI, by itself, creates a new SNVGUI or raises the existing
%      singleton*.
%
%      H = SNVGUI returns the handle to a new SNVGUI or the handle to
%      the existing singleton*.
%
%      SNVGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SNVGUI.M with the given input arguments.
%
%      SNVGUI('Property','Value',...) creates a new SNVGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before snvGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to snvGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help snvGUI

% Last Modified by GUIDE v2.5 10-May-2013 17:11:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @snvGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @snvGUI_OutputFcn, ...
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


% --- Executes just before snvGUI is made visible.
function snvGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to snvGUI (see VARARGIN)

% Choose default command line output for snvGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes snvGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = snvGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in getfile.
function getfile_Callback(hObject, eventdata, handles)
% hObject    handle to getfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject, handles);

data = uiimport('-file');


data = translength(data.data);
w = data(1,:);
x = data(2:end,:);

handles.wave = w;
handles.spec = x;

%Plot original spectra
axes(handles.original_axes);
plot(w, x);
axis(handles.original_axes, 'tight')

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in snv.
function snv_Callback(hObject, eventdata, handles)
% hObject    handle to snv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

w = handles.wave;
x = handles.spec;


xsnv = snv(x);
axes(handles.snv_axes);

%Plot SNV-treated spectra
plot(w, xsnv);
axis(handles.snv_axes, 'tight');

% Update handles structure
guidata(hObject, handles);

