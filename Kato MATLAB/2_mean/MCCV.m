function [SECV]=MCCV(x,y,f,t);

[m n]=size(x);

p=zeros(1,t);
SECV=zeros(1,f);
for i=1:f
    for j=1:t
        s=randperm(m);
        s1=s(1:3);
        s2=s(4:end);
        m1=length(s1);
        m2=length(s2);
        x1=x(s1,:);
        y1=y(s1,:);
        x2=x(s2,:);
        y2=y(s2,:);
        xm=mean(x2);
        ym=mean(y2);
        x1=x1-repmat(xm,m1,1);
        x2=x2-repmat(xm,m2,1);
        y2=y2-ym;
        [b]=pls(x2,y2,i);
        y1p=x1*b+ym;
        p(:,j)=sqrt(sum((y1p-y1).^2)/m1);
    end
    SECV(:,i)=mean(p);
    loop=f-i
end

figure
plot([1:i],SECV,'k.-')
axis tight

function [b]=pls(x1,y1,f)
[m1 n1]=size(x1);
[m2 n2]=size(y1);

w=zeros(n1,f);
p=zeros(n1,f);
q=zeros(f,1);

for i=1:f
    [xnew,ynew,w(:,i),p(:,i),q(i,:)]=pls1(x1,y1);
    x1=xnew;
    y1=ynew;
end

b=w*pinv(p'*w)*q;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xnew,ynew,w,p,q]=pls1(x,y)
w=(x'*y)/norm(x'*y);
t=x*w;
p=(x'*t)/(t'*t);
q=(t'*y)/(t'*t);
xnew=x-t*p';
ynew=y-q*t;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
