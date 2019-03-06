% Mass Spring Damper System

% parameters

k = 10;
c= 0.75 ;
m = 2;
Ts = 0.5;
Tsim = 20;
x0=[0;0];

% simulate the system

A = [    0    1
        -k/m  -c/m] ;
    
B = [ 0 ; 1/m] ;

C = eye(2) ;
D = 0;

S=ss(A,B,C,D);

H = 1/dcgain(S) ;

H = H(1);

step(S*H,Tsim)

Sd=c2d(S,Ts) ;

figure(1)
hold on

step(Sd*H,Tsim)


hold off


[Ad,Bd,Cd,Dd]=ssdata(Sd);

% LQR design

Q=diag([1,10]);
R= 0.1 ;


[P,L, K] = dare(Ad,Bd,Q,R) ;

K = -K ;

Scl = ss(Ad+Bd*K,Bd,Cd,Dd,Ts) ;

Hcl = 1/dcgain(Scl) ;

Hcl = Hcl(1) ;

figure(1)
hold on

step(Scl*Hcl)

hold off