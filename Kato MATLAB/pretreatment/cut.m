function [xcut wcut]=cut(x,w,w1,w2)

[i1 j1]=find(w==w1);
[i2 j2]=find(w==w2);
wcut=w(1,j1:j2);
xcut=x(:,j1:j2);
