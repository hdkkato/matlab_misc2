%% �摜�ǂݍ���
    filename = ['image01.png'];
    I = imread(filename);
    figure;
    imshow(I);
    hold on;
    
%% �摜�̌`����
R = regionprops(I,'boundingbox','area');
B = bwboundaries(I);

metric = arrayfun(@(n) prod(R(n).BoundingBox(3:4)) ./ R(n).Area, 1:numel(R));

%% ���ʂ𕶎���ɏo��
DATA = '';
for j = 1:numel(R)
    if metric(j) == 1
        DATA = [DATA 9 'SQUARE' 9 ...
            num2str(R(j).BoundingBox(1)) 9 num2str(R(j).BoundingBox(2)) 9 num2str(round(R(j).BoundingBox(3)/2))];
            plot(B{j}(:,2),B{j}(:,1),'r','linewidth',2);
            plot(R(j).BoundingBox(1)+R(j).BoundingBox(3)/2, R(j).BoundingBox(2)+R(j).BoundingBox(4)/2,'r+','markersize',20);
    else
        DATA = [DATA 9 'CIRCLE' 9 ...
            num2str(R(j).BoundingBox(1)) 9 num2str(R(j).BoundingBox(2)) 9 num2str(round(R(j).BoundingBox(3)/2))];
        plot(B{j}(:,2),B{j}(:,1),'c','linewidth',2);
        plot(R(j).BoundingBox(1)+R(j).BoundingBox(3)/2, R(j).BoundingBox(2)+R(j).BoundingBox(4)/2,'c+','markersize',20);
    end
end

%text(0,0,cellstr([num2str(cell2mat(struct2cell(R)'),5)]),...
%    'color','g','vertical','top','fontname','courier new');

%% �t�@�C������
disp(DATA)
%Bad
fid = fopen('database.txt','r');
while ~feof(fid)
    NEWLINE = fgetl(fid);
    if ~isempty(strfind(NEWLINE,DATA));
        SERIAL = NEWLINE(strfind(NEWLINE,DATA) + (-9:-2))
        break
    end
end
fclose(fid);

% ���ʂ��摜�ɃI�[�o���C
text(0,0,[filename 10 SERIAL],...
    'color','g','vertical','top','fontname','courier new','fontsize',30);
drawnow;

return
%% Excel�o��
xlswrite('mydata.xls',{filename SERIAL});


