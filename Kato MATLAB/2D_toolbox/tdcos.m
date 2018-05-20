function [syn asyn]=tdcos(w,A)
% 2D correlation spectroscopy
%
%w: wavenubmer or wavelength
%A: spectra
% 
% 波数表示のスペクトルに対し描画を行うので
% 適宜set(gca,'XDir','rev','YDir','rev')で
% 軸を反転してください

[n m] = size(A);

Ar = mean(A);
Ad = A - ones(n,1)*Ar;


Nt = zeros(n);
Nt = ones(n,1)*[1:n];
Nt = Nt - Nt';
Nt = 1./Nt;
Nt(Nt == inf) = 0;
N = 1/pi*Nt; 
 
 
syn = 1/(n-1)*(Ad')*Ad;
asyn = 1/(n-1)*Ad'*N*Ad;

subplot(1,2,1);
contour(w,w,syn);
axis square;
set(gca,'XDir','rev','YDir','rev');
title('synchronous 2D correlation spectra');
subplot(1,2,2);
contour(w,w,asyn);
axis square;
set(gca,'XDir','rev','YDir','rev');
title('asynchronous 2D correlation spectra');


