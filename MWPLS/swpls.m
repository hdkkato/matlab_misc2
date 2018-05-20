function [SSR]=swpls(x,y,fmax,w)
% x: input data
% y: reference data
% fmax: maximum number of latent variables
% w: variables e.g. wavenumber or wavelength

[m n]=size(x);
SSR=zeros(fmax,n-1);

Y=y-mean(y);
for f=1:fmax
    for i=1:n-1
    X=x(:,1:i+1);
    [SSR(f,i)]=plscv(X,Y,f);
    
    
    
%     [b]=pls(X,y,f);
%     Y=X*b+mean(y);
%     [SSR(f,i)]=sqrt(sum((y-Y).^2)/m);
    end
    loop=fmax-f
end

figure
plot(w(1:n-1),(SSR(2,:)),'m',w(1:n-1),(SSR(1,:)),'r',w(1:n-1),(SSR(end,:)),'b');
%plot(w(1:end-ws+1),(SSR(3:2:end-1,:)),'k',w(1:end-ws+1),(SSR(1,:)),'r',w(1:end-ws+1),(SSR(end,:)),'b');
axis tight

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [b]=pls(x,y,f)
[m1 n1]=size(x);
x=x-repmat(mean(x),m1,1);
X=x;
yy=y;
w=zeros(n1,f);
p=zeros(n1,f);
q=zeros(f,1);

for i=1:f
    [xnew,ynew,w(:,i),p(:,i),q(i,:)]=pls1(x,y);
    x=xnew;
    y=ynew;
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