function [ xout ] = translength( xin )
%translength �c���̍s������ɕύX
%   
[i, j] = size(xin);

if i > j
    xout = xin';
else
    xout = xin;
end