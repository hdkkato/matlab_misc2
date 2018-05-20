function varargout = MyPicture(varargin)
% MYPICTURE MATLAB code for MyPicture.fig
%      MYPICTURE, by itself, creates a new MYPICTURE or raises the existing
%      singleton*.
%
%      H = MYPICTURE returns the handle to a new MYPICTURE or the handle to
%      the existing singleton*.
%
%      MYPICTURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYPICTURE.M with the given input arguments.
%
%      MYPICTURE('Property','Value',...) creates a new MYPICTURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MyPicture_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MyPicture_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MyPicture

% Last Modified by GUIDE v2.5 16-Apr-2013 17:49:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MyPicture_OpeningFcn, ...
                   'gui_OutputFcn',  @MyPicture_OutputFcn, ...
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


% --- Executes just before MyPicture is made visible.
function MyPicture_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MyPicture (see VARARGIN)

% Choose default command line output for MyPicture
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MyPicture wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MyPicture_OutputFcn(hObject, eventdata, handles) 
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




% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename = uigetfile('*.jpg','Select an image file');
im = imread(filename);

handles.im = im;


% Update handles structure
guidata(hObject, handles);
imagesc(im);
