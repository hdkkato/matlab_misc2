M = zeros(10,1);

tic
for n = 1:10  %<-- for ‚ð parfor ‚É‚·‚é
    x = load(num2str(n));
    M(n) = max(x);
end
toc
