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

% GUIDE �̏������^�X�N�B���̃R�[�h�͕ҏW���Ȃ��ł��������B
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


%% --- opening�֐�
function mwsnvGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% GUI ���[�U�[�� GUI �ɃA�N�Z�X����O�ɁA���s����鏉�����^�X�N�B
% ��������Ƃ��Đ}�̕`��Ȃǂ��s���ۂɎg�p�B
%
% �ȉ��͂��ꂼ��̊֐��ɂ���������̐���
% hObject    figure�ւ̃n���h��
% eventdata  ���ݎg���Ă��Ȃ� - �����MATLAB�̃o�[�W�����ɂ���Ďg����\��������
% handles    �n���h���\���� ���[�U�[���g�p����f�[�^��}�\�̃^�O�Ȃǂ͂����Ɋi�[����� (GUIDATA���Q��)
% varargin   �ϓ��͈��� GUI�ŃR�}���h���C���̓��͂��K�v�Ȏ��ɗp������ (VARARGIN���Q��)

% Choose default command line output for mwsnvGUI
handles.output = hObject;
% axes�̃N���A

cla(handles.preview_axes);
cla(handles.result_axes);

% �n���h���\���̂̏�����
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

% �n���h���\���̂̍X�V
guidata(hObject, handles);


%% --- output�֐�
function varargout = mwsnvGUI_OutputFcn(hObject, eventdata, handles) 
% opening �֐����R���g���[����Ԃ��A�R���g���[�����R�}���h ���C���ɕԂ�O�ɁAMATLAB �R�}���h ���C���ɏo�͂�Ԃ��B

% Get default command line output from handles structure
varargout{1} = handles.output;


%% --- reffernce�{�^���̃R�[���o�b�N
function reffernce_Callback(hObject, eventdata, handles)
% �t�@�C�������o���W���_�C�A���O �{�b�N�X���J��
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


%% --- �e�L�X�g�{�b�N�X�̃R�[���o�b�N
function windowsize_Callback(hObject, eventdata, handles)
% �e�L�X�g�{�b�N�X�̕�������擾��double�^�ɕϊ�
val = str2double(get(hObject,'String'));

% ���l���n���h���\���̂Ɋi�[
handles.ws = val;

% �n���h���\���̂̍X�V
guidata(hObject, handles);


%% --- �e�L�X�g�{�b�N�X�̏�����
function windowsize_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% --- �|�b�v�A�b�v���j���[�̃R�[���o�b�N
function fmax_Callback(hObject, eventdata, handles)
% �|�b�v�A�b�v���j���[��̕�����Ƃ���ɑΉ������l���擾
str = get(hObject,'String');
val = get(hObject,'Value');

% �I���������ڂɉ����ăn���h���ɒl��Ԃ�
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

% �n���h���\���̂̍X�V
guidata(hObject, handles);


%% --- �|�b�v�A�b�v���j���[�̏�����
function fmax_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% --- mwsnv�{�^���̃R�[���o�b�N
function mwsnv_Callback(hObject, eventdata, handles)
% mwsnv�A���S���Y���̎��s

% �n���h���\���̂���v�Z�ɕK�v�Ȋe��l����
spec = handles.spec;
ref = handles.ref;
fmax = handles.fmax;
wave = handles.wave;
ws = handles.ws;

% MWSNV�A���S���Y���̎��s
[SSR]=mwsnv(spec,ref,fmax,wave,ws);

% axes�n���h����handles.result_axes�Ɏw�肵WMSNV�A���S���Y���̌��ʂ��v���b�g
axes(handles.result_axes);
plot(wave(1:end-ws+1),(SSR(2,:)),'m',wave(1:end-ws+1),(SSR(1,:)),'r',wave(1:end-ws+1),(SSR(end,:)),'b');

% set(h_axes, 'PropertyName', Value)��axes�n���h�����̐��䂵�������� (�v���p�e�B) ��ݒ肷��
% �Ⴆ��x���͈̔͂�ς������ꍇ��axes�n���h������'xlim'��ݒ肷��
set(handles.result_axes,'YScale','log');
axis(handles.result_axes,'tight');

% �쐬 xlabel
xlabel(handles.result_axes, 'Window position/cm^-^1');

% �쐬 ylabel
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

% �n���h���\���̂̍X�V
guidata(hObject, handles);


% --------------------------------------------------------------------
function context_menu_plsr_Callback(hObject, eventdata, handles)
% hObject    handle to context_menu_plsr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dialog_plsr(handles.label, handles.sepwave, handles.sepspec, handles.ref, handles.fmax);