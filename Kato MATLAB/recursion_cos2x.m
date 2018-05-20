x = 0.7;
func = @(x) cos(x)^2;
f = func(x);
n = 200;

while round((f - x)*100000) ~= 0
    x = f;
    f = func(x);
end

disp(x);

for i = 1:n
    x = f;
    f = func(x);
    h(i) = f - x;
end

disp(x);
figure;
plot(h,'.')
set(gca, 'Xlim', [0 n])
%set(gca, 'Ylim', [-0.00001 0.00001])