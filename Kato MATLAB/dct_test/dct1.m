function out = dct1(in, N)
    
    for n = 0 : N - 1
        p = 0;
        for m = 0 : N - 1
            p = p + in(m + 1) * cos((pi * (2 * m + 1) * n) / (2 * N));
        end
        
        if n == 0
            out(n + 1) = (1 / sqrt(N)) * p;
        else
            out(n + 1) = sqrt(2 / N) * p;
        end
    end
    