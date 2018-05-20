%% 1.1 データ型の変更なし
tic
x = 1; y = 'a';
for n = 1:1e6
    x = 1;
    y = 'a';
end
toc

%% 1.2 データ型の変更あり
tic
for n = 1:1e6
    x = 1;
    x = 'a';
end
toc


%% 1.1 ループインデックス（遅い）
tic
for n = 1:100000
    for m = [1 2 4 8]
        n*m;
    end
end
toc

%% 1.2 ループインデックス（速い）
tic
M = [1 2 4 8];
for n = 1:100000
    for m = 1:numel(M)
        n*M(m);
    end
end
toc