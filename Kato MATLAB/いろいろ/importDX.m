function DX = importDX(filename, startRow, endRow)
%IMPORTFILE テキスト ファイルから数値データを行列としてインポートします。
%   TODB20130610HAAGENDAZS = IMPORTFILE(FILENAME) 既定の選択については テキスト ファイル
%   FILENAME からデータを読み取ります。
%
%   TODB20130610HAAGENDAZS = IMPORTFILE(FILENAME, STARTROW, ENDROW) テキスト
%   ファイル FILENAME の STARTROW 行から ENDROW 行までのデータを読み取ります。
%
% Example:
%   ToDB20130610haagendazs = importfile('ToDB_20130610_haagendazs.dx', 1,
%   9085);
%
%    TEXTSCAN も参照してください。

% MATLAB による自動生成 2013/06/19 16:42:07

%% 変数を初期化します。
delimiter = ' ';
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%% データの列を文字列として読み取る:
% 詳細は TEXTSCAN のドキュメンテーションを参照してください。
formatSpec = '%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% テキスト ファイルを開きます。
fileID = fopen(filename,'r');

%% データの列を書式文字列に従って読み取ります。
% この呼び出しは、このコードの生成に使用されたファイルの構造に基づいています。別のファイルでエラーが発生する場合は、インポート
% ツールからコードの再生成を試みてください。
textscan(fileID, '%[^\n\r]', startRow(1)-1, 'ReturnOnError', false);
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    textscan(fileID, '%[^\n\r]', startRow(block)-1, 'ReturnOnError', false);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% テキスト ファイルを閉じます。
fclose(fileID);

%% 数値文字列を含む列の内容を数値に変換します。
% 非数値文字列を NaN で置き換えます。
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3,4,5,6,7,8,9]
    % 入力セル配列の文字列を数値に変換します。非数値文字列が NaN で置き換えられました。
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % 数値でない接頭辞と接尾辞を検出して削除する正規表現を作成します。
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % 桁区切り以外の場所でコンマが検出されました。
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % 数値文字列を数値に変換します。
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end


%% 空白セルを次の値で置き換え NaN
R = cellfun(@(x) isempty(x) || (ischar(x) && all(x==' ')),raw);
raw(R) = {NaN}; % 空白セルを置き換え

%% 非数値セルを含む行を除外
J = ~all(cellfun(@(x) isnumeric(x) || islogical(x),raw),2); % 非数値セルを含む行を検索
raw(J,:) = [];

%% 出力変数の作成
DX = cell2mat(raw);
