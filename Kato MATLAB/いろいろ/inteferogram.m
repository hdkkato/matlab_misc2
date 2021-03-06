%%インターフェログラムのインポートおよびフーリエ変換
cd('C:\Users\Genkawa\Documents\MATLAB\Kato MATLAB\2_mean')
load('C:\Users\Genkawa\Documents\Kato\実験\20130423_インターフェログラム解析\sampleIFG.mat')
load('C:\Users\Genkawa\Documents\Kato\実験\20130423_インターフェログラム解析\bgIFG.mat')

% function spec = IFG(sampleIFG, bgIFG, WIFG)

WIFG=c2d(VarLabels0);

XsIFG = sampleIFG;
XbgIFG = bgIFG;
Xbg = real(fft(XbgIFG));
Xs = real(fft(XsIFG));
A = real(-log(Xs./Xbg));

% フーリエ変換でできた折り返しを打ち切る
harf = length(WIFG(WIFG<length(WIFG)/2));

% プロット
figure(1);
plot(WIFG(WIFG<harf),A(WIFG<harf));

% スペクトルを表示
load('C:\Users\Genkawa\Documents\Kato\実験\20130423_インターフェログラム解析\sample.mat')
X=sample;
W=c2d(VarLabels0);
figure(2);
plot(W,X);

Wlength = length(W);
figure(1);
plot(W,A(find(W)));