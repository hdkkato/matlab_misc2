function [b]=pls(x,y,f)
% x: input data
% y: reference of x
% f: number of latent variables
[m n]=size(x);
x=x-repmat(mean(x),m,1);

w=zeros(n,f);
p=zeros(n,f);
q=zeros(f,1);

for i=1:f
    [xnew,ynew,w(:,i),p(:,i),q(i,:)]=pls1(x,y);
    x=xnew;
    ym=ynew;
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