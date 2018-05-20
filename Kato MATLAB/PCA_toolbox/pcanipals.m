function [score, loeading, tau] = pcanipals(x,nFactor)
%Principal component analysis using NIPALS algorithm
%
%x: input data
%nFactor: maximum number of PCs
%score: score
%loading: loading
%tau: eigenvalue
%
%For details please refar to:
%http://www.camo.com/downloads/U9.6%20pdf%20manual/The%20Unscrambler%20Method%20References.pdf

[m,n] = size(x);
score = zeros(m,nFactor);
loeading = zeros(n,nFactor);
tau = zeros(1,nFactor);

%caliculating default score t
xCentered = bsxfun(@minus,x,mean(x));
xVariance = var(xCentered);
t = xCentered(:,xVariance==(max(xVariance)));
xc = xCentered;

%NIPALS algorithm
for iFactor = 1:nFactor
    p = pinv(t'*t)*t'*xc;
    p = p';
    p = p./sqrt(p'*p);
    tnew = xc*p;
    tau(iFactor) = tnew'*tnew;
    score(:,iFactor) = tnew;
    loeading(:,iFactor) = p;
    t = tnew;
    xc = xc-t*p';
end