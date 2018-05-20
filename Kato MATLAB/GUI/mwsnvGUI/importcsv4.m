function spec = importcsv4(filename, startRow, endRow)
%IMPORTFILE �e�L�X�g �t�@�C�����琔�l�f�[�^���s��Ƃ��ăC���|�[�g���܂��B
%   GLU = IMPORTFILE(FILENAME) ����̑I���ɂ��Ă� �e�L�X�g �t�@�C�� FILENAME ����f�[�^��ǂݎ��܂��B
%
%   GLU = IMPORTFILE(FILENAME, STARTROW, ENDROW) �e�L�X�g �t�@�C�� FILENAME ��
%   STARTROW �s���� ENDROW �s�܂ł̃f�[�^��ǂݎ��܂��B
%
% Example:
%   glu = importfile('glu.csv', 2, 3113);
%
%    TEXTSCAN ���Q�Ƃ��Ă��������B

% MATLAB �ɂ�鎩������ 2013/05/11 14:25:50

%% �ϐ������������܂��B
delimiter = ',';
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%% �e�L�X�g�̊e�s�̏���������:
%   ��1: double (%f)
%	��2: double (%f)
%   ��3: double (%f)
%	��4: double (%f)
%   ��5: double (%f)
%	��6: double (%f)
%   ��7: double (%f)
%	��8: double (%f)
%   ��9: double (%f)
% �ڍׂ� TEXTSCAN �̃h�L�������e�[�V�������Q�Ƃ��Ă��������B
formatSpec = '%f%f%f%f%f%f%f%f%f%[^\n\r]';

%% �e�L�X�g �t�@�C�����J���܂��B
fileID = fopen(filename,'r');

%% �f�[�^�̗������������ɏ]���ēǂݎ��܂��B
% ���̌Ăяo���́A���̃R�[�h�̐����Ɏg�p���ꂽ�t�@�C���̍\���Ɋ�Â��Ă��܂��B�ʂ̃t�@�C���ŃG���[����������ꍇ�́A�C���|�[�g
% �c�[������R�[�h�̍Đ��������݂Ă��������B
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% �e�L�X�g �t�@�C������܂��B
fclose(fileID);

%% �C���|�[�g�ł��Ȃ��f�[�^�̌㏈���B
% �C���|�[�g���ɁA�C���|�[�g�ł��Ȃ��f�[�^�̋K�����K�p����Ȃ��������߁A�㏈���R�[�h���܂܂�Ă��܂���B�C���|�[�g�ł��Ȃ��f�[�^�ɓK�p�ł���R�[�h�𐶐�����ɂ́A�t�@�C�����̃C���|�[�g�ł��Ȃ��Z����I�����Ă���X�N���v�g���Đ������܂��B

%% �o�͕ϐ��̍쐬
spec = [dataArray{1:end-1}];
