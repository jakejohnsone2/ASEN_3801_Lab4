%% Perterbation Response
clear; clc; close all;

m = .068;
d = .06;
km = .0024;
I = [5.8*10^-5 0 0
    0 7.2*10^-5 0
    0 0 1*10^-4];
nu = 1*10^-3;
mu = 2*10^-6;
g = 9.81;

f = [g*m/4; g*m/4; g*m/4; g*m/4];
Body_motor = [-1 -1 -1 -1
                   -d/sqrt(2) -d/sqrt(2) d/sqrt(2) d/sqrt(2)
                   d/sqrt(2) -d/sqrt(2) -d/sqrt(2) d/sqrt(2)
                   km -km km -km]*f;


Statevector_0 = [0; 0; 10; 0; 0; 0; 0; 0; 0; .1; 0; 0];  % starting at z=10
tspan = [1 10];
col(1) = 'b'; 

[Time, Statevector] = ode45(@(t,statevector) QuadrotorEOM(t, statevector,g,m,I,d,km,nu,mu,f),tspan,Statevector_0);
Statevector = transpose(Statevector);
Body_motor_time = Body_motor.*ones(1,length(Time));



PlotAircraftSim(Time,Statevector,Body_motor_time,1:10,col)


function [Fc, Gc] = RotationDerivativeFeedback(var, m, g)

Fc = 
Gc(1) = 

end 