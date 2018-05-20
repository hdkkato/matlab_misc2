function [score, loading, tau] = pca(x,nFactor,varargin)
%Principal component analysis
%x: input data
%fmax: maximum number of PCs
%
%T: score
%P: loading
%tau: eigenvalue
%
    
if nargin == 2 || strcmpi(varargin, 'Eig');
[score, loading, tau] = pcaeig(x,nFactor);

elseif strcmpi(varargin,'Nipals');
[score, loading, tau] = pcanipals(x,nFactor);

end
