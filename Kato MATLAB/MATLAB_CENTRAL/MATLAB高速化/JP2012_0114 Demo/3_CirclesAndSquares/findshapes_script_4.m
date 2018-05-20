ALLDATA = cell(10,2);

for N = 1:10
%% �摜�ǂݍ���
    filename = ['image' sprintf('%02d',N) '.png'];
    I = imread(filename);
    %figure;
    imshow(I);
    
%% �摜�̌`����
R = regionprops(I,'boundingbox','area');
metric = arrayfun(@(n) prod(R(n).BoundingBox(3:4)) ./ R(n).Area, 1:numel(R));

%% ���ʂ𕶎���ɏo��
DATA = '';
for j = 1:numel(R)
    if metric(j) == 1
        DATA = [DATA 9 'SQUARE' 9 ...
            num2str(R(j).BoundingBox(1)) 9 num2str(R(j).BoundingBox(2)) 9 num2str(round(R(j).BoundingBox(3)/2))];
    else
        DATA = [DATA 9 'CIRCLE' 9 ...
            num2str(R(j).BoundingBox(1)) 9 num2str(R(j).BoundingBox(2)) 9 num2str(round(R(j).BoundingBox(3)/2))];
    end
end

%text(0,0,cellstr([num2str(cell2mat(struct2cell(R)'),5)]),...
%    'color','g','vertical','top','fontname','courier new');

%% �t�@�C������
DATA
%Bad
% fid = fopen('database.txt','r');
% while ~feof(fid)
%     NEWLINE = fgetl(fid);
%     if ~isempty(strfind(NEWLINE,DATA));
%         SERIAL = NEWLINE(strfind(NEWLINE,DATA) + (-9:-2));
%         break
%     end
% end
% fclose(fid);

% Good
fid = fopen('database.txt','r');
DATABASE = fread(fid,'uint8=>char')';
SERIAL = DATABASE(strfind(DATABASE,DATA) + (-9:-2));
fclose(fid);

% ���ʂ��摜�ɃI�[�o���C
text(0,0,[filename 10 SERIAL],...
    'color','g','vertical','top','fontname','courier new','fontsize',30);
drawnow;

%% Excel�o��
ALLDATA(N,:) = {filename SERIAL};


end

xlswrite('mydata.xls',ALLDATA);
