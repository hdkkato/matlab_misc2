n = 20;
J1 =  0.4401;
J =  0.7652;
Jcalc = [J,J1,zeros(1,n-2)];

for i=2:n
    J2 = 2*(i-1)*J1 - J;
    J = J1;
    J1 = J2;
    Jcalc(i+1) = J2;
end
