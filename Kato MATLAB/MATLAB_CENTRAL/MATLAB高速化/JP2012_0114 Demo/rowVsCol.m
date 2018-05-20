%% ����ŏ��ɂ��邩�A�s���ŏ��ɂ��邩�H

%% �ϐ��̏�����
clear
N = 2000;
myRef = 0.5;

x1 = rand(N);
x2 = rand(N);
x3 = rand(N);

y1 = zeros(N);
y2 = zeros(N);
y3 = zeros(N);


%% x �� myRef���傫���v�f���Ay�ɃR�s�[����
% ���ɃX�L��������@�i�x���j
disp('���������X�L�������āA�v�Z����')

tic

for r = 1:2000 % �s
    for c = 1:2000 % ��
        if x1(r,c) > myRef
            y1(r,c) = x1(r,c);
        end
    end
end

toc

%% �c�ɃX�L��������@�i�����j
disp('�c�������X�L�������āA�v�Z����')

tic

for c = 1:2000 % ��
    for r = 1:2000 % �s
        if x2(r,c) > myRef
            y2(r,c) = x2(r,c);
        end
    end
end
toc
%% ���`�C���f�b�N�X���g�� (����ɑ����A�킸����)

tic
for n = 1:4000000
    if x3(n) > myRef
        y3(n) = x3(n);
    end
end

toc