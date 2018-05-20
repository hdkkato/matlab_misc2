%{
PCAによって元のスペクトル(a=xc)の情報量が
どれくらい再現されるかを比較
NIPALSアルゴリズムを使用
%}

load('datasets.mat')
w = W;
x = X;
[m n] = size(x);
fmax = 3;
T = zeros(m,fmax);
P = zeros(fmax,n);
xc = bsxfun(@minus,x,mean(x));
a = xc;
var_xc = var(xc);

xmax = max(w);
xmin = min(w);
ymax = max(max(xc));
ymin = min(min(xc));
axlim=[xmin xmax ymin ymax];%axisの描画範囲を指定

ind = var_xc==(max(var_xc));
t = xc(:,ind);

%NIPALSアルゴリズム
for f = 1:fmax
    p = pinv(t'*t)*t'*xc;
    p = p';
    p = p./sqrt(p'*p);
    tnew = xc*p*pinv(p'*p);
    t = tnew;
    T(:,f) = tnew;
    P(f,:) = p;
    xc = xc-t*p';
end

ax1 = subplot(121);
ax2 = subplot(122);
axh=[ax1 ax2];%axesのオブジェクトハンドルを取得



plot(ax1,W,a)
plot(ax2,W,a-T*P);


axis(axh,axlim,'square');%axisの描画範囲を適用
