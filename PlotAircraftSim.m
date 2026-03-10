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
        print(fig(1),"Inertial_Position_" + num2str(fig(1)),'-dpng')


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
        print(fig(2),"Euler_Angles_" + num2str(fig(1)),'-dpng')

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
        print(fig(3),"Inertial_Velocity_" + num2str(fig(1)),'-dpng')

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
        print(fig(4),"Angular_Velocity_" + num2str(fig(1)),'-dpng')

        figure(fig(5))
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
        print(fig(5),"Control_Inputs_" + num2str(fig(1)),'-dpng')


        figure(fig(6))
        hold on
        x = aircraft_state_array(1,:);
        y = aircraft_state_array(2,:);
        z = -aircraft_state_array(3,:);   % positive height upward
        plot3(x, y , z)
        plot3(x(1), y(1), z(1), 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 8)  
        plot3(x(end), y(end), z(end), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8)

        xlabel('Inertial x Position (m)')
        ylabel('Inertial y Position (m)')
        zlabel('Inertial Z Position (m)')
        grid on
        view(3)
        print(fig(6),"3d_Position_" + num2str(fig(1)),'-dpng')

    end







end