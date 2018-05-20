function varargout = table_main(varargin)
% GUITABLE MATLAB code for guitable.fig
%      GUITABLE, by itself, creates a new GUITABLE or raises the existing
%      singleton*.
%
%      H = GUITABLE returns the handle to a new GUITABLE or the handle to
%      the existing singleton*.
%
%      GUITABLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUITABLE.M with the given input arguments.
%
%      GUITABLE('Property','Value',...) creates a new GUITABLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guitable_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guitable_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guitable

% Last Modified by GUIDE v2.5 10-Jul-2013 13:21:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @table_main_OpeningFcn, ...
                   'gui_OutputFcn',  @table_main_OutputFcn, ...
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


% --- Executes just before guitable is made visible.
function table_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guitable (see VARARGIN)

% Choose default command line output for guitable
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guitable wait for user response (see UIRESUME)
% uiwait(handles.table_main);


% --- Outputs from this function are returned to the command line.
function varargout = table_main_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function menu_file_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_open_Callback(hObject, eventdata, handles)
% hObject    handle to menu_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tabledata = get(handles.data_table,'Data');
rowname = get(handles.data_table,'RowName');
columnname = get(handles.data_table,'ColumnName');
global spec wave label

%[fname, dpath, findex] = uiputfile('*.csv');
[fname, dpath, findex] = uigetfile('*.*');
if findex~=0 
    fpath = fullfile(dpath, fname);

    %importing only numerical text or csv data
    if ~isempty(strfind(fpath, '.txt')) || isempty(strfind(fpath, '.csv'))
        data = importdata(fpath);
        wave = data(1,2:end);
        spec = data(2:end,2:end);
        label = data(2:end,1);
    
    end
    
    %importing JCAMP-DX file
    if ~isempty(strfind(fpath, '.dx'))
        [label, wave, spec] = importDX(fpath);
    end
else
    disp('The file does not exist.');
end;

set(handles.data_table,'Data',spec);
set(handles.data_table,'Rowname',label);
set(handles.data_table,'ColumnName',wave);

% Update handles structure
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_edit_Callback(hObject, eventdata, handles)
% hObject    handle to menu_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_plot_Callback(hObject, eventdata, handles)
% hObject    handle to menu_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_line_Callback(hObject, eventdata, handles)
% hObject    handle to menu_line (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global spec wave

figure;
plot(wave,spec);
axis tight;


% --------------------------------------------------------------------
function menu_task_Callback(hObject, eventdata, handles)
% hObject    handle to menu_task (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in data_table.
function data_table_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to data_table (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_transform_Callback(hObject, eventdata, handles)
% hObject    handle to menu_transform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_secondderivative_Callback(hObject, eventdata, handles)
% hObject    handle to menu_secondderivative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wave label spec
dialog_sgder2(wave, label, spec);

% --------------------------------------------------------------------
function menu_snv_Callback(hObject, eventdata, handles)
% hObject    handle to menu_snv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wave label spec
table_snv(wave, label, spec);



% --------------------------------------------------------------------
function menu_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to menu_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_pca_Callback(hObject, eventdata, handles)
% hObject    handle to menu_pca (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Call the dialog to change button name giving this figure's handle
global label wave spec 
dialog_pca(label, wave, spec);


% --------------------------------------------------------------------
function menu_plsr_Callback(hObject, eventdata, handles)
% hObject    handle to menu_plsr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tabledata = get(handles.data_table,'Data');
rowname = get(handles.data_table,'RowName');
columnname = get(handles.data_table,'ColumnName');


tabledata = uiimport('-file');
fieldname = fieldnames(tabledata);
data = getfield(tabledata,fieldname{1,1});

global spec wave label

wave = data(1,2:end);
spec = data(2:end,2:end);
label = data(2:end,1);



set(handles.data_table,'Data',spec);
set(handles.data_table,'Rowname',label);
set(handles.data_table,'ColumnName',wave);

% Update handles structure
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_reverse_Callback(hObject, eventdata, handles)
% hObject    handle to menu_reverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function menu_reverse_sample_Callback(hObject, eventdata, handles)
% hObject    handle to menu_reverse_sample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global spec label

label = flipud(label);
spec = flipud(spec);

set(handles.data_table,'Data',spec);
set(handles.data_table,'Rowname',label);


% --------------------------------------------------------------------
function manu_reverse_variable_Callback(hObject, eventdata, handles)
% hObject    handle to manu_reverse_variable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global spec wave

wave = fliplr(wave);
spec = fliplr(spec);

set(handles.data_table,'Data',spec);
set(handles.data_table,'ColumnName',wave);


% --------------------------------------------------------------------
function menu_spectraldatatransform_Callback(hObject, eventdata, handles)
% hObject    handle to menu_spectraldatatransform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global spec
spec = log(1./spec);
set(handles.data_table,'Data',spec);