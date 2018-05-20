function [titlestr, x, y] = loadproperty( buf )
%%
%finding the title of sample
titleid = cellfun(@(x) isempty(strfind(x, '##TITLE')), buf );
title = buf(~titleid);
titlestr = sscanf(title{1,1}, '%*s %s');

%%
%getting x parameter on spectra 
firstxid = cellfun(@(x) isempty(strfind(x, '##FIRSTX')), buf );
firstx = buf(~firstxid);
firstxnum = sscanf(firstx{1,1}, '%*s %f');

lastxid = cellfun(@(x) isempty(strfind(x, '##LASTX')), buf );
lastx = buf(~lastxid);
lastxnum = sscanf(lastx{1,1}, '%*s %f');

deltaxid = cellfun(@(x) isempty(strfind(x, '##DELTAX')), buf );
deltax = buf(~deltaxid);
deltaxnum = sscanf(deltax{1,1}, '%*s %f');

x = [firstxnum:deltaxnum:lastxnum];

%%
%finding xydata
datastartid = cellfun(@(x) isempty(strfind(x, '##XYDATA')), buf );
datastartposition = find(datastartid == 0) + 1;
dataendid = cellfun(@(x) isempty(strfind(x, '##END')), buf );
dataendposition = find(dataendid == 0) - 1;

xydata = buf(datastartposition:dataendposition,:);

%%
%get y parameter on spectra
rownum = length(xydata);
y = [];
for i = 1:rownum
    yy = sscanf(xydata{i,1}, '%*f %f %f %f %f %f %f %f %f', [1, inf]);
    y = [y, yy];
end

end

