function out = idct1(in, N)
    
    for n = 0 : N - 1
        p = 0;
        for m = 0 : N - 1
            if m == 0
                p = p + (1 / sqrt(2)) * in(m + 1) * cos(pi * (2 * n + 1) * m / (2 * N));
            else
                p = p + in(m + 1) * cos(pi * (2 * n + 1) * m / (2 * N));
            end
        end
        p = p * sqrt(2/ N);
        out(n + 1) = p;
    end
    