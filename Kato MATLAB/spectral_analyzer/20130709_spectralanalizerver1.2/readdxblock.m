fid =  fopen('C:\Users\Genkawa\Documents\Kato\ŽÀŒ±\20130606_haagendazs\ToDB_20130606_haagendazs.dx');
line = fgetl(fid);
head = line;
while ~strcmp(line, '');
head = strcat(head, line);
line = fgets(fid);
end
fclose(fid);