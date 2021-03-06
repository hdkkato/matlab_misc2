function [SSR]=mwpcr(x,y,fmax,w)
% x: input data
% y: reference data
% fmax: maximum number of latent variables
% w: variables e.g. wavenumber or wavelength

[m n]=size(x);
ws=input('Window Size =  ');
SSR=zeros(fmax,n-ws+1);
Y=y-mean(y);
for f=1:fmax
    for i=1:n-ws+1
    X=x(:,i:i+ws-1);
    [SSR(f,i)]=pcrfullcv(X,Y,f);
    
    
    
%     [b]=pls(X,y,f);
%     Y=X*b+mean(y);
%     [SSR(f,i)]=sqrt(sum((y-Y).^2)/m);
    end
    loop=fmax-f
end

figure
plot(w(1:end-ws+1),(SSR(2,:)),'m',w(1:end-ws+1),(SSR(1,:)),'r',w(1:end-ws+1),(SSR(end,:)),'b');
%plot(w(1:end-ws+1),(SSR(3:2:end-1,:)),'k',w(1:end-ws+1),(SSR(1,:)),'r',w(1:end-ws+1),(SSR(end,:)),'b');
axis tight
