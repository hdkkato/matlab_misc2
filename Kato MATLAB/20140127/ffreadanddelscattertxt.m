function FF_read_and_delScatter_txt
%EEM����U�����̕�������ї�N�g��>=�u���g���ƂȂ�̈���폜����
%
%inputs;
%InputEEM: EEM�f�[�^�i�T���v��x�u��x��N��3-way�f�[�^�j
%Em: �u���g��
%Ex: ��N�g��
%rep: �폜���������ƒu��������l�iex. 0, NaN etc.)
%
%output
%OutputEEM: �폜�Ώۗ̈�̒l��rep�Œu���������f�[�^

%�u���w��f�[�^��ǂݍ���
[InputEEM,Ex,Em,sName,cancelled]=makeEEMData_txt;

if cancelled
    return %�t�@�C���ǂݍ��ݒ��ɃL�����Z�����ꂽ���Ƃ𒆎~
end

%�T���v�����A�g����
numSamp=size(InputEEM,1);
numEm=size(InputEEM,2);
numEx=size(InputEEM,3);
i1=30;
i2=40;
i3=40;
i4=40;

optimized=false;
while optimized==false
    %�폜�̈�w��p�̃C���f�b�N�X
    [x,y]=meshgrid(Ex,Em);
    delIndex=x>=y; %Ex>=Em�͈̔�
    
    %1�����`4�������폜�̈�B���L�̐��l��ς���΍폜�͈͂��ς��
    for i=1:4
        
        switch i
            
            case 1
                %1�����̍폜�͈�
                increment=i1;
            case 2
                %2�����̍폜�͈�
                increment=i2;
            case 3
                %3�����̍폜�͈�
                increment=i3;
            case 4
                %4�����̍폜�͈�
                increment=i4;
        end
        
        %�_�����Z�ŗ̈�w��
        plusInd=i*x+increment>=y;
        minusInd=i*x-increment<=y;
        tempInd=and(plusInd,minusInd);
        delIndex=or(delIndex,tempInd);
        
    end
    
    %�폜�Ώۗ̈�̏���
    delIndex=reshape(delIndex,1,numEm*numEx);
    OutputEEM=reshape(InputEEM,numSamp,numEm*numEx);
    OutputEEM(:,delIndex)=0;
    OutputEEM=reshape(OutputEEM,numSamp,numEm,numEx);
    
    %�u���w��`��
    [~,h]=contourf(Ex,Em,log(squeeze(mean(OutputEEM)+1)),128);
    xlabel('��N�g�� [nm]')
    ylabel('�u���g�� [nm]')
    set(h,'linestyle','none');
    caxis auto
    movegui northeast
    
    % �U�����̏����͈͂�ύX
    prompt = {'1�����̍폜�͈́i \pm  nm):',...
        '2�����̍폜�͈́i \pm  nm):', '3�����̍폜�͈́i \pm  nm):',...
        '4�����̍폜�͈́i \pm  nm):'};
    s=['n�����̍폜�͈͂��w�肷�邩�A' char(10)...
        '���肷��ꍇ�́u�L�����Z���v�������ĉ�����'];
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

%�o�͗p�Ƀf�[�^�𐮌`
OutputEEM=reshape(OutputEEM,numSamp,numEm*numEx);
x=x(:);
x=x';
y=y(:);
y=y';
OutputEEM=cat(1,x,y,OutputEEM);
OutputEEM=num2cell(OutputEEM);
sName=cat(1,{'��N�g��->'},{'�u���g��->'},sName);
dataToWrite=cat(2,sName,OutputEEM);

%�t�@�C���ۑ�
[filename,pathname] = uiputfile({'*.xlsx','Excel�`�� (*.xlsx)'},'�u���w��f�[�^��ۑ�...');
if isequal(filename,0) || isequal(pathname,0)
    return
else
    xlswrite(fullfile(pathname,filename),dataToWrite);
    msgbox('�u���w��f�[�^���t�@�C���ɕۑ����܂����B')
end

function [outputEEM,Ex,Em,sName,cancelled]=makeEEMData_txt

%F7000�̃f�[�^��xlsread�œǂݍ��񂾃f�[�^
% ...
% NaN   NaN     NaN     ...
% NaN   200	    205	    210	    215	    220	    225����N�g��
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
% �u���g��

%F7000�̃f�[�^���i�[���ꂽ�t�H���_���w��
folder = uigetdir(pwd,'�u���w��f�[�^���i�[���ꂽ�t�H���_��I�����ĉ������B');

%�t�@�C�����X�g
files=dir(fullfile(folder,'*.txt'));
fileNum=size(files,1);

%���b�Z�[�W�\��
h=waitbar(0,'','Name','�t�@�C���ǂݍ��ݒ�...',...
    'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
setappdata(h,'canceling',0)
set(findall(h,'type','text'),'Interpreter','none');

%���b�Z�[�W�\�����ɃL�����Z���{�^�������������ǂ���
cancelled=false;

for i=1:fileNum
    %�f�[�^�𕶎���Ƃ��ēǂݍ���
    fid=fopen(fullfile(folder,files(i).name));
    textData=textscan(fid,'%s','delimiter', '\n');
    fclose(fid);
    
    %�ǂݍ��񂾃f�[�^����A�w�b�_�[�����̍ŏI�s��������
    textSize=size(textData{1});
    for j=1:textSize(1)
        tmpText=textData{1}{j};
        if strcmp(tmpText,'�ް�ؽ�')||strcmp(tmpText,'Data Points')
            dataStart=j;
            break
        end
    end
    
    %�L�����Z���{�^���������ꂽ��I��
    if getappdata(h,'canceling')
        cancelled=true;
        break
    end
    
    %EEM�`��p�̃t�@�C�����쐬�E�ۑ�
    data=dlmread(fullfile(folder,files(i).name),'\t',dataStart,0);
    fname=regexprep(files(i).name,'.txt','','ignorecase');
    waitbar(i/fileNum,h,fname); %�i���o�[�\��
    
    %EEM�f�[�^�̓ǂݍ���
    tempEEM=data(2:end,2:end);
    
    if i==1
        %�g�����
        Ex=data(1,2:end);
        Em=data(2:end,1);
        ExNum=max(size(Ex));
        EmNum=max(size(Em));
        
        %�ϐ�������
        outputEEM=NaN(fileNum,EmNum,ExNum);
        sName=cell(fileNum,1);
        
    end
    
    [sizeEm,sizeEx]=size(tempEEM);
    if sizeEm~=EmNum||sizeEx~=ExNum
        s='�t�H���_���ɂ���u���w��f�[�^�̃T�C�Y���o���o���ł��B'
        errordlg(s)
        break
    end
    
    %����
    outputEEM(i,:,:)=tempEEM;
    sName{i}=fname; %�T���v����
    close
end

delete(h)
