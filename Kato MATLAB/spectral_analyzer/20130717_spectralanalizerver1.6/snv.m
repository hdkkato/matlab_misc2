function [x_snv] = snv(x)
% Standard Normal Variate
% [x_snv] = snv(x) 
% input:
% x (samples x variables) data to preprocess
% output:
% x_snv (samples x variables) preprocessed data

[m,n]=size(x);
rmean=mean(x,2);
dr=bsxfun(@minus,x,rmean);
x_snv=bsxfun(@rdivide,dr,sqrt(sum(dr.^2,2)/(n-1)));