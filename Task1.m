close all
clear
clc
%% Initialization
% Initializing our variables
m = .068;
d = .06;
km = .0024;
I = [5.8*10^-5 0 0
    0 7.2*10^-5 0
    0 0 1*10^-4];
nu = 1*10^-3;
mu = 2*10^-6;
g = 9.81;

%% Task 1 Part 1 through Part 3
% Calculating the force values such that the quadrotor remains at hover
force_values = g*m/4;

% Creating the force values
f = [force_values; force_values; force_values; force_values];
Body_motor = [-1 -1 -1 -1
                   -d/sqrt(2) -d/sqrt(2) d/sqrt(2) d/sqrt(2)
                   d/sqrt(2) -d/sqrt(2) -d/sqrt(2) d/sqrt(2)
                   km -km km -km]*f;

% Initializing values for ode45
Statevector_0 = [0; 0; 10; 0; 0; 0; 0; 0; 0; 0; 0; 0];
tspan = [0 10];
col(1) = 'b'; 

% Simulating the quadrotor at hover
[Time, Statevector] = ode45(@(t,statevector) QuadrotorEOM(t, statevector,g,m,I,d,km,nu,mu,f),tspan,Statevector_0);
Statevector = transpose(Statevector);
Body_motor_time = Body_motor.*ones(1,length(Time));

% Plotting the figure for the quadrotor
PlotAircraftSim(Time,Statevector,Body_motor_time,1:6,col,'1_1','off','Plots1/Plots1/')

%% Part 4 a)

% Initializing conditions
x_dot_e = 5;

% Calculating the angle required
theta_a = atan(-nu*x_dot_e^2/(m*g));

% Calcualting the initial velocities
u = cos(theta_a)*x_dot_e;
w = sin(theta_a)*x_dot_e;

% Calculating the require force
force_values_four = sqrt((m*g)^2+(-nu*x_dot_e^2)^2)/4;

% Creating the force values
f_four = [force_values_four; force_values_four; force_values_four; force_values_four];
Body_motor_four = [-1 -1 -1 -1
                   -d/sqrt(2) -d/sqrt(2) d/sqrt(2) d/sqrt(2)
                   d/sqrt(2) -d/sqrt(2) -d/sqrt(2) d/sqrt(2)
                   km -km km -km]*f_four;

% Initializng the state vecotr
Statevector_0_four_a = [0; 0; 10; 0; theta_a; 0; u; 0; w; 0; 0; 0];

% Simulating and ploting
[Time_four, Statevector_four] = ode45(@(t,statevector) QuadrotorEOM(t, statevector,g,m,I,d,km,nu,mu,f_four),tspan,Statevector_0_four_a);
Body_motor_time_four = Body_motor_four.*ones(1,length(Time_four));
Statevector_four = transpose(Statevector_four);
PlotAircraftSim(Time_four,Statevector_four,Body_motor_time_four,7:12,col,'1_4_a','off','Plots1/Plots4a/')

%% Part 4 b)
% Initializing conditions
x_dot_e = 5;

% Calculating the angle required
psi_a = atan(-nu*x_dot_e^2/(m*g));

% Calcualting the initial velocities
v = -cos(psi_a)*x_dot_e;
w = sin(psi_a)*x_dot_e;

% Calculating the require force
force_values_four_b = sqrt((m*g)^2+(-nu*x_dot_e^2)^2)/4;

% Creating the force values
f_four_b = [force_values_four_b; force_values_four_b; force_values_four_b; force_values_four_b];
Body_motor_four_b = [-1 -1 -1 -1
                   -d/sqrt(2) -d/sqrt(2) d/sqrt(2) d/sqrt(2)
                   d/sqrt(2) -d/sqrt(2) -d/sqrt(2) d/sqrt(2)
                   km -km km -km]*f_four_b;

% Initializng the state vecotr
Statevector_0_four_a = [0; 0; 10; psi_a; 0; pi/2; 0; v; w; 0; 0; 0];

% Simulating and ploting
[Time_four_b, Statevector_four_b] = ode45(@(t,statevector) QuadrotorEOM(t, statevector,g,m,I,d,km,nu,mu,f_four_b),tspan,Statevector_0_four_a);
Body_motor_time_four = Body_motor_four_b.*ones(1,length(Time_four_b));
Statevector_four_b = transpose(Statevector_four_b);
PlotAircraftSim(Time_four_b,Statevector_four_b,Body_motor_time_four,13:18,col,'1_4_b','off','Plots1/Plots4b/')