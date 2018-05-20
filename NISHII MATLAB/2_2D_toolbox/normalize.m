function [Xn]=normalize(x)
[m n]=size(x);
Xn=zeros(m,n);
for i=1:m
    if sqrt(x(i,:)*x(i,:)')==0
        Xn=x;
        break
    end
    Xn(i,:)=x(i,:)/sqrt(x(i,:)*x(i,:)');
end