function [yPrediction] = pcrprediction(x1,y1,x2,y2,nFactor,algorithm)
%prediction by PCR
% x1: training set
% x2: test set
% y1: reference of x1
% y2: reference of x2
% nFactor: number of PCs

x2m = bsxfun(@minus,x2,mean(x2));
y2m = bsxfun(@minus,y2,mean(y2));

[~,b] = pcr(x1,y1,nFactor,algorithm);
yPrediction = x2m*b+mean(y2);