function [Result,p,b,Y1,Y2]=pls2(x1,y1,x2,y2,f)
% x1: training set
% x2: test set
% y1: reference of x1
% y2: reference of x2
% f: number of latent variables
% Result=[R1 R2 RMSEC RMSEP]
% Y1: predicted value with x1
% Y2: predicted value with x2

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
Y1=X1*b+ym;
Y2=X2*b+ym;
E1=Y1-yy1;
E2=Y2-y2;
PRESS1=sum(E1.^2);
PRESS2=sum(E2.^2);
RMSEC=sqrt(PRESS1/m1);
RMSEP=sqrt(PRESS2/m2);
p=p';
b=b';

r1=corrcoef(yy1,Y1);
R1=r1(1,2);
r2=corrcoef(y2,Y2);
R2=r2(1,2);
Result=[R1 R2 RMSEC RMSEP];

figure
plot(yy1,yy1,'k-',yy1,Y1,'ko',y2,Y2,'k*')
xlabel('Mesured value')
ylabel('Predicted value')
axis tight


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xnew,ynew,w,p,q]=pls1(x,y)
w=(x'*y)/norm(x'*y);
t=x*w;
p=(x'*t)/(t'*t);
q=(t'*y)/(t'*t);
xnew=x-t*p';
ynew=y-q*t;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%