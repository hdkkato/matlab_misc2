function varargout = table_snv(varargin)
% TABLE_SNV MATLAB code for table_snv.fig
%      TABLE_SNV, by itself, creates a new TABLE_SNV or raises the existing
%      singleton*.
%
%      H = TABLE_SNV returns the handle to a new TABLE_SNV or the handle to
%      the existing singleton*.
%
%      TABLE_SNV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TABLE_SNV.M with the given input arguments.
%
%      TABLE_SNV('Property','Value',...) creates a new TABLE_SNV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before table_snv_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to table_snv_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help table_snv

% Last Modified by GUIDE v2.5 10-Jul-2013 17:19:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @table_snv_OpeningFcn, ...
                   'gui_OutputFcn',  @table_snv_OutputFcn, ...
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


% --- Executes just before table_snv is made visible.
function table_snv_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to table_snv (see VARARGIN)

locwave = varargin{1};
loclabel = varargin{2};
locspec = varargin{3};

spec_snv = snv(locspec);

handles.wave = locwave;
handles.label = loclabel;
handles.spec_snv = spec_snv;

tabledata = get(handles.table_snv,'Data');
rowname = get(handles.table_snv,'RowName');
columnname = get(handles.table_snv,'ColumnName');

set(handles.table_snv,'Data',spec_snv);
set(handles.table_snv,'Rowname',loclabel);
set(handles.table_snv,'ColumnName',locwave);

% Choose default command line output for table_snv
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes table_snv wait for user response (see UIRESUME)
% uiwait(handles.figure_snv);


% --- Outputs from this function are returned to the command line.
function varargout = table_snv_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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

figure;
plot(handles.wave,handles.spec_snv);
axis tight;


% --------------------------------------------------------------------
function menu_task_Callback(hObject, eventdata, handles)
% hObject    handle to menu_task (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_pca_Callback(hObject, eventdata, handles)
% hObject    handle to menu_pca (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dialog_pca(handles.label, handles.wave, handles.spec_snv);


% --------------------------------------------------------------------
function uipushtool_save_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

locwave = handles.wave;
loclabel = handles.label;
spec_snv = handles.spec_snv;

loclabel = [NaN; loclabel];
data = [locwave; spec_snv];
data = [loclabel, data];

% setting the path and name of SNV-treated spectra
[fname, dpath, findex] = uiputfile('*.csv');
if findex~=0 
    fpath = fullfile(dpath, fname);

%saving the spectra in designated directory
    cd(dpath);
    dlmwrite(fname, data, 'precision', 16, 'delimiter', ',');
else 
    disp('The file does not exist.');
end;
