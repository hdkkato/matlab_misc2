%% 可視化の初期化
delete pworker* started
N = 64;

W = zeros(1,N);
Z = zeros(101,N);

fs = fopen('started','w');
nworkers = max([matlabpool('size') 1]);
fclose(fs);

%Initialize and write progress matrices for each worker
A = double(nan+Z);
for n = 1:nworkers
    fid = fopen(['pworker' num2str(n)],'w');
    fwrite(fid,A,'double');
    fclose(fid);
end
pause(1); %Let the visualization catch up...
mdlName = 'mytestmdl';

%% モデルの初期化
pctRunOnAll(['n = 1; b = 1; k = 1;'])
spmd
warning off
load_system(mdlName)
set_param(mdlName, 'SimulationCommand', 'update');
sim(mdlName);
end
[blist,klist] = meshgrid(1:8,10:10:80);
%% 計算ループ
tic
parfor n = 1:N
    W(n) = get(getCurrentTask,'id');
    assignin('base','b',blist(n));
    assignin('base','k',klist(n));
    output = sim('mytestmdl','StopTime','1');
    Z(:,n) = get(output,'simout');
    fid = fopen(['pworker' num2str(W(n))],'r+');
    fseek(fid,8*101*n-808,-1);
    fwrite(fid,Z(:,n),'double');
    fclose(fid);
end
toc_P = toc

%% 可視化クリーンアップ
pause(2);
while ~isempty(dir('pworker*'))
    delete pworker* started
end
figure;
plot(Z);