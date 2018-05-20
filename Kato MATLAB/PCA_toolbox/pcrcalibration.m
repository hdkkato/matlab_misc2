function [RMSEC] = pcrcalibration(x,y,nFactor,varargin)
%calibration by PCR
%T:score,P:loading,L:eigenvalue

if nargin == 4
    algorithm = varargin{1};
end

[m,n] = size(x);
yPredicted = pcr(x,y,nFactor,algorithm);

yResidual = y-yPredicted;
sumSqrtError = (1/m)*sum(yResidual.^2);
RMSEC = sqrt(sumSqrtError);