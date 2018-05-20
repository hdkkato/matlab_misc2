%clear;

%******************************************
% ��������
%******************************************
%
% �摜�t�@�C����z��Ƀ��[�h����
%img = imread('d:\freemat\start32x32.bmp');

% �摜�T�C�Y(NxN)
N = 32;

% �摜��RGB�ɕ�����
img_red = zeros(N, N);
img_green = zeros(N, N);
img_blue = zeros(N, N);
img_red(:, :) = img(:, :, 1);
img_green(:, :) = img(:, :, 2);
img_blue(:, :) = img(:, :, 3);

%******************************************
% RED�̕ϊ�����
%******************************************
%
% img_red���Q�������U�R�T�C���ϊ�����
dct_red = dct2(img_red, N);

% ����g���폜����
for i = 0 : N - 1
    c = N - i;
    dct_red(c, i + 1:N) = 0;
end

% dct_red���t�ϊ�����
idct_red = idct2(dct_red, N);

%******************************************
% GREEN�̕ϊ�����
%******************************************
%
% img_green���Q�������U�R�T�C���ϊ�����
dct_green = dct2(img_green, N);

% ����g���폜����
for i = 0 : N - 1
    c = N - i;
    dct_green(c, i + 1:N) = 0;
end

% dct_green���t�ϊ�����
idct_green = idct2(dct_green, N);

%******************************************
% BLUE�̕ϊ�����
%******************************************
%
% img_blue���Q�������U�R�T�C���ϊ�����
dct_blue = dct2(img_blue, N);

% ����g���폜����
for i = 0 : N - 1
    c = N - i;
    dct_blue(c, i + 1:N) = 0;
end

% dct_blue���t�ϊ�����
idct_blue = idct2(dct_blue, N);

%******************************************
% �`��p�z����쐬
%******************************************
%
idct_img = uint8(zeros(N, N, 3));
idct_img(:, :, 1) = idct_red;
idct_img(:, :, 2) = idct_green;
idct_img(:, :, 3) = idct_blue;

%******************************************
% �摜��`��
%******************************************
%
figure(1);
clf;

% ���摜
subplot(1, 2, 1);
image(img);
title('���̉摜');

% DCT+����g�폜�����摜
subplot(1, 2, 2);
image(idct_img);
title('������̉摜');

%******************************************
% DCT+����g�폜����RED�v�f��3D�ɕ`��
%******************************************
%
figure(2);
clf;

% RED
x = linspace(1,N,N);
y = linspace(1,N,N);
z = dct_red(y, x) * 2;
surf(x, y, z);
axis tight;
view(3);
title('DCT+����g�폜����RED�v�f');
