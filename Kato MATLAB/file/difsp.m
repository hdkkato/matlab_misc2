function [xs] = difsp(x)
%　差スペクトルを計算

xm = mean(x); %　平均スペクトルを計算
xs = bsxfun(@minus,x,xm);   %　差スペクトルを計算
