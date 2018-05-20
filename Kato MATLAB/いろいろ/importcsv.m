function spec = importcsv(fpath, startRow, endRow)
%IMPORTFILE �e�L�X�g �t�@�C�����琔�l�f�[�^���s��Ƃ��ăC���|�[�g���܂��B
%   GLUCOSE = IMPORTFILE(FPATH) ����̑I���ɂ��Ă� �e�L�X�g �t�@�C�� FPATH
%   ����f�[�^��ǂݎ��܂��B
%
%   GLUCOSE = IMPORTFILE(FILENAME, STARTROW, ENDROW) �e�L�X�g �t�@�C�� FPATH ��
%   STARTROW �s���� ENDROW �s�܂ł̃f�[�^��ǂݎ��܂��B
%
% Example:
%   spec = importfile('glucose.csv', 1, 3131);
%
%    TEXTSCAN ���Q�Ƃ��Ă��������B

% MATLAB �ɂ�鎩������ 2013/05/10 16:23:16

%% �ϐ������������܂��B
delimiter = ',';
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%% �t�@�C���I�[�v���̃_�C�A���O
[fname, dpath, findex] = uigetfile('*.csv');
if findex~=0 
    fpath = fullfile(dpath, fname);
else 
    disp('�t�@�C��������܂���B');
end;

%% �f�[�^�̗�𕶎���Ƃ��ēǂݎ��:
% �ڍׂ� TEXTSCAN �̃h�L�������e�[�V�������Q�Ƃ��Ă��������B
formatSpec = '%s%s%[^\n\r]';

%% �e�L�X�g �t�@�C�����J���܂��B
fileID = fopen(fpath,'r');

%% �f�[�^�̗������������ɏ]���ēǂݎ��܂��B
% ���̌Ăяo���́A���̃R�[�h�̐����Ɏg�p���ꂽ�t�@�C���̍\���Ɋ�Â��Ă��܂��B�ʂ̃t�@�C���ŃG���[����������ꍇ�́A�C���|�[�g
% �c�[������R�[�h�̍Đ��������݂Ă��������B
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% �e�L�X�g �t�@�C������܂��B
fclose(fileID);

%% ���l��������܂ޗ�̓��e�𐔒l�ɕϊ����܂��B
% �񐔒l������� NaN �Œu�������܂��B
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2]
    % ���̓Z���z��̕�����𐔒l�ɕϊ����܂��B�񐔒l������ NaN �Œu���������܂����B
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % ���l�łȂ��ړ����Ɛڔ��������o���č폜���鐳�K�\�����쐬���܂��B
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % ����؂�ȊO�̏ꏊ�ŃR���}�����o����܂����B
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % ���l������𐔒l�ɕϊ����܂��B
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end


%% �񐔒l�Z�����܂ލs�����O
J = ~all(cellfun(@(x) (isnumeric(x) || islogical(x)) && ~isnan(x),raw),2); % �񐔒l�Z�����܂ލs������
raw(J,:) = [];

%% �o�͕ϐ��̍쐬
spec = cell2mat(raw);
