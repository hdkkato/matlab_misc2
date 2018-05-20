function [title, w, x] = importDX(fpath)
%%
%reading JCAMP-DX file as string
fid = fopen(fpath);
%fid =  fopen('C:\Users\Genkawa\Documents\Kato\ŽÀŒ±\20130606_haagendazs\ToDB_20130606_haagendazs.dx');
text = fscanf(fid, '%c');
fclose(fid);

%%
%storing text in cell array for every line
[C,RowNum] = Text2CellArray(text);
C = C';

%%
%finding datablock size
blockid = cellfun(@(x) isempty(strfind(x, '##BLOCKS')), C );
block = C(~blockid);
blocknum = sscanf(block{1,1}, '%*s %d');

%%
%removing header
headid = cellfun(@(x) isempty(x),C);
head = find(headid,1);
C(1:head,:)=[];

%%
%finding datablock size
npointsid = cellfun(@(x) isempty(strfind(x, '##NPOINTS')), C );
npoints = C(~npointsid);
npointsnum = sscanf(npoints{1,1}, '%*s %d');

%%
%buffering data blocks
titleid = cellfun(@(x) ~isempty(strfind(x, '##TITLE')),C);
titleposition = find(titleid == 1);

endid = cellfun(@(x) ~isempty(strfind(x, '##END')),C);
endposition = find(endid == 1);

titlelength =length(titleposition);
%title = zeros(emptylength, 1);
%x = zeros(emptylength, 1);
title = cell(blocknum,1);
x = zeros(blocknum,npointsnum);

for i = 1:titlelength
    buf = C(titleposition(i):endposition(i),:);
    [title(i,:), w, x(i,:)] = loadproperty(buf);
    
end


end