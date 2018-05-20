function [x1,y1,x2,y2]=sdivide(x,y)

[m n]=size(x);
[ys,I]=sort(y);
xs=x(I,:);
yy=[ys(1,:);ys(end,:)];
xx=[xs(1,:);xs(end,:)];
s2=[4:4:m-1];
s1=setdiff([2:m-1],s2);

x1=[xs(s1,:);xx];
y1=[ys(s1,:);yy];
x2=xs(s2,:);
y2=ys(s2,:);
