%% �_���I�C���f�N�V���O�̃f��
%�s��A�́AmyRef���傫���v�f��"�Avals"�Ƃ����ϐ��Ɏ��o��

clear
N = 2000;

A = magic(N);  
A2 = magic(N);
A3 = magic(N);

myRef = 1e6; 



%%  ���[�v���g��
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

%% �_���I�C���f�N�V���O
tic

vals = A2(A2 > myRef);
 
toc