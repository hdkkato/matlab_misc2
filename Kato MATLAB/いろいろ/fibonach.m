%%
%
clear x cumx
num_steps = 1e7;
x(1)=1;
x(2)=1;

tic;
for i = 3:num_steps
x(i) = x(i-2) + x(i-1);

end
cumx=cumsum(x);
toc;
%plot(x,cumx)

%%
%
