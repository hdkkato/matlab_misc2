M = zeros(10,1);

tic
for n = 1:10  %<-- for �� parfor �ɂ���
    x = load(num2str(n));
    M(n) = max(x);
end
toc
