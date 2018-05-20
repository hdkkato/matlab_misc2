function [score, loeading, tau] = pcanipals(x,nFactor)
%NIPALS algorithm for PCA
%x: input data
%Fmax: maximum number of PCs
%
%T: score
%P: loading
%tau: eigenvalue
%
[m,n] = size(x);
score = zeros(m,nFactor);
loeading = zeros(nFactor,n);
tau = zeros(1,nFactor);

xCentered = bsxfun(@minus,x,mean(x));
xVariance = var(xCentered);

t = xCentered(:,xVariance==(max(xVariance)));

for iFactor = 1:nFactor
    p = pinv(t'*t)*t'*xCentered;
    p = p';
    p = p./sqrt(p'*p);
    tnew = xCentered*p;
    tau(iFactor) = tnew'*tnew;
    score(:,iFactor) = tnew;
    loeading(iFactor,:) = p;
    t = tnew;
    xCentered = xCentered-t*p';
end
