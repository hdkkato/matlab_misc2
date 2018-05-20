function randomwalkexample

N = 100;
A = [1 0; -1 0; 0 1; 0 -1];
r = randi(4,[N-1 1]);
x = [0 0; cumsum(A(r,:))];

figure

lims = [min(x)-1 max(x)+1];
axis equal;
grid on;
hold on;
axis(lims([1 3 2 4]));
xp = plot(x(1,1),x(1,2),'r.','markersize',32);
pause
xl = plot(nan,nan,'linewidth',3);

for n = 1:size(x,1);
    set(xp,{'xdata','ydata'},{x(n,1),x(n,2)});
    set(xl,{'xdata','ydata'},{x(1:n,1),x(1:n,2)});
    pause(0.1);
    %drawnow;
end



