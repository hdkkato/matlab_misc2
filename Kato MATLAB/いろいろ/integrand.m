function z = integrand(x)

global YY
z = x*sin(YY)+YY*cos(x);
