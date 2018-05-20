x = 0.8;
func = @(x) 3.656*x*(1 - x);
f = func(x);
n = 1000;

%while round((g - x)*1000) ~= 0
%    x = g;
%    g = f(x);
%end

for i = 1:n
    x = f;
    f = func(x);
    h(i) = f;
    %h(i) = abs(f);
end

disp(x);
figure;
%semilogy(h);
plot(h,'.')
set(gca, 'Xlim', [0 n])
%set(gca, 'Ylim', [-0.1 0.1])
%disp(x);