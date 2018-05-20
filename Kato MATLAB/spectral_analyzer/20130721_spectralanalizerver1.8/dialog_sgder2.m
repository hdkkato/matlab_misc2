function varargout = dialog_sgder2(varargin)
% SGDER2_DIALOG MATLAB code for sgder2_dialog.fig
%      SGDER2_DIALOG, by itself, creates a new SGDER2_DIALOG or raises the existing
%      singleton*.
%
%      H = SGDER2_DIALOG returns the handle to a new SGDER2_DIALOG or the handle to
%      the existing singleton*.
%
%      SGDER2_DIALOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SGDER2_DIALOG.M with the given input arguments.
%
%      SGDER2_DIALOG('Property','Value',...) creates a new SGDER2_DIALOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sgder2_dialog_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sgder2_dialog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sgder2_dialog

% Last Modified by GUIDE v2.5 08-Jul-2013 10:31:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dialog_sgder2_OpeningFcn, ...
                   'gui_OutputFcn',  @dialog_sgder2_OutputFcn, ...
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


% --- Executes just before sgder2_dialog is made visible.
function dialog_sgder2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sgder2_dialog (see VARARGIN)

% Choose default command line output for sgder2_dialog
handles.output = hObject;

dontOpen = false;
mainGuiInput = find(strcmp(varargin, 'table_main'));
if (isempty(mainGuiInput)) ...
    || (length(varargin) <= mainGuiInput) ...
    || (~ishandle(varargin{mainGuiInput+1}))
    dontOpen = true;
else
    % Remember the handle, and adjust our position
    handles.table_main = varargin{mainGuiInput+1};
end
    
% Update handles structure
guidata(hObject, handles);

uiwait(handles.dialog_sgder2)

% UIWAIT makes sgder2_dialog wait for user response (see UIRESUME)
% uiwait(handles.sgder2_dialog);


% --- Outputs from this function are returned to the command line.
function varargout = dialog_sgder2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

delete(hObject);


% --- Executes on button press in sgder2_pushbutton_run.
function sgder2_pushbutton_run_Callback(hObject, eventdata, handles)
% hObject    handle to sgder2_pushbutton_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Obtain handles using GUIDATA with the caller's handle
main = handles.table_main;
mainHandles = guidata(main);

% Updating handles of main
mainHandles.tempspec = sgder2(mainHandles.tempspec, handles.derivativenum);
set(mainHandles.data_table, 'Data', mainHandles.tempspec);
guidata(main, mainHandles);



uiresume(handles.dialog_sgder2);

% --- Executes on button press in sgder2_pushbutton_cancel.
function sgder2_pushbutton_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to sgder2_pushbutton_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.dialog_sgder2);


function sgder2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to sgder2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sgder2_edit as text
%        str2double(get(hObject,'String')) returns contents of sgder2_edit as a double
val = str2double(get(hObject,'String'));
handles.derivativenum = val;

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function sgder2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sgder2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close sgder2_dialog.
function dialog_sgder2_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to sgder2_dialog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
uiresume(hObject);
