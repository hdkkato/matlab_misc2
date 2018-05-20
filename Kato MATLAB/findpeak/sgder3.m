function [xd]=sgder3(x,p);
% third derivative 
% e.g. [xd]=sgder3(x,p)
% x: data
% p: number of points

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

[B G]=sgolay(3,p);
xd=zeros(m-p+1,n);
for i=1:m-p+1
    xd(i,:)=2*G(:,4)'*(x(i:i+p-1,:));
end

[ms ns]=size(xd);
b=(m-ms)/2;

Bu=ones(b,n).*(ones(b,1)*xd(1,:));
Bl=ones(b,n).*(ones(b,1)*xd(end,:));

xd=[Bu;xd;Bl];
xd=xd';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [B,G] = sgolay(k,F,varargin)

if nargin < 3,
   W = eye(F);
else
   W = varargin{1};
   W = diag(W);
end
s = fliplr(vander(-(F-1)./2:(F-1)./2));
S = s(:,1:k+1);  
[Q,R] = qr(sqrt(W)*S,0);
G = S*inv(R)*inv(R)'; 
B = G*S'*W; 