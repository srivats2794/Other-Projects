A 6 DOF vehicle model. Discrete time model with euler forward integration. Fine enough step time selected to make euler work well. 
Can be compiled into real time code. 

Reference: 

Berntorp, K., Olofsson, B., Lundahl, K., & Nielsen, L. (2014). 
Models and methodology for optimal trajectory generation in safety-critical road-vehicle manoeuvres. 
Vehicle System Dynamics, 52(10), 1304–1332. https://doi.org/10.1080/00423114.2014.939094


Required Data: 

(Fill your own data here and then load it onto your workspace. 
The terms will make sense once you go through the above-mentioned paper)


Ts= 0.001; Tsmall= 0.001;  m=; g=; h= ; epsilon= ; 
l_f= ; l_r= ;
Ixx= ; Iyy= ; Izz= ; 
K_phi= ; K_theta= ; D_phi= ; D_theta= ;
w= ; road= 1; Rw= ; Iw= ; 

%Initial conditions
Vx0= ; omega0= ;

% Ashpalt Front
mu_x_ash_f= ;
mu_y_ash_f= ;
Bx_ash_f= ;
By_ash_f= ;
Cx_ash_f= ;
Cy_ash_f= ;
Ex_ash_f= ;
Ey_ash_f= ;

% Ashpalt rear
mu_x_ash_r= ;
mu_y_ash_r= ;
Bx_ash_r= ; 
By_ash_r= ; 
Cx_ash_r= ;
Cy_ash_r =;
Ex_ash_r= ; 
Ey_ash_r= ; 

% Snow front
mu_x_snow_f= ;
mu_y_snow_f= ;
Bx_snow_f = ; 
By_snow_f= ;
Cx_snow_f= ; 
Cy_snow_f= ; 
Ex_snow_f= ; 
Ey_snow_f= ;

% Snow rear
mu_x_snow_r = ;
mu_y_snow_r=;
Bx_snow_r= ;
By_snow_r= ;
Cx_snow_r= ;
Cy_snow_r= ; 
Ex_snow_r = ;
Ey_snow_r= ;  

DELTA_OFFSET= ;
delta_r= 0;