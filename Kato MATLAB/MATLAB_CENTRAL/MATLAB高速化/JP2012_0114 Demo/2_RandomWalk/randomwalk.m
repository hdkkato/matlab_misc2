%% Random Walkを計算するための、いくつかの手法

%% Original
clear
tic
x = [0 0];
N = 100000;
for n = 1:N
    r = randi(4);
    if r == 1
        x(n+1,:) = x(n,:) + [1 0];
    elseif r == 2
        x(n+1,:) = x(n,:) + [0 1];
    elseif r == 3
        x(n+1,:) = x(n,:) + [-1 0];
    else
        x(n+1,:) = x(n,:) + [0 -1];
    end
end
toc
%% 事前割り当て
clear
tic
N = 100000;
x = zeros(N+1,2);

for n = 1:N
    r = randi(4);
    if r == 1
        x(n+1,:) = x(n,:) + [1 0];
    elseif r == 2
        x(n+1,:) = x(n,:) + [0 1];
    elseif r == 3
        x(n+1,:) = x(n,:) + [-1 0];
    else
        x(n+1,:) = x(n,:) + [0 -1];
    end
end
toc

%% ベクトル化
clear
tic
N = 100000;
x = zeros(N+1,2);
r = randi(4,[N 1]);

for n = 1:N
    if r(n) == 1
        x(n+1,:) = x(n,:) + [1 0];
    elseif r(n)== 2
        x(n+1,:) = x(n,:) + [0 1];
    elseif r(n) == 3
        x(n+1,:) = x(n,:) + [-1 0];
    else
        x(n+1,:) = x(n,:) + [0 -1];
    end
end
toc

%% cumsumを利用する
clear
tic
N = 100000;
dims = 2;
A = [eye(dims); -eye(dims)];
r = randi(2*dims,[N 1]);
x = [zeros(1,dims); cumsum(A(r,:))];
toc;
