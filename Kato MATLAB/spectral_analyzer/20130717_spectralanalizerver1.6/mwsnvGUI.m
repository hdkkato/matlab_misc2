function varargout = mwsnvGUI(varargin)
% MWSNVGUI MATLAB code for mwsnvGUI.fig
%      MWSNVGUI, by itself, creates a new MWSNVGUI or raises the existing
%      singleton*.
%
%      H = MWSNVGUI returns the handle to a new MWSNVGUI or the handle to
%      the existing singleton*.
%
%      MWSNVGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MWSNVGUI.M with the given input arguments.
%
%      MWSNVGUI('Property','Value',...) creates a new MWSNVGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mwsnvGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mwsnvGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mwsnvGUI

% Last Modified by GUIDE v2.5 11-Jul-2013 15:49:28

% GUIDE の初期化タスク。このコードは編集しないでください。
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mwsnvGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @mwsnvGUI_OutputFcn, ...
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


%% --- opening関数
function mwsnvGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% GUI ユーザーが GUI にアクセスする前に、実行される初期化タスク。
% 初期動作として図の描画などを行う際に使用。
%
% 以下はそれぞれの関数における引数の説明
% hObject    figureへのハンドル
% eventdata  現在使われていない - 今後のMATLABのバージョンによって使われる可能性がある
% handles    ハンドル構造体 ユーザーが使用するデータや図表のタグなどはここに格納される (GUIDATAを参照)
% varargin   可変入力引数 GUIでコマンドラインの入力が必要な時に用いられる (VARARGINを参照)

% Choose default command line output for mwsnvGUI
handles.output = hObject;
% axesのクリア

cla(handles.preview_axes);
cla(handles.result_axes);

% ハンドル構造体の初期化
handles.label = varargin{1};
handles.spec = varargin{2};
handles.wave = varargin{3};
handles.ws = 200;
handles.fmax = 3;

plot(handles.preview_axes,handles.wave,handles.spec);
xlabel(handles.preview_axes, 'Wavelength/nm')
ylabel(handles.preview_axes, 'Log (1/T) or Log (1/R)')
axis(handles.preview_axes, 'tight') 

xlabel(handles.result_axes, 'Window region')
ylabel(handles.result_axes, 'Log (SSR)');

% ハンドル構造体の更新
guidata(hObject, handles);


%% --- output関数
function varargout = mwsnvGUI_OutputFcn(hObject, eventdata, handles) 
% opening 関数がコントロールを返し、コントロールがコマンド ラインに返る前に、MATLAB コマンド ラインに出力を返す。

% Get default command line output from handles structure
varargout{1} = handles.output;


%% --- reffernceボタンのコールバック
function reffernce_Callback(hObject, eventdata, handles)
% ファイルを取り出す標準ダイアログ ボックスを開く
[fname, dpath, findex] = uigetfile('*.*');
if findex~=0 
    fpath = fullfile(dpath, fname);

    %importing only numerical text or csv data
    if isempty(strfind(fpath, '.txt')) || isempty(strfind(fpath, '.csv'))
        handles.ref = importdata(fpath);
        
    end
    
else
    disp('The file does not exist.');
end;

% Update handles structure
guidata(hObject, handles);


%% --- テキストボックスのコールバック
function windowsize_Callback(hObject, eventdata, handles)
% テキストボックスの文字列を取得しdouble型に変換
val = str2double(get(hObject,'String'));

% 数値をハンドル構造体に格納
handles.ws = val;

% ハンドル構造体の更新
guidata(hObject, handles);


%% --- テキストボックスの初期化
function windowsize_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% --- ポップアップメニューのコールバック
function fmax_Callback(hObject, eventdata, handles)
% ポップアップメニュー上の文字列とそれに対応した値を取得
str = get(hObject,'String');
val = get(hObject,'Value');

% 選択した項目に応じてハンドルに値を返す
switch str{val};
    case '1'
        handles.fmax = 1;
    case '2'
        handles.fmax = 2;
    case '3'
        handles.fmax = 3;
    case '4'
        handles.fmax = 4;
end

% ハンドル構造体の更新
guidata(hObject, handles);


%% --- ポップアップメニューの初期化
function fmax_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% --- mwsnvボタンのコールバック
function mwsnv_Callback(hObject, eventdata, handles)
% mwsnvアルゴリズムの実行

% ハンドル構造体から計算に必要な各種値を代入
spec = handles.spec;
ref = handles.ref;
fmax = handles.fmax;
wave = handles.wave;
ws = handles.ws;

% MWSNVアルゴリズムの実行
[SSR]=mwsnv(spec,ref,fmax,wave,ws);

% axesハンドルをhandles.result_axesに指定しWMSNVアルゴリズムの結果をプロット
axes(handles.result_axes);
plot(wave(1:end-ws+1),(SSR(2,:)),'m',wave(1:end-ws+1),(SSR(1,:)),'r',wave(1:end-ws+1),(SSR(end,:)),'b');

% set(h_axes, 'PropertyName', Value)はaxesハンドル中の制御したい項目 (プロパティ) を設定する
% 例えばx軸の範囲を変えたい場合はaxesハンドル中の'xlim'を設定する
set(handles.result_axes,'YScale','log');
axis(handles.result_axes,'tight');

% 作成 xlabel
xlabel(handles.result_axes, 'Window position/cm^-^1');

% 作成 ylabel
ylabel(handles.result_axes, 'SSR');
%%


% --------------------------------------------------------------------
function axes_context_menu_Callback(hObject, eventdata, handles)
% hObject    handle to axes_context_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function context_menu_select_Callback(hObject, eventdata, handles)
% hObject    handle to context_menu_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
spec = handles.spec;
wave = handles.wave;
ws = handles.ws;


get(handles.result_axes);
hold on

[x,y,but] = ginput(1);
plot(x,y,'ro');

handles.x_axis = x;
handles.y_axis = y;

id = find(wave == round(x));
handles.sepwave = wave(1,id:id+ws);
handles.sepspec = spec(:,id:id+ws);

% ハンドル構造体の更新
guidata(hObject, handles);


% --------------------------------------------------------------------
function context_menu_plsr_Callback(hObject, eventdata, handles)
% hObject    handle to context_menu_plsr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dialog_plsr(handles.label, handles.sepwave, handles.sepspec, handles.ref, handles.fmax);