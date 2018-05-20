circle = @(x,y) sqrt(x.^2+y.^2)-70;
h = ezplot(circle,[-80 80 -80 80 0 50]);
set(h,'linewidth',10);

[x,y,z] = cylinder(70);
surf(x,y,z*50);
axis vis3d;
axis([-80 80 -80 80 0 50])
grid on;
hold on;
box on;