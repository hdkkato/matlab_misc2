%%peak alignment and centering
%
plot(w,x);
p = find(w==5776);

%%peak alignment
xpc = palignment(x,p);

%%peak normarization
xpn = pnorm(x,p);