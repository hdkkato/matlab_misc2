clear
clf
fsample = 44100;%[Hz] �T���v�����O���g��
delt = 1/fsample;%[s] �P�ʎ���
f = 1;%[Hz] ���g��
a = 1;%[Pa] �U��
i = 0:1:5*fsample;%�x�N�g���̃C���f�b�N�X
t = i*delt;%����
% ��`�g F1
F1 = a*((mod(i,fsample/f)<=1/2*fsample/f).*1 + (mod(i,fsample/f)>1/2*fsample/f).*(-1));
%�O�p�g F2
F2 = a*((mod(i,fsample/f)<=1/4*fsample/f).*(mod(i,fsample/f)/(1/4*fsample/f))...
+ (1/4*fsample/f<mod(i,fsample/f) & mod(i,fsample/f)<=3/4*fsample/f).*(2-mod(i,fsample/f)/(1/4*fsample/f))...
+ (3/4*fsample/f<mod(i,fsample/f)).*(-4+mod(i,fsample/f)/(1/4*fsample/f)));
%�m�R�M���g F3
F3 = a*(1-mod(i,fsample/f)/(1/2*fsample/f));
plot(t,F1,t,F2,t,F3)
