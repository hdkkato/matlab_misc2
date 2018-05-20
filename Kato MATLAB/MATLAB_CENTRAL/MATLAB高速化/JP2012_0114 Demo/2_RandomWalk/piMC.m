%% piMC
% Monte Carlo method for calculating ${\pi}$
%

N = 1e7;
count = 0;
for i = 1:N
    x = rand;
    y = rand;
    if x^2 + y^2 <= 1
        count = count + 1;
    end
end
pimc = count*4/N;
fprintf('pi = %d\n',pimc)