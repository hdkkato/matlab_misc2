function spec = importcsv4(filename, startRow, endRow)
%IMPORTFILE テキスト ファイルから数値データを行列としてインポートします。
%   GLU = IMPORTFILE(FILENAME) 既定の選択については テキスト ファイル FILENAME からデータを読み取ります。
%
%   GLU = IMPORTFILE(FILENAME, STARTROW, ENDROW) テキスト ファイル FILENAME の
%   STARTROW 行から ENDROW 行までのデータを読み取ります。
%
% Example:
%   glu = importfile('glu.csv', 2, 3113);
%
%    TEXTSCAN も参照してください。

% MATLAB による自動生成 2013/05/11 14:25:50

%% 変数を初期化します。
delimiter = ',';
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%% テキストの各行の書式文字列:
%   列1: double (%f)
%	列2: double (%f)
%   列3: double (%f)
%	列4: double (%f)
%   列5: double (%f)
%	列6: double (%f)
%   列7: double (%f)
%	列8: double (%f)
%   列9: double (%f)
% 詳細は TEXTSCAN のドキュメンテーションを参照してください。
formatSpec = '%f%f%f%f%f%f%f%f%f%[^\n\r]';

%% テキスト ファイルを開きます。
fileID = fopen(filename,'r');

%% データの列を書式文字列に従って読み取ります。
% この呼び出しは、このコードの生成に使用されたファイルの構造に基づいています。別のファイルでエラーが発生する場合は、インポート
% ツールからコードの再生成を試みてください。
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% テキスト ファイルを閉じます。
fclose(fileID);

%% インポートできないデータの後処理。
% インポート中に、インポートできないデータの規則が適用されなかったため、後処理コードが含まれていません。インポートできないデータに適用できるコードを生成するには、ファイル内のインポートできないセルを選択してからスクリプトを再生成します。

%% 出力変数の作成
spec = [dataArray{1:end-1}];
