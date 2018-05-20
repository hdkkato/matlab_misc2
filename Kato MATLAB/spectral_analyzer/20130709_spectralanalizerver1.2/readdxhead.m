%function readdxblock(fpath)
fid =  fopen('C:\Users\Genkawa\Documents\Kato\ŽÀŒ±\20130606_haagendazs\ToDB_20130606_haagendazs.dx');
line = fgetl(fid);

while ~strcmp(line, '');
    if ~isempty(strfind(line, '##BLOCKS'));
    break,end
    line = fgetl(fid);
end
block = line;
fclose(fid);