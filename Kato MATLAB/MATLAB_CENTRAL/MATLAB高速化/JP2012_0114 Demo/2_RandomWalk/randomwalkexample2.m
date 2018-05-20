function randomwalkexample2

N = 100000;
A = [1 0; -1 0; 0 1; 0 -1];
r = randi(4,[N-1 1]);
x = [0 0; cumsum(A(r,:))];

figure

axis equal;
grid on;
hold on;

xp = plot(x(:,1),x(:,2));
plot(0,0,'ro','markersize',8);
