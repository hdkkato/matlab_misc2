%% 1.1 �f�[�^�^�̕ύX�Ȃ�
tic
x = 1; y = 'a';
for n = 1:1e6
    x = 1;
    y = 'a';
end
toc

%% 1.2 �f�[�^�^�̕ύX����
tic
for n = 1:1e6
    x = 1;
    x = 'a';
end
toc


%% 1.1 ���[�v�C���f�b�N�X�i�x���j
tic
for n = 1:100000
    for m = [1 2 4 8]
        n*m;
    end
end
toc

%% 1.2 ���[�v�C���f�b�N�X�i�����j
tic
M = [1 2 4 8];
for n = 1:100000
    for m = 1:numel(M)
        n*M(m);
    end
end
toc