% Mass Spring Damper System
clc;
clear all;

load('measurements.mat');
load('input.mat');
% Parameters

k = 10; c= 0.75 ; m = 2; Ts = 0.5; Tsim = 50; x0=[0;0];
t= 0:0.5:50; H= zeros(101,2);

omega_n= sqrt((k/m)); %natural frequency
zeta= c/(2*(sqrt(k*m))); %damping ratio

% Simulate the system

A = [0    1; -k/m  -c/m] ;
    
B = [ 0 ; 1/m] ;

C = eye(2) ;
D = 0;

S=ss(A,B,C,D);

dcgain = 1/dcgain(S) ;

dcgain = dcgain(1);

% Discretization

Sd=c2d(S,Ts) ;

[Ad,Bd,Cd,Dd]=ssdata(Sd);

% State transition
A_inv= inv(A);

e_ATs_1= exp(-(omega_n*zeta)/2)*(cosh((omega_n*(zeta^2 - 1)^(1/2))/2) + (zeta*sinh((omega_n*(zeta^2 - 1)^(1/2))/2))/(zeta^2 - 1)^(1/2));
e_ATs_2= (sin((omega_n*(1 - zeta^2)^(1/2))/2)*exp(-(omega_n*zeta)/2))/(omega_n*(1 - zeta^2)^(1/2));
e_ATs_3= -(omega_n*sin((omega_n*(1 - zeta^2)^(1/2))/2)*exp(-(omega_n*zeta)/2))/(1 - zeta^2)^(1/2);
e_ATs_4= exp(-(omega_n*zeta)/2)*(cosh((omega_n*(zeta^2 - 1)^(1/2))/2) - (zeta*sinh((omega_n*(zeta^2 - 1)^(1/2))/2))/(zeta^2 - 1)^(1/2));

e_ATs= [e_ATs_1 e_ATs_2; e_ATs_3 e_ATs_4];

Ak= e_ATs; aux= e_ATs-eye(2); aux2= mtimes(A_inv,aux); Bk= mtimes(aux2,B);

% variances for white noise: 0.5, 1.2, 0.7, 1

% Least squares estimation

% Generating H matrix
for i=1:101
    H(i,1)= measurements_2.Data(i,1);
end 
for i=1:101
    H(i,2)= input.Data(i,1);
end 
H_trans= H.';
H_inv= inv(mtimes(H_trans,H));
param= mtimes(mtimes(H_inv,H_trans),measurements_2.Data(:,1)).';
phi= param(1,1); gamma= param(1,2);
