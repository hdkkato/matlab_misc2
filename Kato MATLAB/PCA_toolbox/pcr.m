function [yPredicted,b]=pcr(x,y,nFactor,varargin)
% Principal component regression
%
% The model isrepresented as
% X = T*P' + E and
% y = X*b + f
%   = T*q + f


if nargin == 4;
    algorithm = varargin{1};
end


xCentered = bsxfun(@minus,x,mean(x));
yCentered = bsxfun(@minus,y,mean(y));
[score,loading,tau] = pca(x,nFactor,algorithm);

% q = pinv(diag(1./tau))*score'*yCentered;
% q = pinv(score'*score)*score'*yCentered;
% b = loading'*q;
b = loading*pinv(score)*yCentered;
yPredicted = xCentered*b+mean(y);