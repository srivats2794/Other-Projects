Model based development of LQR Controller with Kalman filter 

1. A physics based model of a 2 wheel inverted pendulum was created.

2. Pole placement was performed and a LQR controller was designed for segway stability.

3. Kalman filter was designed for state estimation using IMU and encoder data. 

4. The code was implemented in an EV3 lego robot which was configured in a self balancing mode. 
Simulink Real-Time Workshop was used to generate and load code into the EV3.  


Running the system:

Run 'singleinvertedpendulum.m' and then run "singleinvertedpendulumsim". 
Once you are ready to compile to EV3, build "lego_code".