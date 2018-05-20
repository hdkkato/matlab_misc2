function [label, wave, spectra] = readdx(fpath)

fid = fopen(fpath);

while ~feof(fid)
    tline = fgetl(fid);
    if regexp(tline, '##BLOCKS')
        blocks = str2double(regexp(tline, '[0-9.]+', 'match'));
    end
    
    if regexp(tline, '##NPOINTS')
        npoints = str2double(regexp(tline, '[0-9.]+', 'match'));
    end
    
    if regexp(tline, '##FIRSTX')
        firstx = str2double(regexp(tline, '[0-9.]+', 'match'));
    end
    
    if regexp(tline, '##LASTX')
        lastx = str2double(regexp(tline, '[0-9.]+', 'match'));
    end

end
fclose(fid);

label = cell(blocks,1);
spectra = zeros(blocks, npoints);
wave = zeros(1, npoints);
i = 1;


fid = fopen(fpath);
while ~feof(fid)
    if regexp(tline, '##TITLE')
        label(i,1) = cellstr(regexprep(tline,'##TITLE|=| ',''));
    end
   
    if regexp(tline, '##XYDATA')
        xydata = sscanf(tline, '%s');
        tline = fgetl(fid);
        sp=[];
            while 1
                if regexp(tline, '##END')
                    spectra(i,:) = sp;
                    i = i + 1;
                break
                end
                data = sscanf(tline, '%f', [1, inf]);
                sp = [sp, data(2:end)];
                tline = fgetl(fid);
            end
    end
    
    if regexp(tline, '##XYPOINTS')
        tline = fgetl(fid); 
        sp=[];
            while 1
                if regexp(tline, '##END')
                    spectra(i,:) = sp;
                    i = i + 1;
                break
                end
                data = regexprep(tline,' ','');
                data = textscan(data, '%f', 'delimiter', ',|;');
                sp = [sp, data{1}(2:2:end)'];
                wave = [wave, data{1}(1:2:end)'];
                tline = fgetl(fid);
            end
            
    end
    
    tline = fgetl(fid);
end
wave = linspace(firstx,lastx,npoints);
fclose(fid);
end