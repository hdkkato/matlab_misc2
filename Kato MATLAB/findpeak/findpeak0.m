function [xd0]=findpeak0(w,x,p)

[m n]=size(x);
xd2=sgder2(x,p);
xd3=sgder1(xd2,33);
xd0=zeros(m,n);

for i=1:n-1
    if xd3(:,i)<0 && xd3(:,i+1)>0 &&...
            xd2(:,i)<xd2(:,i+1) && xd2(:,i-1)>xd2(:,i)
        xd0(:,i) = x(:,i);
    elseif xd3(:,i)>0 && xd3(:,i+1)<0 &&...
            xd2(:,i)<xd2(:,i+1) && xd2(:,i-1)>xd2(:,i)
        xd0(:,i) = x(:,i);
    end
end

ii=find(xd0);

figure;
plot(w,x);
hold on;
plot(w(ii),xd0(ii),'r+');
hold off