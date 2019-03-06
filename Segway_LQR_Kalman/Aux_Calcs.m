E_bal= [((2*m+m)*(R^2))+(2*Jw)+(2*(n^2)*Jm), (M*L*R-(2*(n^2)*Jm)); 
    (M*L*R-(2*(n^2)*Jm)), (M*(L^2))+Jpsi+(2*(n^2)*Jm)];

E_bal_inv= inv(E_bal);

F_bal= [beta+fw, -beta;
    -2*beta, 2*beta];
G_bal= [0, 0;
    0, -M*g*L];
H_bal= [alpha/2, alpha/2;
    -alpha, -alpha];

aux1= mtimes(E_bal_inv,-F_bal);
aux2= mtimes(E_bal_inv,-G_bal);
aux3= mtimes(E_bal_inv,H_bal);