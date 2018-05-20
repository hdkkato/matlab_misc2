function [E] = der2res(x,varargin)

fArray =1:10;
nf = length(fArray);

pArray = [9:4:77];
np = length(pArray);

E = zeros(np,nf);

if nargin == 1
    algorithm = 'eig';
    nTestSet = 3;
elseif nargin == 2
    algorithm = varargin{1};
elseif nargin == 3
    algorithm = varargin{1};
    nTestSet = varargin{2};
else
    disp('Too many input arguments.')
end

for ip = 1:np
    for jf = 1:nf
        xDer = sgder2(x,pArray(ip));
        E(ip,jf) = pcaresratio(xDer,fArray(jf),algorithm,nTestSet);
    end
    loop = np-ip
end

figure
[pp,ff] = meshgrid(pArray,fArray);
cmap = contrast(E);
contourf(ff,pp,E','k-')
colormap(cmap);
colorbar
xlabel('Factor')
ylabel('Derivative point')
