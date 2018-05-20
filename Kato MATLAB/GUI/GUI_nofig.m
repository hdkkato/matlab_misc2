[fname, dpath, findex] = uigetfile('*.*');
if findex~=0 
    fpath = fullfile(dpath, fname);
else
    msgbox('The file does not exist.');
end;

    %import text or csv data
if ~isempty(strfind(fpath, '.txt')) || ~isempty(strfind(fpath, '.csv'))
        [data.label, data.wave, data.spec] = readtxt(fpath);
    
    %import JCAMP-DX file
elseif ~isempty(strfind(fpath, '.dx'))
        [data.label, data.wave, data.spec] = readdx(fpath);
        
else
    msgbox('The file is not a valid file.')
end
    
    

%display a figure and plot the spectra
figure;
plot(data.wave, data.spec);