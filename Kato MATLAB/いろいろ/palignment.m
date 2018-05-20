function [xpa] = palignment(x,p)
%Peak alignment

pmean = mean(x(:,p));
pm = x(:,p)-pmean;
xpa= bsxfun(@minus,x,pm);