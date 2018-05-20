function [xd0]=findpeak(w,x,p)

[m n]=size(x);
xd2=sgder2(x,p);
xd3=sgder3(x,p);
xd0=zeros(m,n);

for i=2:n
    if xd3(:,i-1)<0 && xd3(:,i)>0 && xd2(1,i)<-2e-5
        xd0(:,i) = x(:,i);
    elseif xd3(:,i-1)>0 && xd3(:,i)<0 && xd2(1,i)<-2e-5
        xd0(:,i) = x(:,i);
    end
end

ii=find(xd0);

figure;
plot(w,x);
hold on;
plot(w(ii),xd0(ii),'r+');
hold off