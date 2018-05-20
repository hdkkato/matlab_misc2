%%original

tic;
X = [0 0];
N = 10000;
for n = 1:N
    r = randi(4);
    if r ==1
        X = X + [1 0];
    elseif r == 2
        X = X + [0 1];
    elseif r == 3
        X = X + [-1 0];
    elseif r == 4
        X = X + [0 -1];
    end
end
toc;

%%

%accelerated
tic
N = 10000;
r = randi(4,[N,1]);
A = [1 0;0 1;-1 0;0 -1];
X = [0 0;cumsum(A(r,:))];
toc;