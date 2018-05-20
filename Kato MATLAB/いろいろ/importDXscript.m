%% �e�L�X�g �t�@�C������f�[�^���C���|�[�g���܂��B
% ���̃e�L�X�g �t�@�C������f�[�^���C���|�[�g����X�N���v�g:
%
%    C:\Users\Genkawa\Documents\Kato\����\20130606_haagendazs\ToDB_20130606_haagendazs.dx
%
% �R�[�h���قȂ�I���f�[�^��e�L�X�g �t�@�C���Ɋg������ɂ́A�X�N���v�g�ł͂Ȃ��֐��𐶐����܂��B

% MATLAB �ɂ�鎩������ 2013/06/19 15:44:07

%% �ϐ������������܂��B
filename = 'C:\Users\Genkawa\Documents\Kato\����\20130606_haagendazs\ToDB_20130606_haagendazs.dx';
delimiter = ' ';

%% �f�[�^�̗�𕶎���Ƃ��ēǂݎ��:
% �ڍׂ� TEXTSCAN �̃h�L�������e�[�V�������Q�Ƃ��Ă��������B
formatSpec = '%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% �e�L�X�g �t�@�C�����J���܂��B
fileID = fopen(filename,'r');

%% �f�[�^�̗������������ɏ]���ēǂݎ��܂��B
% ���̌Ăяo���́A���̃R�[�h�̐����Ɏg�p���ꂽ�t�@�C���̍\���Ɋ�Â��Ă��܂��B�ʂ̃t�@�C���ŃG���[����������ꍇ�́A�C���|�[�g
% �c�[������R�[�h�̍Đ��������݂Ă��������B
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);

%% �e�L�X�g �t�@�C������܂��B
fclose(fileID);

%% ���l��������܂ޗ�̓��e�𐔒l�ɕϊ����܂��B
% �񐔒l������� NaN �Œu�������܂��B
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3,4,5,6,7,8,9]
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


%% �󔒃Z�������̒l�Œu������ NaN
R = cellfun(@(x) isempty(x) || (ischar(x) && all(x==' ')),raw);
raw(R) = {NaN}; % �󔒃Z����u������

%% �񐔒l�Z�����܂ލs�����O
J = ~all(cellfun(@(x) isnumeric(x) || islogical(x),raw),2); % �񐔒l�Z�����܂ލs������
raw(J,:) = [];

%% �o�͕ϐ��̍쐬
ToDB20130606haagendazs = cell2mat(raw);
%% �ꎞ�ϐ��̃N���A
clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me R J;