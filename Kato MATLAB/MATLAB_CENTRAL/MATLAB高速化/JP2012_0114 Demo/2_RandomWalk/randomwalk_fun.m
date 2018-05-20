% 1000ステップを行った後の距離を計算する
function distance = randomwalk_fun

%% cumsumを利用する
N = 1000;
dims = 2;
A = [eye(dims); -eye(dims)];
r = randi(2*dims,[N 1]);
x = [zeros(1,dims); cumsum(A(r,:))];

distance = norm(x(end,:));