function [xd]=sgsmmoth(x,p);


[m n]=size(x);
if m<n
    [xd]=sgder(x,p);
else
    M=[1:100:m];
    xd=zeros(m,n);
    for i=1:length(M);
        if M(i)+100<m
            xx=x(M(i):M(i)+100,:);
            [xd(M(i):M(i)+100,:)]=sgder(xx,p);
        else
            xx=x(M(i):end,:);
            [xd(M(i):end,:)]=sgder(xx,p);
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xd]=sgder(x,p)
[m n]=size(x);
if m<n
    x=x';
    [m n]=size(x);
end

[B G]=sgolay(2,p);
xd=zeros(m-p+1,n);
for i=1:m-p+1
    xd(i,:)=G(:,1)'*(x(i:i+p-1,:));
end

[ms ns]=size(xd);
b=(m-ms)/2;

Bu=ones(b,n).*(ones(b,1)*xd(1,:));
Bl=ones(b,n).*(ones(b,1)*xd(end,:));

xd=[Bu;xd;Bl];
xd=xd';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%