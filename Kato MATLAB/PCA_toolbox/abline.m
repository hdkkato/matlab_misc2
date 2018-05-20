function h = abline(a,b,varagin)
%
%
abline =@(a,b) (@(x) (b*x + a));
h = ezplot(abline(a,b));
end

