function varargout = fold_and_draw_FF(varargin)
% FOLD_AND_DRAW_FF MATLAB code for fold_and_draw_FF.fig
%      FOLD_AND_DRAW_FF, by itself, creates a new FOLD_AND_DRAW_FF or raises the existing
%      singleton*.
%
%      H = FOLD_AND_DRAW_FF returns the handle to a new FOLD_AND_DRAW_FF or the handle to
%      the existing singleton*.
%
%      FOLD_AND_DRAW_FF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOLD_AND_DRAW_FF.M with the given input arguments.
%
%      FOLD_AND_DRAW_FF('Property','Value',...) creates a new FOLD_AND_DRAW_FF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fold_and_draw_FF_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fold_and_draw_FF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fold_and_draw_FF

% Last Modified by GUIDE v2.5 07-Feb-2014 11:34:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @fold_and_draw_FF_OpeningFcn, ...
    'gui_OutputFcn',  @fold_and_draw_FF_OutputFcn, ...
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

end

% --- Executes just before fold_and_draw_FF is made visible.
function fold_and_draw_FF_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fold_and_draw_FF (see VARARGIN)

% Choose default command line output for fold_and_draw_FF
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using fold_and_draw_FF.
% if strcmp(get(hObject,'Visible'),'off')
%     plot(rand(5));
% end

% UIWAIT makes fold_and_draw_FF wait for user response (see UIRESUME)
% uiwait(handles.figure1);

end

% --- Outputs from this function are returned to the command line.
function varargout = fold_and_draw_FF_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla;

%サンプル番号
popup_sel_index = get(handles.popupmenu1, 'Value');

%最大・最小
zMin=str2double(get(handles.edit2,'String'));
zMax=str2double(get(handles.edit3,'String'));

tmpFF=squeeze(handles.tmpFF(popup_sel_index,:,:));
if get(handles.checkbox1,'value')==1
    tmpFF=log10(tmpFF-handles.minFF+1);
end

[C,h]=contourf(handles.tmpEx,handles.tmpEm,tmpFF,64);
set(h,'linestyle','none')
xlabel('励起波長 [nm]')
ylabel('蛍光波長 [nm]')
colorbar
caxis([zMin zMax])
s=get(handles.popupmenu1, 'String');
s=s(popup_sel_index);
title(s,'interpreter','none');

%表示中の蛍光指紋の最大・最小
s=['最小: ' num2str(min(min(tmpFF)))];
set(handles.text8,'String',s);
s=['最大: ' num2str(max(max(tmpFF)))];
set(handles.text9,'String',s);

% switch popup_sel_index
%     case 1
%         plot(rand(5));
%     case 2
%         plot(sin(1:0.01:25.99));
%     case 3
%         bar(1:.5:10);
%     case 4
%         plot(membrane);
%     case 5
%         surf(peaks);
% end

end
% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

end

% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% file = uigetfile('*.fig');
% if ~isequal(file, 0)
%     open(file);
% end

%読み込んだ蛍光指紋データが格納されたファイルを指定
[fileName,dirName] = uigetfile({'*.xls*','エクセルファイル'},'蛍光指紋データが格納されたフォルダを選択して下さい。');
if ischar(fileName)
    %蛍光指紋ファイルを読み込む
    [num,txt]=xlsread(fullfile(dirName,fileName));
    sName=txt(3:end); %サンプル名
    Ex=num(1,:);
    Em=num(2,:);
    FF=num(3:end,:);
    maxFF=max(max(FF));
    minFF=min(min(FF));
    
    %各パラメータのサイズなど
    numSamp=length(sName);
    tmpEx=unique(Ex);
    numEx=length(tmpEx);
    tmpEm=unique(Em);
    numEm=length(tmpEm);
    
    %foldした蛍光指紋を格納する変数
    tmpFF=nan(numSamp,numEm,numEx);
    
    %波長条件が欠けている部分を飛ばしつつ蛍光指紋をfold
    for i=1:numEm
        for j=1:numEx
            tmpIdx=Em==tmpEm(i)&Ex==tmpEx(j);
            if isempty(find(tmpIdx, 1))
                continue
            else
                tmpFF(:,i,j)=FF(:,tmpIdx);
            end
        end
    end
    
    handles.tmpEx=tmpEx;
    handles.tmpEm=tmpEm;
    handles.tmpFF=tmpFF;
    handles.minFF=minFF;
    handles.maxFF=maxFF;
    guidata(hObject,handles)
    
else
    return
end

%サンプル名をリストに格納
set(handles.popupmenu1, 'String', sName);

%最大値・最小値
set(handles.edit2,'String',num2str(minFF));
set(handles.edit3,'String',num2str(maxFF));

%描画ボタンをアクティブにする
set(handles.pushbutton1,'Enable','on');
set(handles.edit2,'Enable','on');
set(handles.edit3,'Enable','on');

end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

end

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
    [get(handles.figure1,'Name') 'を終了します...'],...
    'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)

end

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

zMin=str2double(get(hObject,'String'));
zMax=str2double(get(handles.edit3,'String'));
if zMin>=zMax
     set(hObject,'String',num2str(zMax-1,5));
end

end

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double

zMax=str2double(get(hObject,'String'));
zMin=str2double(get(handles.edit2,'String'));
if zMin>=zMax
     set(hObject,'String',num2str(zMin+1,5));
end

end

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end
% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% %読み込んだ蛍光指紋データが格納されたファイルを指定
% [fileName,dirName] = uigetfile({'*.xls*','エクセルファイル'},'蛍光指紋データが格納されたフォルダを選択して下さい。');
% if ischar(fileName)
%     %蛍光指紋ファイルを読み込む
%     [num,txt]=xlsread(fullfile(dirName,fileName));
%     sName=txt(3:end); %サンプル名
%     Ex=num(1,:);
%     Em=num(2,:);
%     FF=num(3:end,:);
%     maxFF=max(max(FF));
%     minFF=min(min(FF));
%     
%     %各パラメータのサイズなど
%     numSamp=length(sName);
%     tmpEx=unique(Ex);
%     numEx=length(tmpEx);
%     tmpEm=unique(Em);
%     numEm=length(tmpEm);
%     
%     %foldした蛍光指紋を格納する変数
%     tmpFF=nan(numSamp,numEm,numEx);
%     
%     %波長条件が欠けている部分を飛ばしつつ蛍光指紋をfold
%     for i=1:numEm
%         for j=1:numEx
%             tmpIdx=Em==tmpEm(i)&Ex==tmpEx(j);
%             if isempty(find(tmpIdx, 1))
%                 continue
%             else
%                 tmpFF(:,i,j)=FF(:,tmpIdx);
%             end
%         end
%     end
%     
%     handles.tmpEx=tmpEx;
%     handles.tmpEm=tmpEm;
%     handles.tmpFF=tmpFF;
%     handles.maxFF=maxFF;
%     handles.minFF=minFF;
%     guidata(hObject,handles)
%     
%      set(handles.edit2,'string',num2str(minFF));
%     
% else
%     return
% end
% 
% %サンプル名をリストに格納
% set(hObject, 'String', sName);
end

% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1

if get(hObject,'Value')==1
    set(handles.edit2,'String',num2str(0));
    set(handles.edit3,'String',num2str(log10(handles.maxFF-handles.minFF+1),5));
else
    set(handles.edit2,'String',num2str(handles.minFF,5));
    set(handles.edit3,'String',num2str(handles.maxFF,5));
end

end


% --------------------------------------------------------------------
function Untitled_1_Callback(~, ~, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
print(handles.figure1,'-dmeta')
end
