function [RMSECV]=der2cv(X,Y);
% optimazation of derivative parameter
% X: Spectra
% Y: Concentration

[m n]=size(X);
p=[9:4:70];
np=length(p);

if m<10
    f=[1:1:m];
else
    f=[1:1:10];
end
nf=length(f);
RMSECV=zeros(np,nf);

for i=1:np
    for j=1:nf
    [Xd]=sgder2(X,p(i));
    [RMSECV(i,j)]=plscv(Xd,Y,j);
    end
    loop=np-i
end

[pp,ff]=meshgrid(p,f);
cmap=contrast(RMSECV);
figure
contourf(ff,pp,RMSECV','k-')
colormap(cmap);colorbar
xlabel('Factor')
ylabel('Derivative point')

