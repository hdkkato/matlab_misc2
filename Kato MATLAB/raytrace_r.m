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
% r,z and R,Z:cylindrical cordinate of photon and accumulation of each cordinates  

%% initialization
%clear

plot(0,0,'rx')
xlabel('r [mm]');
ylabel('z [mm]');
axis equal;
grid on;
hold on;

%% Define const

N = 10000;
endR = zeros(N,1);
endZ = zeros(N,1);
maxZ = zeros(N,1);
mus = 1.77;
mua = 1.5;
g = 0.9;
W0 = 10000;

%% Monte Carlo simulation

for i = 1:N
L = 0;
theta = 0;
phi = 0;
r = 0;
z = 0;
R = 0;
Z = 0;
W = W0;
cordr = -3:0.1:3;
cordz = 0:0.1:5;
counter= zeros(length(z),counter(r));

    while z >= 0 && z < 50
        l = abs(log(rand))/(mus+mua);
        theta = theta + ...
            acos(1/(2*g)*(1+g^2-((1-g^2)/(1+g-2*g*rand))^2));
        
        L = L + l;
        
        r = r + l*sin(theta);
        z = z + l*cos(theta);
        
        R = [R,r];
        Z = [Z,z];
        
        idr = (cordr==round(r));
        idz = (cordz==round(z));
        counter(idz,idr) = counter(idz,idr) + 1;
        
        W = W0*exp(-mua*l);
    end

% max penetration depth
    maxZ(i) = max(Z);
    endR(i) = R(end);
    endZ(i) = Z(end);
    
% plot
    plot(R,Z);
    plot(R(end),Z(end),'r.','markersize',5,'linewidth',3);
     axis equal;
     grid on
end

sendmail('hdkkato453@gmail.com','シミュレーション終了','シミュレーションが終わりました。')
% culiculate mean depth
meanZ = mean(maxZ(maxZ<50));