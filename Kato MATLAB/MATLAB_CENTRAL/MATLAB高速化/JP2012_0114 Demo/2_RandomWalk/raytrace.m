%% Ray trace


%% Ray trace simulation
% l[mm]:total light path length
% 
% mus[mm-1]:scatter coefficient ${\mu}_{s}$
%
% mua[mm-1]:absorption coefficient ${\mu}_a$
%
% g:anisotropic scatter coefficient (-1 to 1)
%
% L[mm]:light path length in one step
%
% theta[rad]:angle of light path to z axis
% which is culculated by $\theta = \left[\frac{1}{2g}\left\{1 +
% {g}^{2}-{\left(\frac{1-{g}^{2}}{1+g-2g{R}_{2}} \right)}^{2}
% \right\}\right]$
%
% phi[rad]:angle of light path to xy surface,
% $\phi = 2 \pi R$
%
% W:light intensity
%
% x,y,z and X,Y,Z:cordinate of photon and accumulation of each cordinates  

%% initialization
clear

plot3(0,0,0,'rx')
xlabel('x [mm]');
ylabel('y [mm]');
zlabel('depth [mm]');
axis equal;
axis vis3d;
grid on;
hold on;
box on;

%% Define const

N = 100;
endX = zeros(N,1);
endY = zeros(N,1);
endZ = zeros(N,1);
maxZ = zeros(N,1);
mus = 15;
mua = 0.8;
g = 0.9;
W0 = 10000;

%% Monte Carlo simulation

for i = 1:N
l = 0;
theta = 0;
phi = 0;
x = 0;
y = 0;
z = 0;
X = 0;
Y = 0;
Z = 0;
W = W0;

    while z >= 0 && z < 10
        L = abs(log(rand))/(mus);
        theta = theta + ...
            acos(1/(2*g)*(1+g^2-((1-g^2)/(1+g-2*g*rand))^2));
        phi = phi + 2*pi()*rand;
        
        l = l + L;
        
        x = x + L*sin(theta)*cos(phi);
        y = y + L*sin(theta)*sin(phi);
        z = z + L*cos(theta);
        
        X = [X,x];
        Y = [Y,y];
        Z = [Z,z];
        
        W = W0*exp(-mua*l);
    end

% max penetration depth
    maxZ(i) = max(Z);
    endX(i) = X(end);
    endY(i) = Y(end);
    endZ(i) = Z(end);
    
% plot
    plot3(X,Y,Z);
    plot3(X(end),Y(end),Z(end),'r.','markersize',5,'linewidth',3);
     axis equal;
     grid on
end


% culiculate mean depth
meanZ = mean(maxZ(maxZ<10));