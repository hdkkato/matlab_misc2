function [T, P, tau] = pca(x, fmax, varargin)
%PCA
%x: input data
%fmax: maximum number of PCs
%
%T: score
%P: loading
%tau: eigenvalue
%

[m n] = size(x);

xm = mean(x);
xc= zeros(m,n);
xc = bsxfun(@minus,x,xm);

if nargin == 2 || strcmp(varargin, 'Nipals');

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
        t = tnew;
        xc = xc-t*p';
    end
    
elseif strcmp(varargin, 'Eig');
    %R = xc'*xc./(m-1);
    %
    %[P, tau] = eig(R);
    %
    %P = fliplr(P);
    %P = P(:,1:fmax);
    %
    %T = xc*P;
    %T = T(:,1:fmax);
    %
    %tau = sort(diag(tau),'descend');
    r = xc'*xc./(m-1);
    [P, tau] = eigs(r,fmax);
    T = xc*P;
    P = P';
    tau = diag(tau)';
end
