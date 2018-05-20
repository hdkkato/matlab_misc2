%% 論理的インデクシングのデモ
%行列Aの、myRefより大きい要素を"、vals"という変数に取り出す

clear
N = 2000;

A = magic(N);  
A2 = magic(N);
A3 = magic(N);

myRef = 1e6; 



%%  ループを使う
tic

ix = 1;

vals = zeros(size(A(:)));

for jj = 1:N
    for ii = 1:N
        if A(ii,jj) > myRef
            vals(ix) = A(ii,jj);
            ix = ix + 1;
        end
    end
end

vals(ix:end) = []; %#ok<*NASGU>

toc

%% 論理的インデクシング
tic

vals = A2(A2 > myRef);
 
toc