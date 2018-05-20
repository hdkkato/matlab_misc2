function [ xout ] = translength( xin )
%translength c’·‚Ìs—ñ‚ð‰¡‚É•ÏX
%   
[i, j] = size(xin);

if i > j
    xout = xin';
else
    xout = xin;
end