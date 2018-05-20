%% 列を最初にするか、行を最初にするか？

%% 変数の初期化
clear
N = 2000;
myRef = 0.5;

x1 = rand(N);
x2 = rand(N);
x3 = rand(N);

y1 = zeros(N);
y2 = zeros(N);
y3 = zeros(N);


%% x が myRefより大きい要素を、yにコピーする
% 横にスキャンする　（遅い）
disp('横方向をスキャンして、計算する')

tic

for r = 1:2000 % 行
    for c = 1:2000 % 列
        if x1(r,c) > myRef
            y1(r,c) = x1(r,c);
        end
    end
end

toc

%% 縦にスキャンする　（速い）
disp('縦方向をスキャンして、計算する')

tic

for c = 1:2000 % 列
    for r = 1:2000 % 行
        if x2(r,c) > myRef
            y2(r,c) = x2(r,c);
        end
    end
end
toc
%% 線形インデックスを使う (さらに速い、わずかに)

tic
for n = 1:4000000
    if x3(n) > myRef
        y3(n) = x3(n);
    end
end

toc