function [xSnv] = snv(x)
% Standard Normal Variate
% [xSnv] = snv(x) 

% input:
% x (samples x variables) data to preprocess

% output:
% xSnv (samples x variables) preprocessed data

[m,n] = size(x);
xRowMean = mean(x,2);
dr = bsxfun(@minus,x,xRowMean);
xSnv = bsxfun(@rdivide,dr,sqrt(sum(dr.^2,2)/(n-1)));