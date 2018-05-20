function [RMSEP] = pcrcv(x1,y1,x2,y2,nFactor,algorithm)

[m1,n] = size(x1);
[m2,n] = size(x2);

yPrediction = pcrprediction(x1,y1,x2,y2,nFactor,algorithm);

yResidual = y2-yPrediction;
PRESS = sum(yResidual.^2);
RMSEP = sqrt(PRESS/m2);