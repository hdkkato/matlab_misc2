function [T, P, tau] = PCANIPALS(x,fmax)
%NIPALS algorithm for PCA
%x: input data
% fmax: maximum number of PCs
%
%T: score
%P: loading
%tau: eigenvalue
%

[m n] = size(x);

xm = mean(x);
xc= zeros(m,n);
xc = bsxfun(@minus,x,xm);
sumxc = sum(xc.^2);

ind = sumxc==(max(sumxc));
t = xc(:,ind);
T = zeros(m,fmax);
P = zeros(fmax,n);
tau = zeros(1,fmax);

for f = 1:fmax
    p = pinv(t'*t)*t'*xc;
    p = p';
    p = p./sqrt(p'*p);
    tnew = xc*p*pinv(p'*p);
    tau(f) = tnew'*tnew;
    T(:,f) = tnew;
    P(f,:) = p;
    t =tnew;
    xc = xc-t*p';
end
