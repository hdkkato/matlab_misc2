function [syn,asyn]=tdcos(x,w);
% Two-dimentional Correlation Spectroscopy
% x: input data
% w: variables e.g. wavenumber or wavelength
%
[m1 n1]=size(x);
x=x-repmat(mean(x),m1,1);

syn=x'*x/(m1-1);
Psyn=zeros(n1);
Nsyn=zeros(n1);
Psyn=syn;
Psyn(Psyn<0)=0;
Nsyn=syn;
Nsyn(Nsyn>0)=0;

N=zeros(m1);
for i=2:m1
    N(1,i)=1/(i-1); 
end
for i=2:m1-1 
    for j=i:m1 
        N(i,j)=N(i-1,j-1); 
    end; 
end
for i=2:m1 
    for j=1:i 
        N(i,j)=-N(j,i); 
    end; 
end

N=-N/pi;
asyn=x'*N*x/(m1-1);
Pasyn=asyn;
Pasyn(Pasyn<0)=0;
Nasyn=asyn;
Nasyn(Nasyn>0)=0;
[a1,a2]=meshgrid(w,w);


figure
imagesc(w,w,syn)
colormap(jet)
hold on
contour(a1,a2,Psyn,5,'k-')
contour(a1,a2,Nsyn,5,'k:')


figure
imagesc(w,w,asyn)
colormap(jet)
hold on
contour(a1,a2,Pasyn,5,'k-')
contour(a1,a2,Nasyn,5,'k:')

