function varargout = SliderSample(varargin)
% SLIDERSAMPLE MATLAB code for SliderSample.fig
%      SLIDERSAMPLE, by itself, creates a new SLIDERSAMPLE or raises the existing
%      singleton*.
%
%      H = SLIDERSAMPLE returns the handle to a new SLIDERSAMPLE or the handle to
%      the existing singleton*.
%
%      SLIDERSAMPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SLIDERSAMPLE.M with the given input arguments.
%
%      SLIDERSAMPLE('Property','Value',...) creates a new SLIDERSAMPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SliderSample_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SliderSample_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SliderSample

% Last Modified by GUIDE v2.5 13-Sep-2010 17:33:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SliderSample_OpeningFcn, ...
                   'gui_OutputFcn',  @SliderSample_OutputFcn, ...
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


% --- Executes just before SliderSample is made visible.
function SliderSample_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SliderSample (see VARARGIN)

% Choose default command line output for SliderSample
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SliderSample wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SliderSample_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% マウスの位置を取得
P=get(hObject,'CurrentPoint');
% スライドの範囲を取得
SliderP = get(handles.slider1,'Position');
% マウスの位置がスライドの範囲に入ればスライドの値を使ってグラフを表示
if P(1)>SliderP(1) && P(1)<SliderP(1)+SliderP(3) && P(2)>SliderP(2) && P(2)<SliderP(2)+SliderP(4)
    AA=get(handles.slider1,'Value');
    bar(AA),axis on
    xlim([0 2])
    ylim([0 1])

end