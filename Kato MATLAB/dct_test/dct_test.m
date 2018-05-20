%clear;

%******************************************
% ‰Šúˆ—
%******************************************
%
% ‰æ‘œƒtƒ@ƒCƒ‹‚ğ”z—ñ‚Éƒ[ƒh‚·‚é
%img = imread('d:\freemat\start32x32.bmp');

% ‰æ‘œƒTƒCƒY(NxN)
N = 32;

% ‰æ‘œ‚ğRGB‚É•ª‚¯‚é
img_red = zeros(N, N);
img_green = zeros(N, N);
img_blue = zeros(N, N);
img_red(:, :) = img(:, :, 1);
img_green(:, :) = img(:, :, 2);
img_blue(:, :) = img(:, :, 3);

%******************************************
% RED‚Ì•ÏŠ·ˆ—
%******************************************
%
% img_red‚ğ‚QŸŒ³—£UƒRƒTƒCƒ“•ÏŠ·‚·‚é
dct_red = dct2(img_red, N);

% ’áü”g‚ğíœ‚·‚é
for i = 0 : N - 1
    c = N - i;
    dct_red(c, i + 1:N) = 0;
end

% dct_red‚ğ‹t•ÏŠ·‚·‚é
idct_red = idct2(dct_red, N);

%******************************************
% GREEN‚Ì•ÏŠ·ˆ—
%******************************************
%
% img_green‚ğ‚QŸŒ³—£UƒRƒTƒCƒ“•ÏŠ·‚·‚é
dct_green = dct2(img_green, N);

% ’áü”g‚ğíœ‚·‚é
for i = 0 : N - 1
    c = N - i;
    dct_green(c, i + 1:N) = 0;
end

% dct_green‚ğ‹t•ÏŠ·‚·‚é
idct_green = idct2(dct_green, N);

%******************************************
% BLUE‚Ì•ÏŠ·ˆ—
%******************************************
%
% img_blue‚ğ‚QŸŒ³—£UƒRƒTƒCƒ“•ÏŠ·‚·‚é
dct_blue = dct2(img_blue, N);

% ’áü”g‚ğíœ‚·‚é
for i = 0 : N - 1
    c = N - i;
    dct_blue(c, i + 1:N) = 0;
end

% dct_blue‚ğ‹t•ÏŠ·‚·‚é
idct_blue = idct2(dct_blue, N);

%******************************************
% •`‰æ—p”z—ñ‚ğì¬
%******************************************
%
idct_img = uint8(zeros(N, N, 3));
idct_img(:, :, 1) = idct_red;
idct_img(:, :, 2) = idct_green;
idct_img(:, :, 3) = idct_blue;

%******************************************
% ‰æ‘œ‚ğ•`‰æ
%******************************************
%
figure(1);
clf;

% Œ³‰æ‘œ
subplot(1, 2, 1);
image(img);
title('Œ³‚Ì‰æ‘œ');

% DCT+’áü”gíœ‚µ‚½‰æ‘œ
subplot(1, 2, 2);
image(idct_img);
title('ˆ—Œã‚Ì‰æ‘œ');

%******************************************
% DCT+’áü”gíœ‚µ‚½RED—v‘f‚ğ3D‚É•`‰æ
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
title('DCT+’áü”gíœ‚µ‚½RED—v‘f');
