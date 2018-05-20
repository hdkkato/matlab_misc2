function [title, w, x] = importDX(fpath)
%%
%reading JCAMP-DX file as string
fid = fopen(fpath);
%fid =  fopen('C:\Users\Genkawa\Documents\Kato\ŽÀŒ±\20130606_haagendazs\ToDB_20130606_haagendazs.dx');
text = fscanf(fid, '%c');
fclose(fid);

%%
%storing text in cell array for every line
[cell,RowNum] = Text2CellArray(text);
cell = cell';

%%
%finding datablock size
blockid = cellfun(@(x) isempty(strfind(x, '##BLOCKS')), cell );
block = cell(~blockid);
blocknum = sscanf(block{1,1}, '%*s %d');

%%
%removing header
headid = cellfun(@(x) isempty(x),cell);
head = find(headid,1);
cell(1:head,:)=[];

%%
%buffering data blocks
emptyid = cellfun(@(x) isempty(x),cell);
emptyposition = find(emptyid == 1);

emptylength =length(emptyposition) - 1;
%title = zeros(emptylength, 1);
%x = zeros(emptylength, 1);

for i = 1:emptylength
    buf = cell(emptyposition(i)+1:emptyposition(i+1)-1,:);
    [title(i,:), w, x(i,:)] = loadproperty(buf);
    title = cellstr(title);
end


end