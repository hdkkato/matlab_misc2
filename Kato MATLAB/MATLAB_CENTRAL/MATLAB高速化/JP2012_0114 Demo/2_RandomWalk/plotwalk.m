figure
if size(x,2) == 2
    lims = [min(x)-1 max(x)+1];
    axis equal;
    grid on;
    hold on;
    axis(lims([1 3 2 4]));
    plot(x(:,1),x(:,2));
    box on;
    plot(x(end,1),x(end,2),'ro','markersize',20,'linewidth',3);
    plot(0,0,'rx','markersize',20,'linewidth',3);

elseif size(x,2) == 3
    plot3(x(:,1),x(:,2),x(:,3));
    axis equal;
    axis vis3d;
    grid on;
    hold on;
    box on;
    plot3(x(end,1),x(end,2),x(end,3),'ro','markersize',20,'linewidth',3);
    plot3(0,0,0,'rx');
end