function [xpc] = pcentering(x,p)
%Peak centering

xpc= bsxfun(@minus,x,x(:,p));