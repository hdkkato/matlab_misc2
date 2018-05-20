function createfigure(cdata1)
%CREATEFIGURE(CDATA1)
%  CDATA1:  image cdata

%  MATLAB からの自動生成日: 15-Sep-2014 16:43:32

% 作成 figure
figure1 = figure;

% 作成 axes
axes1 = axes('Parent',figure1,...
    'YTickLabel',{'0','0.5','1','1.5','2','2.5','3','3.5','4','4.5','5'},...
    'YDir','reverse',...
    'XTickLabel',{'-3','-2','-1','0','1','2','3'},...
    'Layer','top');
%% Axes の X 軸の範囲を保持するために以下のラインのコメントを解除
% xlim(axes1,[-0.203109121701073 600.796890878299]);
%% Axes の Y 軸の範囲を保持するために以下のラインのコメントを解除
% ylim(axes1,[-0.503455156525479 500.496544843475]);
box(axes1,'on');
hold(axes1,'all');

% 作成 image
image(0.296890878298927,-0.00345515652547895,cdata1,'Parent',axes1,...
    'CDataMapping','scaled');

