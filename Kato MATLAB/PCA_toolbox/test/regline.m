function regline(x,y)
R=corrcoef(x,y);
a=R(2,2)*std(y)/std(x);
xav=mean(x);
yav=mean(y);
ynew=a*(x-xav)+yav;

plot(x,y,'o');
hold on
plot(x,ynew,'r');
plot(x,x,'k');
hold off
end