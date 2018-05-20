function [score,loading,tau] = pcaeig(x,nFactor)
%Principal component analysis using eigenvalue decomposition
%
[m,n] = size(x);

xCentered = bsxfun(@minus,x,mean(x));
varCovarMatrix = (xCentered'*xCentered)./(m-1);

[loading,tau] = eigs(varCovarMatrix,nFactor);

score = xCentered*loading;
loading = loading';
tau = diag(tau)';

end