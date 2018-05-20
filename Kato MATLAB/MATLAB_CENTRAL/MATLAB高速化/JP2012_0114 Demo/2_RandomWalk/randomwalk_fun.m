% 1000�X�e�b�v���s������̋������v�Z����
function distance = randomwalk_fun

%% cumsum�𗘗p����
N = 1000;
dims = 2;
A = [eye(dims); -eye(dims)];
r = randi(2*dims,[N 1]);
x = [zeros(1,dims); cumsum(A(r,:))];

distance = norm(x(end,:));