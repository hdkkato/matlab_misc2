%clear;

%******************************************
% 初期処理
%******************************************
%
% 画像ファイルを配列にロードする
%img = imread('d:\freemat\start32x32.bmp');

% 画像サイズ(NxN)
N = 32;

% 画像をRGBに分ける
img_red = zeros(N, N);
img_green = zeros(N, N);
img_blue = zeros(N, N);
img_red(:, :) = img(:, :, 1);
img_green(:, :) = img(:, :, 2);
img_blue(:, :) = img(:, :, 3);

%******************************************
% REDの変換処理
%******************************************
%
% img_redを２次元離散コサイン変換する
dct_red = dct2(img_red, N);

% 低周波を削除する
for i = 0 : N - 1
    c = N - i;
    dct_red(c, i + 1:N) = 0;
end

% dct_redを逆変換する
idct_red = idct2(dct_red, N);

%******************************************
% GREENの変換処理
%******************************************
%
% img_greenを２次元離散コサイン変換する
dct_green = dct2(img_green, N);

% 低周波を削除する
for i = 0 : N - 1
    c = N - i;
    dct_green(c, i + 1:N) = 0;
end

% dct_greenを逆変換する
idct_green = idct2(dct_green, N);

%******************************************
% BLUEの変換処理
%******************************************
%
% img_blueを２次元離散コサイン変換する
dct_blue = dct2(img_blue, N);

% 低周波を削除する
for i = 0 : N - 1
    c = N - i;
    dct_blue(c, i + 1:N) = 0;
end

% dct_blueを逆変換する
idct_blue = idct2(dct_blue, N);

%******************************************
% 描画用配列を作成
%******************************************
%
idct_img = uint8(zeros(N, N, 3));
idct_img(:, :, 1) = idct_red;
idct_img(:, :, 2) = idct_green;
idct_img(:, :, 3) = idct_blue;

%******************************************
% 画像を描画
%******************************************
%
figure(1);
clf;

% 元画像
subplot(1, 2, 1);
image(img);
title('元の画像');

% DCT+低周波削除した画像
subplot(1, 2, 2);
image(idct_img);
title('処理後の画像');

%******************************************
% DCT+低周波削除したRED要素を3Dに描画
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
title('DCT+低周波削除したRED要素');
