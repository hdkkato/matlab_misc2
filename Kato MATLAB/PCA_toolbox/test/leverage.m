x = X;
y = Y;
[m,n] = size(x);
nFactor = 3;
[score,loading,tau] = pca(x,'Eig');
[yPredicted,b] = pcr(x,y,nFactor,'Eig');


Hf = zeros(m,2);
for j = 1:2
    for i = 1:m
    Hf(i,j) = (1./m)+...
            (score(i,j).^2)./(score(:,j)'*score(:,j));
    end
end
sLeverage=sum(Hf,2);


loadLeverage = 