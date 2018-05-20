function varargout = mwsnvGUIexplain(varargin)
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

% Last Modified by GUIDE v2.5 13-May-2013 13:54:32

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

% �n���h���\���̂̏�����
handles.refferncevalue = varargin;
handles.fmaxvalue = varargin;
handles.ws = varargin;

% axes�̃N���A
cla(handles.preview_axes);
cla(handles.result_axes);

% �n���h���\���̂̍X�V
guidata(hObject, handles);


%% --- output�֐�
function varargout = mwsnvGUI_OutputFcn(hObject, eventdata, handles) 
% opening �֐����R���g���[����Ԃ��A�R���g���[�����R�}���h ���C���ɕԂ�O�ɁAMATLAB �R�}���h ���C���ɏo�͂�Ԃ��B

% Get default command line output from handles structure
varargout{1} = handles.output;

%% --- fileimport�{�^���̃R�[���o�b�N
function fileimport_Callback(hObject, eventdata, handles)
% �v�b�V���{�^���Ɋ��蓖�Ă�ꂽ��������s����

% �t�@�C�������o���W���_�C�A���O �{�b�N�X���J��
data = uiimport('-file');

% csv�t�@�C������X�y�N�g�����C���|�[�g���A�n���h���\���̂֊i�[
data = translength(data.data);
handles.wave = data(1,:);
handles.spec = data(2:end,:);

% �n���h���\���̂̍X�V
guidata(hObject, handles);

%�X�y�N�g���̃v���b�g
axes(handles.preview_axes);
plot(handles.wave, handles.spec);
axis(handles.preview_axes, 'tight');


%% --- reffernce�{�^���̃R�[���o�b�N
function reffernce_Callback(hObject, eventdata, handles)
% �t�@�C�������o���W���_�C�A���O �{�b�N�X���J��
[fname, dpath, findex] = uigetfile('*.csv');

% �t�@�C���̃p�X���擾
if findex~=0 
    fpath = fullfile(dpath, fname);
else 
    disp('�t�@�C��������܂���B');
end;

% csv�t�@�C������f�[�^���C���|�[�g���A�n���h���\���̂֊i�[
ref = importcsv4(fpath);
ref = translength(ref);
handles.refferncevalue = ref(:,1);

% �n���h���\���̂̍X�V
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
        handles.fmaxvalue = 1;
    case '2'
        handles.fmaxvalue = 2;
    case '3'
        handles.fmaxvalue = 3;
    case '4'
        handles.fmaxvalue = 4;
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
x = handles.spec;
y = handles.refferncevalue;
fmax = handles.fmaxvalue;
w = handles.wave;
ws = handles.ws;

% MWSNV�A���S���Y���̎��s
[SSR]=mwsnv4gui(x,y,fmax,w,ws);

% axes�n���h����handles.result_axes�Ɏw�肵WMSNV�A���S���Y���̌��ʂ��v���b�g
axes(handles.result_axes);
plot(w(1:end-ws+1),(SSR(2,:)),'m',w(1:end-ws+1),(SSR(1,:)),'r',w(1:end-ws+1),(SSR(end,:)),'b');

% set(h_axes, 'PropertyName', Value)��axes�n���h�����̐��䂵�������� (�v���p�e�B) ��ݒ肷��
% �Ⴆ��x���͈̔͂�ς������ꍇ��axes�n���h������'xlim'��ݒ肷��
set(handles.result_axes,'YScale','log');
axis(handles.result_axes,'tight');

% �쐬 xlabel
xlabel(handles.result_axes, 'Window position/cm^-^1');

% �쐬 ylabel
ylabel(handles.result_axes, 'SSR');
%%