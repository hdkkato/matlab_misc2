function [Result,Y1]=plsr(x1,y1,f)
% x1: training set
% y1: reference of x1
% f: number of latent variables
% Result=[R1 R2 RMSEC RMSEP]
% Y1: predicted value with x1

[m1 n]=size(x1);

xm=mean(x1);
x1=x1-repmat(xm,m1,1);
ym=mean(y1);
y1m=y1-ym;

X1=x1;
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
E1=Y1-yy1;
PRESS1=sum(E1.^2);
RMSEC=sqrt(PRESS1/m1);

r1=corrcoef(yy1,Y1);
R1=r1(1,2);
Result=[R1 RMSEC];

figure
plot(yy1,yy1,'k-',yy1,Y1,'ko')
xlabel('mesured value')
ylabel('predicted value')
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