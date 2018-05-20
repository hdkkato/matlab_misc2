%% テキスト ファイルからデータをインポートします。
% 次のテキスト ファイルからデータをインポートするスクリプト:
%
%    C:\Users\Genkawa\Documents\Kato\実験\20130606_haagendazs\ToDB_20130606_haagendazs.dx
%
% コードを異なる選択データやテキスト ファイルに拡張するには、スクリプトではなく関数を生成します。

% MATLAB による自動生成 2013/06/19 15:44:07

%% 変数を初期化します。
filename = 'C:\Users\Genkawa\Documents\Kato\実験\20130606_haagendazs\ToDB_20130606_haagendazs.dx';
delimiter = ' ';

%% データの列を文字列として読み取る:
% 詳細は TEXTSCAN のドキュメンテーションを参照してください。
formatSpec = '%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% テキスト ファイルを開きます。
fileID = fopen(filename,'r');

%% データの列を書式文字列に従って読み取ります。
% この呼び出しは、このコードの生成に使用されたファイルの構造に基づいています。別のファイルでエラーが発生する場合は、インポート
% ツールからコードの再生成を試みてください。
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);

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
ToDB20130606haagendazs = cell2mat(raw);
%% 一時変数のクリア
clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me R J;