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