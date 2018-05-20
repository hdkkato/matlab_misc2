function [xpn] = pnorm(x,p)
%Peak normarization

[m,n]=size(x);
xpc = bsxfun(@minus,x,x(:,p));
xpn = bsxfun(@rdivide,xpc,sqrt(sum(xpc.^2,2)/(n-1)));
