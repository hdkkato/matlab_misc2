function [SSR]=mwsnv(x,y,fmax,w,ws)
% x: input data
% y: reference data
% fmax: maximum number of latent variables
% w: variables e.g. wavenumber or wavelength

[m n]=size(x);
SSR=zeros(fmax,n-ws+1);
Y=y-mean(y);

h = waitbar(0,'Please wait...');
step = 1;
steps = fmax*(n-ws+1);
for f=1:fmax
    for i=1:n-ws+1
    X=x(:,i:i+ws-1);
    X_snv=snv(X);
    [SSR(f,i)]=plscv(X_snv,Y,f);
    
    step = step + 1;
    waitbar(step / steps)
    
%     [b]=pls(X,y,f);
%     Y=X*b+mean(y);
%     [SSR(f,i)]=sqrt(sum((y-Y).^2)/m);

    end
end

close(h) 


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