function [Out,RowNum] = Text2CellArray(Text,varargin)

% Text2CellArray : テキストデータを行ごとに分けてセルアレイに格納
% 
% [Out,RowNum] = Text2CellArray(Text,PacketSize)
%        Text            : テキストデータ
%        PacketSize      : 一度に処理する行数を設定します
%        Out             : できあがったセルアレイ
%        RowNum          : 行数（e.g., Out(RowNum)はTextの最終行）
% 
% テキストデータ（文字コードが並んだベクトル）から改行コードを探し
% 出して行単位に区切り、各行の内容を要素に持つセルアレイを作ります。
% 改行コードはCR, CR+LF, LFのいずれにも対応しています。
% 
% 入力するTextのクラスはキャラクタ配列でもdoubleでも可です。Outの
% 各要素はTextと同じクラスになります。
% 
% 引数PacketSizeは、関数内部で一度に処理する行数を指定します。
% Textの行数が多いと、ここで指定された行数ごとにデータを分けて処理
% を行います。2以上の整数を指定して下さい。
% PacketSizeの数が大きいと処理が早くなる可能性があり
% ますが、メモリ使用量が増えます。メモリ不足が起こる場合は値を減ら
% して下さい。PacketSizeは省略可です。デフォルトは20000です。
% 
%   (2009.02.09 by RN)

Out = [];
RowNum = [];
PacketSize = 20000;

if ~isvector(Text)
    disp('  [Text2CellArray]: Please input a vector.');
    return;
end
if ischar(Text)
    Text = double(Text);
    C1 = double('{char(Text(');
    C2 = double('))} ');
elseif isnumeric(Text)
    C1 = double('{Text(');
    C2 = double(')} ');
else
    disp('  [Text2CellArray]: Please input char or double.');
    return;
end
if size(Text,2)==1
    Text = Text';
end

if 1-isempty(varargin)
    if 1-isempty(varargin{1})
        PacketSize = round(varargin{1}(1));
    end
end
if isempty(PacketSize)
    PacketSize = 20000;
end
if PacketSize<2
    disp('  [Text2CellArray]: Please input 2 or larger integer as PacketSize.');
    return;
end    

F = find(Text==10); % find LF
F2 = find(Text==13); % find CR

if isempty(F) & isempty(F2) % No return code.
    Out = eval([char(C1) ':,:' char(C2) ';']);
    RowNum = 1;
    return;
end
if isempty(F)
    Text(F2) = Text(F2)*0+10; % Replace CR (13) with LF (10).
    F = F2;
elseif ~isempty(F2) % CR+LF
    Text = Text(find(Text~=13)); % Eliminate CR (13) and leave LF (10).
    F = find(Text==10);
end

RowNum = length(F);
TailData = [(F(end)+1):length(Text)];
F1 = [1 F(1:(RowNum-1))+1];
F2 = F-1;
F1 = double(num2str(F1'));
F2 = double(num2str(F2'));
MaxFigure = max([size(F1,2) size(F2,2)]);
while size(F1,2)<MaxFigure
    F1 = [ones(RowNum,1)*32 F1];
end
while size(F2,2)<MaxFigure
    F2 = [ones(RowNum,1)*32 F2];
end
Packet = [];
Out = [];
for p=1:ceil(RowNum/PacketSize)
    S = (p-1)*PacketSize + 1;
    E = p*PacketSize;
    if E>RowNum
        E = RowNum;
    end
    if S==1
        Packet = Text(1:F(E));
    else
        Packet = Text((F(S-1)+1):F(E));
    end
    Command = [ones(E-S+1,1)*C1 F1(S:E,:) ones(E-S+1,1)*double(':') F2(S:E,:) ones(E-S+1,1)*C2];
    if RowNum>1
        Command = Command';
    end
    Command = Command(1:numel(Command));
    Command = ['Out=[Out ' char(Command) '];'];
    eval(Command);
end

if 1-isempty(TailData)
    Out = [Out eval([char(C1) '[' num2str(TailData) ']' char(C2) ';'])];
    RowNum = RowNum + 1;
end