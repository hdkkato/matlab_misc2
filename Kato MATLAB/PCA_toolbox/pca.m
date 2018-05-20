function [score, loading, tau] = pca(x,nFactor,varargin)
%Principal component analysis
%the dafault algorithm is set to NIPALS
%
%x: input data
%fmax: maximum number of PCs
%
%T: score
%P: loading
%tau: eigenvalue
% %
if nargin == 2
    algorithm = 'Nipals';
elseif nargin == 3
    algorithm = varargin{1};
elseif nargin >= 4
    disp('Too many input arguments.')
    return;
end

if strcmpi(algorithm,'Eig');
    [score, loading, tau] = pcaeig(x,nFactor);
elseif strcmpi(algorithm,'Nipals');
    [score, loading, tau] = pcanipals(x,nFactor);
else 
    fprintf('Undefined variable %s\n',algorithm);
    return;
end

end
