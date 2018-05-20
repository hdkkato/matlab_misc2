%   Copyright 2007-2009 The MathWorks, Inc.
%   Last Edited: S. Wait Zaranek 4/14/2009

 function mysurf_avg = blockAvgRedo2(Nx,Ny,Nxavg,Nyavg)
%% ��� 1 - ��蒼���Q
% Input values Nx, Ny = 1500, Nxavg, Nyavg = 25;
%
% �T�[�t�F�C�X���쐬���āA�u���b�N�A�x���[�W���Ƃ�

%% �p�����[�^������

tic

Lx = 10; % x�����̒���
Ly = 10; % y�����̒���

x = linspace(1,Lx,Nx);  % x�x�N�g���쐬
y = linspace(1,Ly,Ny);  % y�x�N�g���쐬

%% �֐����O���b�h��ŕ]��

% meshgrid�𗘗p���āA�֐���]��
[ygrid,xgrid] = meshgrid(y,x);

mysurf = 5*cos((xgrid+ygrid)*2*pi)+...
    2*sin(xgrid*2*pi)+2*cos(xgrid*2*pi);








%% �u���b�N���ς��Ƃ�

% ���ς���(x,y)�̈ʒu
xavg = x(Nxavg:Nxavg:Nx)- 0.5*(x(Nxavg)-x(1));
yavg = y(Nyavg:Nyavg:Ny)- 0.5*(y(Nyavg)-y(1));


% reshape��sum�𗘗p���āA���ς��Ƃ�s
newX = (1:floor(Nx/Nxavg)*Nxavg);  % �]���ȓ_����� 
newY = (1:floor(Ny/Nyavg)*Nyavg);  % �i���ςł͎g���Ȃ��j

mysurf_avg = sum(reshape(mysurf(newX,newY),Nxavg,[]));
mysurf_avg = reshape((1/Nxavg)* mysurf_avg,floor(Nx/Nxavg),[]);

mysurf_avg = sum(reshape(mysurf_avg',Nyavg,[]));
mysurf_avg = reshape((1/Nyavg)* mysurf_avg,floor(Ny/Nxavg),[])';
toc














%% ���ʂ��v���b�g

ax(1) = subplot(2,1,1);
plot1 = pcolor(y,x,mysurf);
set(plot1,'EdgeColor','none');
title('Original Function');
axis off

ax(2) = subplot(2,1,2);
plot2 = pcolor(yavg,xavg,mysurf_avg);
set(plot2,'EdgeColor','none');
title('Averaged Function');
axis off

linkaxes(ax,'x');