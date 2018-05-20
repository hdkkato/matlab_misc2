function [mm, ss] = qqnorm(x,ps);
%QQNORM   Normal probability paper
%
%         qqnorm(x)
%         qqnorm(x, symbol)
%
%         Data on x-axis and  qnorm((i-1/2)/n)  on y-axis.
%	  The second optonal argument is the plot symbol, e g '+'.
%
%         See also QQPLOT

if nargin<2, ps = '.'; end
x = sort(x);
n = length(x);
X = ((1:n)-1/2)/n;
Y = sqrt(2)*erfinv(2*X-1);
plot(x,Y,ps)
xlabel('Data')
ylabel('Quantile')

z0 = pnorm([-1 1]/2);
z1 = quantile(x,z0,2);
m = mean(z1);
s = diff(z1);
hold on
plot([x(1) x(n)], ([x(1), x(n)]-m)/s,'--')
title('Normal probability plot')
hold off

if nargout > 0
   mm = m;
   ss = s;
end