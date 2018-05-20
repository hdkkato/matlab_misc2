function [label, wave, spec] = readtxt(fpath)

fid = fopen(fpath,'r');  % Open text file
InputText=textscan(fid,'%s','delimiter','\n');  % Read strings delimited
line=InputText{1};
[m n] = size(line);

for i = 1:m
    label(i) = textscan(line{i}, '%s %*[^\n]', 'delimiter', ',');
    sp(i,:) = textscan(line{i}, '%s', 'delimiter', ',');
end

label = label(2:end);
label = cellfun(@(x) cellstr(x),label);

wave = sp{1}(2:end)';
wave = cellfun(@(x) str2double(x),wave);

for i = 1:length(sp)-1
    buf = sp{i+1}(2:end);
    spec(i,:) = cellfun(@(x) str2double(x),buf);
end

fclose(fid);