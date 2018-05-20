%%���l�ϕ��ɂ��pi�̌v�Z

%%
num_steps = 1e7;
step = 1/num_steps;

%% for���[�v���g�����ꍇ

clear piCalc tElapsed x sumx
tic;
sumx = 0;

for i = 1:num_steps
x = (i-0.5)*step;
sumx = sumx + 4/(1+x^2);
end

piCalc = sumx*step;
tElapsed = toc;
fprintf('pi = %f\nelapsed time = %f\n\n',piCalc,tElapsed)

%% �x�N�g����

clear piCalc tElapsed x sumx
tic;
x = zeros(1,num_steps);
sumx = zeros(1,num_steps);
x = [1:num_steps];
x = x*step;
sumx = sum(4./(1+x.^2));
piCalc = sumx*step;
tElapsed = toc;

fprintf('pi = %f\nelapsed time = %f\n\n',piCalc,tElapsed)