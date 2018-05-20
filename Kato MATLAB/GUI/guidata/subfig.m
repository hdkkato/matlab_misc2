function varargout = subfig(varargin)
% SUBFIG M-file for subfig.fig
%      SUBFIG, by itself, creates a new SUBFIG or raises the existing
%      singleton*.
%
%      H = SUBFIG returns the handle to a new SUBFIG or the handle to
%      the existing singleton*.
%
%      SUBFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SUBFIG.M with the given input arguments.
%
%      SUBFIG('Property','Value',...) creates a new SUBFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before subfig_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to subfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help subfig

% Last Modified by GUIDE v2.5 07-Jun-2006 11:35:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @subfig_OpeningFcn, ...
                   'gui_OutputFcn',  @subfig_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before subfig is made visible.
function subfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to subfig (see VARARGIN)

%%%%%% 方法1 %%%%%
data1 = varargin{1};
data2 = varargin{2};
%%%%%% 方法1 %%%%%

%%%%%% 方法2 %%%%%
% グローバル変数の定義
% global data1 data2
%%%%%% 方法2 %%%%%

%%%%%% 方法3 %%%%%
% ベースワークスペースの値をローカルワークスペースに定義
% data1 = evalin('base','data1_base');
% data2 = evalin('base','data2_base');
%%%%%% 方法3 %%%%%

data = data1+data2;
% 変数dataをhandles構造体へ保存
handles.data = data;

% Choose default command line output for subfig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes subfig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = subfig_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% handles構造体からデータを取得
data = handles.data;
% エディットテキスト上に変数dataを表示
set(handles.edit1,'string',num2str(data))

