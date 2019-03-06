syms omega_n zeta s m 
Ts=0.5;

A= [0 1; (-omega_n^2) (-2*omega_n*zeta)];
A_inv= simplify(inv(A));
sIminusA= [s -1;omega_n^2 (s+(2*omega_n*zeta))];
B= [0;1/m];
sIminusA_inv= inv(sIminusA);
sIminusA_inv= simplify(sIminusA_inv);
e_At= simplify(ilaplace(sIminusA_inv,Ts));
Ak= e_At;
aux= e_At-eye(2);
aux2= mtimes(A_inv,aux);
Bk= mtimes(aux2,B);


