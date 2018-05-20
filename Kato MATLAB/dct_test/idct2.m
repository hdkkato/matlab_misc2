function out = idct2(in, N)
    
    t = zeros(N, N);
    for y = 1 : N
        t(y, :) = idct1(in(y, :), N);
    end
    
    out = zeros(N, N);
    for x = 1 : N
        out(:, x) = idct1(t(:, x), N);
    end
    