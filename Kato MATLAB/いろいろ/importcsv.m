function spec = importcsv(fpath, startRow, endRow)
%IMPORTFILE テキスト ファイルから数値データを行列としてインポートします。
%   GLUCOSE = IMPORTFILE(FPATH) 既定の選択については テキスト ファイル FPATH
%   からデータを読み取ります。
%
%   GLUCOSE = IMPORTFILE(FILENAME, STARTROW, ENDROW) テキスト ファイル FPATH の
%   STARTROW 行から ENDROW 行までのデータを読み取ります。
%
% Example:
%   spec = importfile('glucose.csv', 1, 3131);
%
%    TEXTSCAN も参照してください。

% MATLAB による自動生成 2013/05/10 16:23:16

%% 変数を初期化します。
delimiter = ',';
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%% ファイルオープンのダイアログ
[fname, dpath, findex] = uigetfile('*.csv');
if findex~=0 
    fpath = fullfile(dpath, fname);
else 
    disp('ファイルがありません。');
end;

%% データの列を文字列として読み取る:
% 詳細は TEXTSCAN のドキュメンテーションを参照してください。
formatSpec = '%s%s%[^\n\r]';

%% テキスト ファイルを開きます。
fileID = fopen(fpath,'r');

%% データの列を書式文字列に従って読み取ります。
% この呼び出しは、このコードの生成に使用されたファイルの構造に基づいています。別のファイルでエラーが発生する場合は、インポート
% ツールからコードの再生成を試みてください。
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
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

for col=[1,2]
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


%% 非数値セルを含む行を除外
J = ~all(cellfun(@(x) (isnumeric(x) || islogical(x)) && ~isnan(x),raw),2); % 非数値セルを含む行を検索
raw(J,:) = [];

%% 出力変数の作成
spec = cell2mat(raw);
