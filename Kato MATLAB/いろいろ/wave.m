clear
clf
fsample = 44100;%[Hz] サンプリング周波数
delt = 1/fsample;%[s] 単位時間
f = 1;%[Hz] 周波数
a = 1;%[Pa] 振幅
i = 0:1:5*fsample;%ベクトルのインデックス
t = i*delt;%時刻
% 矩形波 F1
F1 = a*((mod(i,fsample/f)<=1/2*fsample/f).*1 + (mod(i,fsample/f)>1/2*fsample/f).*(-1));
%三角波 F2
F2 = a*((mod(i,fsample/f)<=1/4*fsample/f).*(mod(i,fsample/f)/(1/4*fsample/f))...
+ (1/4*fsample/f<mod(i,fsample/f) & mod(i,fsample/f)<=3/4*fsample/f).*(2-mod(i,fsample/f)/(1/4*fsample/f))...
+ (3/4*fsample/f<mod(i,fsample/f)).*(-4+mod(i,fsample/f)/(1/4*fsample/f)));
%ノコギリ波 F3
F3 = a*(1-mod(i,fsample/f)/(1/2*fsample/f));
plot(t,F1,t,F2,t,F3)
