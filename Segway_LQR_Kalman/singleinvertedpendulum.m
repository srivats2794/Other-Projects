clc; clear;
g=9.81;
m=0.03;W=0.09;
R=0.021;Jw= (m*(R^2))/2; M=0.6; D=0.05; H= 0.26; L=H/2; Jpsi= (M*(L^2))/3;
Jphi= (M*((W^2)+(D^2)))/12; 
Jm=(10^-5);
Rm=6.69;
Kb=0.468;
Kt=0.317;
n=1;
fm=0.0022;fw=0; alpha= (n*Kt)/Rm; beta= ((n*Kt*Kb)/Rm)+fm;

Ts= 0.001; Tsim=50;

Aux_Calcs; % Running auxiliary calculations for calculating state matrices

%% Path planning subsystem
I= beta+((W/R)*fw); J= (R/W)*alpha; K = (0.5*m*(W^2))+Jphi+(((W^2)/(2*(R^2)))*(Jw+(n^2)*Jm));

E= [0,1;0, -I/K;]; F= [0, 0; -J/K, J/K]; G= [1,0]; H= [0, 0];

%% Balancing subsystem
A= [0, 0, 1, 0;
    0, 0, 0, 1;
    0, -698.30, -416.80, 416.80;
    0, 139.96, 53.41, -53.41];

B= [0, 0;
    0, 0;
    405.11, 405.11;
    -51.91, -51.91];

C= [1 0 0 0; 0 0 0 1];

D= 0;


x0= [0;0.1;0;0]; %Initial condition for balancing subsystem

S=ss(A,B,C,D);
Sd=c2d(S,Ts) ;
[Ad,Bd,Cd,Dd]=ssdata(Sd);
S2= ss(E,F,G,H);
S2d= c2d(S2,Ts);
[Ed,Fd,Gd,Hd]=ssdata(S2d);

Sd.StateName= {'theta', 'thetadot', 'psi', 'psidot'};
Sd.OutputName= {'theta', 'psidot'};
Sd.InputName= {'VoltageL', 'VoltageR'};
S2dpathplanning.StateName= {'phi', 'phidot'};
S2dpathplanning.OutputName= {'phi'};
S2dpathplanning.InputName= {'VoltageL', 'VoltageR'};

% LQR design

Q_lqr = [0.38 0 0 0; 0 0.43 0 0; 0 0 0.09 0; 0 0 0 0.09];

R_lqr = 0.00017* eye(2); 

[P_lqr,L_lqr, K1] = dare(Ad,Bd,Q_lqr,R_lqr) ;

K1 = -K1 ;

K2= [-1.099 -81.64 -1.368 -10.860; -1.099 -81.64 -1.368 -10.860]; %Further Tuned

K2= -K2;

% Kalman design

P0=  [ 10 0 0 0; 0 10 0 0; 0 0 10 0; 0 0 0 10;];

sigma1= sqrt(0.001); sigma2= sqrt(0.025); sigma3= sqrt(0.025);
sigma4= sqrt(0.005); sigma5= sqrt(0.001); sigma6= sqrt(0.001);

R_k= [sigma5^2, 0; 0, sigma6^2];

Q= [sigma1^2, 0, 0, 0; 0, sigma2^2, 0, 0; 0, 0, sigma3^2, 0; 0, 0, 0, sigma4^2];
