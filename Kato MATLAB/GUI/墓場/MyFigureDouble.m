function varargout = MyFigureDouble(varargin)
% MYFIGUREDOUBLE MATLAB code for MyFigureDouble.fig
%      MYFIGUREDOUBLE, by itself, creates a new MYFIGUREDOUBLE or raises the existing
%      singleton*.
%
%      H = MYFIGUREDOUBLE returns the handle to a new MYFIGUREDOUBLE or the handle to
%      the existing singleton*.
%
%      MYFIGUREDOUBLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYFIGUREDOUBLE.M with the given input arguments.
%
%      MYFIGUREDOUBLE('Property','Value',...) creates a new MYFIGUREDOUBLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MyFigureDouble_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MyFigureDouble_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MyFigureDouble

% Last Modified by GUIDE v2.5 10-May-2013 15:00:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MyFigureDouble_OpeningFcn, ...
                   'gui_OutputFcn',  @MyFigureDouble_OutputFcn, ...
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


% --- Executes just before MyFigureDouble is made visible.
function MyFigureDouble_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MyFigureDouble (see VARARGIN)

% Choose default command line output for MyFigureDouble
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MyFigureDouble wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MyFigureDouble_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename = uigetfile('*.jpg','Select an image file');
im = imread(filename);

handles.im = im;


% Update handles structure
guidata(hObject, handles);
axes(handles.picture_axes);
image(handles.im);




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname, dpath, findex] = uigetfile('*.mat');
if findex~=0 
    fpath = fullfile(dpath, fname);
    load(fpath);
else 
    disp('ファイルがありません。');
end;

data = load(fpath);
handles.data = data;

% Update handles structure
guidata(hObject, handles);
axes(handles.figure_axes);
plot(handles.data.W, handles.data.X);
