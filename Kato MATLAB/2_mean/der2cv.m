function [RMSECV]=der2cv(X,Y);
% optimazation of derivative parameter
% X: Spectra
% Y: Concentration

[m n]=size(X);
p=[9:4:121];
np=length(p);

if m<20
    f=[1:2:m];
else
    f=[2:2:20];
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

