function [Xn]=normalize2(x);
[m n]=size(x);

x=x-min(min(x));
a=sum(x,2);
Xn=x./repmat(a,1,n);