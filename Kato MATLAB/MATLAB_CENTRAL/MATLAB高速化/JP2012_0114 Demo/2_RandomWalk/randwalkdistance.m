K = 10000;
D = zeros(K,1);

tic
for k = 1:K

    D(k) = randomwalk_fun;
       
end
toc
M = mean(D);

