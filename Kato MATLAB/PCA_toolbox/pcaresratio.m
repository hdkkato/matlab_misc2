function [resRatio] = pcaresratio(x,nFactor,varargin)

[m,n] = size(x);


if nargin == 2
    algorithm = 'eig';
    testSet = [1:m]';
elseif nargin == 3
    algorithm = varargin{1};
    testSet = [1:m]';
elseif nargin == 4
    algorithm = varargin{1};
    nTestSet = varargin{2};
    testSet = randi(m,m,nTestSet);
elseif nargin == 4 && varargin{2} == 1
    algorithm = varargin{1};
    testSet = [1:m]';
elseif nargin >= 5
    disp('Too many input arguments.')
end

for i = 1:m
    s1 = setdiff([1:m],testSet(i,:)); 
    s2 = testSet(i,:);

    xTraining = x(s1,:);
    xTest = x(s2,:);

    [~,loading,~] = pca(xTraining,nFactor,algorithm);
    scoreHat = xTest*loading;
    E(i,:) = sum(sqrt((xTest-scoreHat*loading').^2));
    E0 = sum(sqrt((xTest).^2));

    eRatio(i) = sum(E(i))./sum(E0);
end

resRatio = mean(eRatio);

end