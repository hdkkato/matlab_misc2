function [RMSECV]=plshcv(x,y,f);
[m n]=size(x);
RMSEP=zeros(1,2);
s=round(m/2);
xx1=x(1:s,:);
yy1=y(1:s,:);
xx2=x(s+1:end,:);
yy2=y(s+1:end,:);
[RMSEP(:,1)]=pls2(xx1,yy1,xx2,yy2,f);
[RMSEP(:,2)]=pls2(xx2,yy2,xx1,yy1,f);   
RMSECV=mean(RMSEP);

function [RMSEP]=pls2(x1,y1,x2,y2,f)

[m1 n]=size(x1);
[m2 n]=size(x2);

xm=mean(x1);
x1=x1-repmat(xm,m1,1);
x2=x2-repmat(xm,m2,1);
ym=mean(y1);
y1m=y1-ym;
y2m=y2-ym;

X1=x1;
X2=x2;
yy1=y1;

w=zeros(n,f);
p=zeros(n,f);
q=zeros(f,1);

for i=1:f
    [xnew,ynew,w(:,i),p(:,i),q(i,:)]=pls1(x1,y1m);
    x1=xnew;
    y1m=ynew;
end

b=w*pinv(p'*w)*q;
Y2=X2*b+ym;
E2=Y2-y2;
PRESS2=sum(E2.^2);
RMSEP=sqrt(PRESS2/m2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xnew,ynew,w,p,q]=pls1(x,y)
w=(x'*y)/norm(x'*y);
t=x*w;
p=(x'*t)/(t'*t);
q=(t'*y)/(t'*t);
xnew=x-t*p';
ynew=y-q*t;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    