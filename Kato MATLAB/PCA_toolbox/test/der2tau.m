function [contribution] = der2tau(x,varargin)

fArray = 1:4;
nf = length(fArray);

pArray = [9:4:77];
np = length(pArray);

contribution = zeros(np,nf);

if nargin == 1
    algorithm = 'eig';
elseif nargin == 2
    algorithm = varargin{1};
else
    disp('Too many input arguments.')
end

for ip = 1:np
    for jf = 1:nf
        [xDer] = sgder2(x,pArray(ip));
        [~,~,tau] = pca(xDer,nf,algorithm);
        [contribution(ip,jf)] =...
         sum(tau(1:jf))/sum(tau);
    end
    loop = np-ip
end

figure;
[pp,ff] = meshgrid(pArray,fArray);
cmap = contrast(contribution);
contourf(ff,pp,contribution','k-')
colormap(cmap);
colorbar
xlabel('Factor')
ylabel('Derivative point')

end