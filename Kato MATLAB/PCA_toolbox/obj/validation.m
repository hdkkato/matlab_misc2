function [RMSECV] = validation(regressionModel,varargin)
%full cross validation by PCR
% x: spectra
% y: reference
% f: number of PCs
%dividing datasets into two segments
%s1: elements exept ith element
%s2: ith element

[m,n] = size(x);
RMSE = zeros(1,m);

method = varargin{1};
nTestSet = varargin{2};
 
if strcmpi(method,'Full') ||...
   strcmpi(method,'Leaveoneout')
    testSet = (1:m)';
elseif strcmpi(method, 'Rand')
    testSet = randi(m,m,nTestSet);  
end

for i = 1:m
    s1 = setdiff([1:m],testSet(i,:));
    s2 = testSet;
    x1 = x(s1,:);
    y1 = y(s1,:);
    x2 = x(s2,:);
    y2 = y(s2,:);
    [RMSE(1,i)] = regressionModel.method(x1,y1,x1,x2);
end

RMSECV=mean(RMSE);
end