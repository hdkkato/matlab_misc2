function W=c2d(w);

% convert chart to double
% w: wavenubmer or wavelength in char

w1=cellstr(w);
w2=str2double(w1);
W=w2';
