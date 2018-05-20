N = 1e7;
count = 0;

% Vector 
randPoints = rand(N,2);

% Logical indexing
inPoints = randPoints(randPoints(:,1).^2+randPoints(:,2).^2 <= 1,:);
%outPoints = randPoints(randPoints(:,1).^2+randPoints(:,2).^2 > 1,:);

count = length(inPoints(:,1));

pimc = count*4/N;

%% plot
% circle = ezplot('x^2+y^2-1');
% set(circle,'Color','k')
% hold on
% plot(inPoints(:,1),inPoints(:,2),'r.')
% plot(outPoints(:,1),outPoints(:,2),'k.')
% axis([0 1 0 1]);
% axis square;