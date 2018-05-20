function FF_read_and_delScatter_txt
%EEMから散乱光の部分および励起波長>=蛍光波長となる領域を削除する
%
%inputs;
%InputEEM: EEMデータ（サンプルx蛍光x励起の3-wayデータ）
%Em: 蛍光波長
%Ex: 励起波長
%rep: 削除した部分と置き換える値（ex. 0, NaN etc.)
%
%output
%OutputEEM: 削除対象領域の値をrepで置き換えたデータ

%蛍光指紋データを読み込む
[InputEEM,Ex,Em,sName,cancelled]=makeEEMData_txt;

if cancelled
    return %ファイル読み込み中にキャンセルされたら作業を中止
end

%サンプル数、波長数
numSamp=size(InputEEM,1);
numEm=size(InputEEM,2);
numEx=size(InputEEM,3);
i1=30;
i2=40;
i3=40;
i4=40;

optimized=false;
while optimized==false
    %削除領域指定用のインデックス
    [x,y]=meshgrid(Ex,Em);
    delIndex=x>=y; %Ex>=Emの範囲
    
    %1次光～4次光を削除領域。下記の数値を変えれば削除範囲が変わる
    for i=1:4
        
        switch i
            
            case 1
                %1次光の削除範囲
                increment=i1;
            case 2
                %2次光の削除範囲
                increment=i2;
            case 3
                %3次光の削除範囲
                increment=i3;
            case 4
                %4次光の削除範囲
                increment=i4;
        end
        
        %論理演算で領域指定
        plusInd=i*x+increment>=y;
        minusInd=i*x-increment<=y;
        tempInd=and(plusInd,minusInd);
        delIndex=or(delIndex,tempInd);
        
    end
    
    %削除対象領域の処理
    delIndex=reshape(delIndex,1,numEm*numEx);
    OutputEEM=reshape(InputEEM,numSamp,numEm*numEx);
    OutputEEM(:,delIndex)=0;
    OutputEEM=reshape(OutputEEM,numSamp,numEm,numEx);
    
    %蛍光指紋描画
    [~,h]=contourf(Ex,Em,log(squeeze(mean(OutputEEM)+1)),128);
    xlabel('励起波長 [nm]')
    ylabel('蛍光波長 [nm]')
    set(h,'linestyle','none');
    caxis auto
    movegui northeast
    
    % 散乱光の除去範囲を変更
    prompt = {'1次光の削除範囲（ \pm  nm):',...
        '2次光の削除範囲（ \pm  nm):', '3次光の削除範囲（ \pm  nm):',...
        '4次光の削除範囲（ \pm  nm):'};
    s=['n次光の削除範囲を指定するか、' char(10)...
        '決定する場合は「キャンセル」を押して下さい'];
    dlg_title = s;
    num_lines = [1 100];
    def = {num2str(i1),num2str(i2),num2str(i3),num2str(i4)};
    options.Resize='on';
    options.Interpreter='tex';
    answer = inputdlg(prompt,dlg_title,num_lines,def,options);
    
    close
    
    if size(answer,1)==0
        optimized=true;
    else
        i1=round(str2double(answer{1}));
        i2=round(str2double(answer{2}));
        i3=round(str2double(answer{3}));
        i4=round(str2double(answer{4}));
    end
end

%出力用にデータを整形
OutputEEM=reshape(OutputEEM,numSamp,numEm*numEx);
x=x(:);
x=x';
y=y(:);
y=y';
OutputEEM=cat(1,x,y,OutputEEM);
OutputEEM=num2cell(OutputEEM);
sName=cat(1,{'励起波長->'},{'蛍光波長->'},sName);
dataToWrite=cat(2,sName,OutputEEM);

%ファイル保存
[filename,pathname] = uiputfile({'*.xlsx','Excel形式 (*.xlsx)'},'蛍光指紋データを保存...');
if isequal(filename,0) || isequal(pathname,0)
    return
else
    xlswrite(fullfile(pathname,filename),dataToWrite);
    msgbox('蛍光指紋データをファイルに保存しました。')
end

function [outputEEM,Ex,Em,sName,cancelled]=makeEEMData_txt

%F7000のデータをxlsreadで読み込んだデータ
% ...
% NaN   NaN     NaN     ...
% NaN   200	    205	    210	    215	    220	    225←励起波長
% 200	1107	844.6	61.57	1.475	1.454	1.276
% 205	176.6	1198	867.7	67.94	1.658	1.393
% 210	9.675	230.2	1388	925.2	62.83	1.016
% 215	3.063	12.46	297.5	1664	1015	65.88
% 220	2.459	2.987	14.94	379.1	1919	1106
% 225	3.664	3.547	4.51	19.63	477.6	2252
% 230	4.456	2.633	4.028	4.683	23.35	598.6
% 235	5.374	4.685	5.574	4.971	6.235	29.02
% 240	6.987	6.327	7.136	7.123	6.914	7.108
% 245	9.876	8.759	9.071	8.494	7.705	7.06
% 250	12.51	11.51	10.07	9.574	8.9	7.851
% 蛍光波長

%F7000のデータが格納されたフォルダを指定
folder = uigetdir(pwd,'蛍光指紋データが格納されたフォルダを選択して下さい。');

%ファイルリスト
files=dir(fullfile(folder,'*.txt'));
fileNum=size(files,1);

%メッセージ表示
h=waitbar(0,'','Name','ファイル読み込み中...',...
    'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
setappdata(h,'canceling',0)
set(findall(h,'type','text'),'Interpreter','none');

%メッセージ表示中にキャンセルボタンを押したかどうか
cancelled=false;

for i=1:fileNum
    %データを文字列として読み込む
    fid=fopen(fullfile(folder,files(i).name));
    textData=textscan(fid,'%s','delimiter', '\n');
    fclose(fid);
    
    %読み込んだデータから、ヘッダー部分の最終行を見つける
    textSize=size(textData{1});
    for j=1:textSize(1)
        tmpText=textData{1}{j};
        if strcmp(tmpText,'ﾃﾞｰﾀﾘｽﾄ')||strcmp(tmpText,'Data Points')
            dataStart=j;
            break
        end
    end
    
    %キャンセルボタンが押されたら終了
    if getappdata(h,'canceling')
        cancelled=true;
        break
    end
    
    %EEM描画用のファイルを作成・保存
    data=dlmread(fullfile(folder,files(i).name),'\t',dataStart,0);
    fname=regexprep(files(i).name,'.txt','','ignorecase');
    waitbar(i/fileNum,h,fname); %進捗バー表示
    
    %EEMデータの読み込み
    tempEEM=data(2:end,2:end);
    
    if i==1
        %波長情報
        Ex=data(1,2:end);
        Em=data(2:end,1);
        ExNum=max(size(Ex));
        EmNum=max(size(Em));
        
        %変数初期化
        outputEEM=NaN(fileNum,EmNum,ExNum);
        sName=cell(fileNum,1);
        
    end
    
    [sizeEm,sizeEx]=size(tempEEM);
    if sizeEm~=EmNum||sizeEx~=ExNum
        s='フォルダ内にある蛍光指紋データのサイズがバラバラです。'
        errordlg(s)
        break
    end
    
    %結合
    outputEEM(i,:,:)=tempEEM;
    sName{i}=fname; %サンプル名
    close
end

delete(h)
