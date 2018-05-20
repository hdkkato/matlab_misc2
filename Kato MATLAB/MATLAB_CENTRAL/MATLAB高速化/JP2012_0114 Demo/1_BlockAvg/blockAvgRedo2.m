%   Copyright 2007-2009 The MathWorks, Inc.
%   Last Edited: S. Wait Zaranek 4/14/2009

 function mysurf_avg = blockAvgRedo2(Nx,Ny,Nxavg,Nyavg)
%% 例題 1 - やり直し２
% Input values Nx, Ny = 1500, Nxavg, Nyavg = 25;
%
% サーフェイスを作成して、ブロックアベレージをとる

%% パラメータ初期化

tic

Lx = 10; % x方向の長さ
Ly = 10; % y方向の長さ

x = linspace(1,Lx,Nx);  % xベクトル作成
y = linspace(1,Ly,Ny);  % yベクトル作成

%% 関数をグリッド上で評価

% meshgridを利用して、関数を評価
[ygrid,xgrid] = meshgrid(y,x);

mysurf = 5*cos((xgrid+ygrid)*2*pi)+...
    2*sin(xgrid*2*pi)+2*cos(xgrid*2*pi);








%% ブロック平均をとる

% 平均する(x,y)の位置
xavg = x(Nxavg:Nxavg:Nx)- 0.5*(x(Nxavg)-x(1));
yavg = y(Nyavg:Nyavg:Ny)- 0.5*(y(Nyavg)-y(1));


% reshapeとsumを利用して、平均をとるs
newX = (1:floor(Nx/Nxavg)*Nxavg);  % 余分な点を削る 
newY = (1:floor(Ny/Nyavg)*Nyavg);  % （平均では使われない）

mysurf_avg = sum(reshape(mysurf(newX,newY),Nxavg,[]));
mysurf_avg = reshape((1/Nxavg)* mysurf_avg,floor(Nx/Nxavg),[]);

mysurf_avg = sum(reshape(mysurf_avg',Nyavg,[]));
mysurf_avg = reshape((1/Nyavg)* mysurf_avg,floor(Ny/Nxavg),[])';
toc














%% 結果をプロット

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