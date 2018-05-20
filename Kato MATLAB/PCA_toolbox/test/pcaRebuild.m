function [xr]=pcaRebuild(x,f)
%rebuilding spectra by first f sample

xm=mean(x);
xc=bsxfun(@minus,x,xm);
r=xc'*xc;
[p l]=eigs(r,f);
t=xc*p;
xcr=t*p';
xr=bsxfun(@plus,xcr,xm);