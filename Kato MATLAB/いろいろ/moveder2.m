function [Xd] = moveder2(x,w)

p=[9:4:77];
np=length(p);  
[m n] = size(x);
Xd = cell(m,n,np); 

for i=1:np
    Xd{i} = sgder2(x,p(i));  %各ポイント数を用いた微分スペクトルを3次元配列のに格納
end

plot(Xd{1})
Xdr = reshape(Xd,[m*n*np 1]);   %3次元配列を2次元配列に変更            
Xdr = cell2mat(Xdr);    %データ型の変更
ymin = min(Xdr);
ymax = max(Xdr);    %全スペクトルの最大値・最小値を計算
ylim([-1e-3 1e-3]);
set(gca,'NextPlot','replacechildren');


for j = 1:np
 plot(w,Xd{j});
 F = getframe(gca);
end




function [xd]=sgder2(x,p);
% sedcond derivative 
% e.g. [xd]=sgder2(x,p)
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

[B G]=sgolay(2,p);
xd=zeros(m-p+1,n);
for i=1:m-p+1
    xd(i,:)=2*G(:,3)'*(x(i:i+p-1,:));
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