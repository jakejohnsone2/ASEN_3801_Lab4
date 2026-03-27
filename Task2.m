%% Perterbation Response
clear; clc; close all;


%% Part 1 and 2
% Initializing conditions
m = .068;
d = .06;
km = .0024;
I = [5.8*10^-5 0 0
    0 7.2*10^-5 0
    0 0 1*10^-4];
nu = 1*10^-3;
mu = 2*10^-6;
g = 9.81;

% Initializing forces
f = [g*m/4; g*m/4; g*m/4; g*m/4];
Body_motor = [-1 -1 -1 -1
                   -d/sqrt(2) -d/sqrt(2) d/sqrt(2) d/sqrt(2)
                   d/sqrt(2) -d/sqrt(2) -d/sqrt(2) d/sqrt(2)
                   km -km km -km]*f;
% Initializing graph settings
tspan = 0:.01:10;
col = ['b', 'r']; 

% Initializing the perturbations
Perturbation.one.a = [0; 0; 0; 5*pi/180; 0; 0; 0; 0; 0; 0; 0; 0];
Perturbation.one.b = [0; 0; 0; 0; 5*pi/180; 0; 0; 0; 0; 0; 0; 0];
Perturbation.one.c = [0; 0; 0; 0; 0; 5*pi/180; 0; 0; 0; 0; 0; 0];
Perturbation.one.d = [0; 0; 0; 0; 0; 0; 0; 0; 0; .1; 0; 0];
Perturbation.one.e = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; .1; 0];
Perturbation.one.f = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; .1];

% Setting names
names.one = ["a" "b" "c" "d" "e" "f"];
print_names.one = ["2_12_a" "2_12_b" "2_12_c" "2_12_d" "2_12_e" "2_12_f"];
legend_names.one = ["Non-Linearized Dynamics Model" "Linearized Dynamics Model"];

% For Loop that goes through each perturbation
for i = 1:length(names.one)
    % Calculating the perturbations for part one
    [Time.one.(names.one(i)), Statevector.one.(names.one(i))] = ode45(@(t,statevector) QuadrotorEOM(t,statevector,g,m,I,d,km,nu,mu,f),tspan,Perturbation.one.(names.one(i)));
    Statevector.one.(names.one(i)) = transpose(Statevector.one.(names.one(i)));
    Body_motor_time.one.(names.one(i)) = Body_motor.*ones(1,length(Time.one.(names.one(i))));

    % Calculating the perturbations from part two
    [Time.two.(names.one(i)), Statevector.two.(names.one(i))] = ode45(@(t,statevector) QuadrotorEOM_Linearized(t,statevector,g,m,I,0,zeros(1,3)),tspan,Perturbation.one.(names.one(i)));
    Statevector.two.(names.one(i)) = transpose(Statevector.two.(names.one(i)));
    Body_motor_time.two.(names.one(i)) = Body_motor.*ones(1,length(Time.two.(names.one(i))));
    
    % Combining the perturbation
    Time.onetwo.(names.one(i)) = [Time.one.(names.one(i)) Time.two.(names.one(i))];
    Statevector.onetwo.(names.one(i)) = [Statevector.one.(names.one(i)); Statevector.two.(names.one(i))];
    Body_motor_time.onetwo.(names.one(i)) = [Body_motor_time.one.(names.one(i)); Body_motor_time.two.(names.one(i))];
    
    % Plotting the perturbation
    PlotAircraftSim(Time.onetwo.(names.one(i)),Statevector.onetwo.(names.one(i)),Body_motor_time.onetwo.(names.one(i)),(1:6) +(i-1)*6,col,print_names.one(i),legend_names.one,"Plots2/Plots12/")
end


%% Part 5

% Initializing perturbation conditions

Perturbation.five.d = [0; 0; 0; 0; 0; 0; 0; 0; 0; .1; 0; 0];
Perturbation.five.e = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; .1; 0];
Perturbation.five.f = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; .1];

% Initializing graphing variables
names.five = ["d" "e" "f"];
print_names.five = ["2_5_d" "2_5_e" "2_5_f"];
legend_names.five = ["Uncontrolled" "Controlled"];


for i = 1:length(names.five)
    % Calculating the response to the perturbations
    [Time.five.(names.five(i)), Statevector.five.(names.five(i))] = ode45(@(t,statevector) QuadrotorEOMwithRateFeedback(t,statevector,g,m,I,nu,mu),tspan,Perturbation.five.(names.five(i)));
    Statevector.five.(names.five(i)) = transpose(Statevector.five.(names.five(i)));

    % Calculating the motor forces
    for ii = 1:size(Statevector.five.(names.five(i)),2)
        [Body_motor_time.five.(names.five(i))(1,ii),Body_motor_time.five.(names.five(i))(2:4,ii)] = RotationDerivativeFeedback(Statevector.five.(names.five(i))(:,ii),m,g);
        Fc = Body_motor_time.five.(names.five(i))(1,ii);
        Gc = Body_motor_time.five.(names.five(i))(2:4,ii);
        Motor_forces_time.five.(names.five(i))(:,ii) = ComputeMotorForces(Fc,Gc,d,km);
    end
    % Calculating the motor forces
    for ii = 1:size(Body_motor_time.one.(names.five(i)),2)
        Fc = Body_motor_time.one.(names.five(i))(1,ii);
        Gc = Body_motor_time.one.(names.five(i))(2:4,ii);
        Motor_forces_time.one.(names.five(i))(:,ii) = ComputeMotorForces(Fc,Gc,d,km);
    end

    % Combining the perturbation
    Time.onefive.(names.five(i)) = [Time.one.(names.five(i)) Time.five.(names.five(i))];
    Statevector.onefive.(names.five(i)) = [Statevector.one.(names.five(i)); Statevector.five.(names.five(i))];
    Body_motor_time.onefive.(names.five(i)) = [Body_motor_time.one.(names.five(i)); Body_motor_time.five.(names.five(i))];

    % Plotting the perturbation
    PlotAircraftSim(Time.onefive.(names.five(i)),Statevector.onefive.(names.five(i)),Body_motor_time.onefive.(names.five(i)),(1:6)+(i-1)*6+36,col,print_names.five(i),legend_names.five,"Plots2/Plots5/")
end

% Plotting the individual motor forces
for i = 1:length(names.five)
    figure()

    % Plotting the motor force for the first motor
    subplot(4,1,1)
    hold on
    plot(Time.one.(names.five(i)),Motor_forces_time.one.(names.five(i))(1,:),col(1))
    plot(Time.five.(names.five(i)),Motor_forces_time.five.(names.five(i))(1,:),col(2))
    xlabel('Time (s)')
    ylabel('Force (N)')
    title('Motor 1')
    legend(legend_names.five,'Location','northeastoutside')
    hold off

    % Plotting the motor force for the second motor
    subplot(4,1,2)
    hold on
    plot(Time.one.(names.five(i)),Motor_forces_time.one.(names.five(i))(2,:),col(1))
    plot(Time.five.(names.five(i)),Motor_forces_time.five.(names.five(i))(2,:),col(2))
    xlabel('Time (s)')
    ylabel('Force (N)')
    title('Motor 2')
    legend(legend_names.five,'Location','northeastoutside')
    hold off

    % Plotting the motor force for the third motor
    subplot(4,1,3)
    hold on
    plot(Time.one.(names.five(i)),Motor_forces_time.one.(names.five(i))(3,:),col(1))
    plot(Time.five.(names.five(i)),Motor_forces_time.five.(names.five(i))(3,:),col(2))
    xlabel('Time (s)')
    ylabel('Force (N)')
    title('Motor 3')
    legend(legend_names.five,'Location','northeastoutside')
    hold off

    % Plotting the motor force for the fourth motor
    subplot(4,1,4)
    hold on
    plot(Time.one.(names.five(i)),Motor_forces_time.one.(names.five(i))(4,:),col(1))
    plot(Time.five.(names.five(i)),Motor_forces_time.five.(names.five(i))(4,:),col(2))
    xlabel('Time (s)')
    ylabel('Force (N)')
    title('Motor 4')
    legend(legend_names.five,'Location','northeastoutside')
    hold off

    sgtitle('Motor Forces vs Time')
    print('Plots2\Plots5\Motor_Forces_2_5_' + print_names.five(i),'-dpng')
end
