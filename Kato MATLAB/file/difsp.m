function [xs] = difsp(x)
%�@���X�y�N�g�����v�Z

xm = mean(x); %�@���σX�y�N�g�����v�Z
xs = bsxfun(@minus,x,xm);   %�@���X�y�N�g�����v�Z
