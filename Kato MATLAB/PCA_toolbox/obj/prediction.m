function [yPrediction,RMSEP] = prediction(regressionModel,x2,y2)
%prediction by PCR
% x1: training set
% x2: test set
% y1: reference of x1
% y2: reference of x2
% nFactor: number of PCs

x2m = bsxfun(@minus,x2,mean(x2));
y2m = bsxfun(@minus,y2,mean(y2));

b = regressionModel.coef;
yPrediction = x2m*b+mean(y2);
[RMSEP] = sqrt(sum((y-yPrediction).^2));