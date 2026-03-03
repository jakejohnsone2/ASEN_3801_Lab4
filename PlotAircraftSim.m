function PlotAircraftSim(time, aircraft_state_array, control_input_array, fig, col)
    
    for i = 1:length(col)
        figure(fig(1))
        hold on
        subplot(3,1,1)
        plot(time,aircraft_state_array(1,:),col(i))
        xlabel('Time (s)')
        ylabel('X Position (m)')
        subplot(3,1,2)
        plot(time,aircraft_state_array(2,:),col(i))
        xlabel('Time (s)')
        ylabel('Y Position (m)')
        subplot(3,1,3)
        plot(time,aircraft_state_array(3,:),col(i))
        xlabel('Time (s)')
        ylabel('Z Position (m)')
        sgtitle('Inertial Position')

        figure(fig(2))
        hold on
        subplot(3,1,1)
        plot(time,aircraft_state_array(4,:),col(i))
        xlabel('Time (s)')
        ylabel('Roll (rad)')
        subplot(3,1,2)
        plot(time,aircraft_state_array(5,:),col(i))
        xlabel('Time (s)')
        ylabel('Pitch (rad)')
        subplot(3,1,3)
        plot(time,aircraft_state_array(6,:),col(i))
        xlabel('Time (s)')
        ylabel('Yaw (rad)')
        sgtitle('Euler angles')

        figure(fig(3))
        hold on
        subplot(3,1,1)
        plot(time,aircraft_state_array(7,:),col(i))
        xlabel('Time (s)')
        ylabel('X Velocity (m/s)')
        subplot(3,1,2)
        plot(time,aircraft_state_array(8,:),col(i))
        xlabel('Time (s)')
        ylabel('Y Velocity (m/s)')
        subplot(3,1,3)
        plot(time,aircraft_state_array(9,:),col(i))
        xlabel('Time (s)')
        ylabel('Z Velocity (m/s)')
        sgtitle('Inertial Velocity in Body Frame')

        figure(fig(4))
        hold on
        subplot(3,1,1)
        plot(time,aircraft_state_array(10,:),col(i))
        xlabel('Time (s)')
        ylabel('Roll Rate (rad/s)')
        subplot(3,1,2)
        plot(time,aircraft_state_array(11,:),col(i))
        xlabel('Time (s)')
        ylabel('Pitch Rate (rad/s)')
        subplot(3,1,3)
        plot(time,aircraft_state_array(12,:),col(i))
        xlabel('Time (s)')
        ylabel('Yaw Rate (rad/s)')
        sgtitle('Angular Velocity')

        figure(fig(4))
        hold on
        subplot(4,1,1)
        plot(time,control_input_array(1,:),col(i))
        xlabel('Time (s)')
        ylabel('Z control (rad/s)')
        subplot(4,1,2)
        plot(time,control_input_array(2,:),col(i))
        xlabel('Time (s)')
        ylabel('Roll Control (rad/s)')
        subplot(4,1,3)
        plot(time,control_input_array(3,:),col(i))
        xlabel('Time (s)')
        ylabel('Pitch Control (rad/s)')
        subplot(4,1,4)
        plot(time,control_input_array(4,:),col(i))
        xlabel('Time (s)')
        ylabel('Yaw Control (rad/s)')
        sgtitle('Control Inputs')


        figure(fig(5))
        hold on
        x = aircraft_state_array(1,:);
        y = aircraft_state_array(2,:);
        z = -aircraft_state_array(3,:);   % positive height upward
        t = linspace(0,1,length(col));
        surface([x; x], ...
        [y; y], ...
        [z; z], ...
        [t; t], ...
        'FaceColor','none', ...
        'EdgeColor','interp', ...
        'LineWidth',2);
        colormap([linspace(1,0,256)' ...
        linspace(0,1,256)' ...
        zeros(256,1)])
        xlabel('Inertial x Position (m)')
        ylabel('Inertial y Position (m)')
        zlabel('Inertial Z Position (m)')
        grid on
        view(3)

    end







end