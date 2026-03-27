function PlotAircraftSim(time, aircraft_state_array, control_input_array, fig, col, print_name, legend_name, directory_name)
    %{
    Inputs: time:                   time vector (s)
            aircraft_state_array:   12xn Vector containg the state variables
            control_input_array:    4xn Vector containg the control variables
            fig:                    array for the figure number
            col:                    Vector containing the colors for each line
            print_name:             Vector containing the names for each plot
            legend_name:            Vector containing the names for each line
    Outputs:                        Figures
    Methodology:                    Ploting the variables vs time
    %}



    %% Intertial Position
    figure(fig(1))
    
    b = ["-" "--"];


    % Plotting the inertial x position
    subplot(3,1,1)
    hold on
    for i = 1:length(col)
        plot(time(:,1+(i-1)),aircraft_state_array(1+12*(i-1),:),col(i),'LineStyle',b(i))
        xlabel('Time (s)')
        ylabel('X Position (m)')
    end
    legend(legend_name,'Location','northeastoutside')
    hold off
    
    % Plotting the inertial y position
    subplot(3,1,2)
    hold on
    for i = 1:length(col)
        plot(time(:,1+(i-1)),aircraft_state_array(2+12*(i-1),:),col(i),'LineStyle',b(i))
        xlabel('Time (s)')
        ylabel('Y Position (m)')
    end
    legend(legend_name,'Location','northeastoutside')
    hold off
    
    % Plotting the inertial z position
    subplot(3,1,3)
    hold on
    for i = 1:length(col)
        subplot(3,1,3)
        plot(time(:,1+(i-1)),aircraft_state_array(3+12*(i-1),:),col(i),'LineStyle',b(i))
        xlabel('Time (s)')
        ylabel('Z Position (m)')
    end
    legend(legend_name,'Location','northeastoutside')
    hold off
    sgtitle('Inertial Position')
    print(fig(1),directory_name + "Inertial_Position_" + print_name,'-dpng')
    

    %% Euler Angles
    figure(fig(2))

    % Plotting the roll euler angle
    subplot(3,1,1)
    hold on
    for i = 1:length(col)
        plot(time(:,1+(i-1)),aircraft_state_array(4+12*(i-1),:),col(i),'LineStyle',b(i))
        xlabel('Time (s)')
        ylabel('Roll (rad)')
    end
    legend(legend_name,'Location','northeastoutside')
    hold off
    
    % Plotting the pitch euler angle
    subplot(3,1,2)
    hold on
    for i = 1:length(col)
        plot(time(:,1+(i-1)),aircraft_state_array(5+12*(i-1),:),col(i),'LineStyle',b(i))
        xlabel('Time (s)')
        ylabel('Pitch (rad)')
    end
    legend(legend_name,'Location','northeastoutside')
    hold off
    
    % Plotting the yaw euler angle
    subplot(3,1,3)
    hold on
    for i = 1:length(col)
        plot(time(:,1+(i-1)),aircraft_state_array(6+12*(i-1),:),col(i),'LineStyle',b(i))
        xlabel('Time (s)')
        ylabel('Yaw (rad)')
    end
    hold off
    legend(legend_name,'Location','northeastoutside')
    sgtitle('Euler angles')
    print(fig(2),directory_name + "Euler_Angles_" + print_name,'-dpng')
    
    %% Body Velocity
    figure(fig(3))

    % Plotting the x body velocity
    subplot(3,1,1)
    hold on
    for i = 1:length(col)
        plot(time(:,1+(i-1)),aircraft_state_array(7+12*(i-1),:),col(i),'LineStyle',b(i))
        xlabel('Time (s)')
        ylabel('X Velocity (m/s)')
    end
    legend(legend_name,'Location','northeastoutside')
    hold off
    
    % Plotting the y body velocity
    subplot(3,1,2)
    hold on
    for i = 1:length(col)
        plot(time(:,1+(i-1)),aircraft_state_array(8+12*(i-1),:),col(i),'LineStyle',b(i))
        xlabel('Time (s)')
        ylabel('Y Velocity (m/s)')
    end
    legend(legend_name,'Location','northeastoutside')
    hold off
    
    % Plotting the z body velocity
    subplot(3,1,3)
    hold on
    for i = 1:length(col)
        plot(time(:,1+(i-1)),aircraft_state_array(9+12*(i-1),:),col(i),'LineStyle',b(i))
        xlabel('Time (s)')
        ylabel('Z Velocity (m/s)')
    end
    legend(legend_name,'Location','northeastoutside')
    hold off
    sgtitle('Inertial Velocity in Body Frame')
    print(fig(3),directory_name + "Inertial_Velocity_" + print_name,'-dpng')
    
    %% Rotation Rate
    figure(fig(4))

    % Plotting the rotational rate about the x axis
    subplot(3,1,1)
    hold on
    for i = 1:length(col)
        plot(time(:,1+(i-1)),aircraft_state_array(10+12*(i-1),:),col(i),'LineStyle',b(i))
        xlabel('Time (s)')
        ylabel('Roll Rate (rad/s)')
        end
    legend(legend_name,'Location','northeastoutside')
    hold off
    
    % Plotting the rotational rate about the y axis
    subplot(3,1,2)
    hold on
    for i = 1:length(col)
        plot(time(:,1+(i-1)),aircraft_state_array(11+12*(i-1),:),col(i),'LineStyle',b(i))
        xlabel('Time (s)')
        ylabel('Pitch Rate (rad/s)')
    end
    legend(legend_name,'Location','northeastoutside')
    hold off
    
    % Plotting the rotational rate about the z axis
    subplot(3,1,3)
    hold on
    for i = 1:length(col)
        plot(time(:,1+(i-1)),aircraft_state_array(12+12*(i-1),:),col(i),'LineStyle',b(i))
        xlabel('Time (s)')
        ylabel('Yaw Rate (rad/s)')
    end
    legend(legend_name,'Location','northeastoutside')
    hold off
    sgtitle('Angular Velocity')
    print(fig(4),directory_name + "Angular_Velocity_" + print_name,'-dpng')
    
    %% Motor Controls
    figure(fig(5))

    % Plotting the body z force
    subplot(4,1,1)
    hold on
    for i = 1:length(col)
        plot(time(:,1+(i-1)),control_input_array(1+4*(i-1),:),col(i),'LineStyle',b(i))
        xlabel('Time (s)')
        ylabel('Z control (rad/s)')
    end
    legend(legend_name,'Location','northeastoutside')
    hold off
    
    % Plotting the body x moment
    subplot(4,1,2)
    hold on
    for i = 1:length(col)
        subplot(4,1,2)
        plot(time(:,1+(i-1)),control_input_array(2+4*(i-1),:),col(i),'LineStyle',b(i))
        xlabel('Time (s)')
        ylabel('Roll Control (rad/s)')
    end
    legend(legend_name,'Location','northeastoutside')
    hold off
    
    % Plotting the body y moment
    subplot(4,1,3)
    hold on
    for i = 1:length(col)
        plot(time(:,1+(i-1)),control_input_array(3+4*(i-1),:),col(i),'LineStyle',b(i))
        xlabel('Time (s)')
        ylabel('Pitch Control (rad/s)')
    end
    legend(legend_name,'Location','northeastoutside')
    hold off
    
    % Plotting the body z moment
    subplot(4,1,4)
    hold on
    for i = 1:length(col)
        plot(time(:,1+(i-1)),control_input_array(4+4*(i-1),:),col(i),'LineStyle',b(i))
        xlabel('Time (s)')
        ylabel('Yaw Control (rad/s)')
    end
    legend(legend_name,'Location','northeastoutside')
    hold off
    sgtitle('Control Inputs')
    print(fig(5),directory_name + "Control_Inputs_" + print_name,'-dpng')
    
    %% 3d Position
    figure(fig(6))
    hold on
    for i = 1:length(col)
        figure(fig(6))
        hold on
        x(:,1) = aircraft_state_array(1+12*(i-1),:);
        y(:,1) = aircraft_state_array(2+12*(i-1),:);
        z(:,1) = -aircraft_state_array(3+12*(i-1),:);   % positive height upward
        plot3(x, y , z,'LineWidth',2,'Color',col(i),'LineStyle',b(i))
        plot3(x(1,1), y(1,1), z(1,1), 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 8,'HandleVisibility','off')  
        plot3(x(end,1), y(end,1), z(end,1), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'HandleVisibility','off','Marker','*')
        
        ax = gca;
        ax.YDir = 'reverse';
        xlabel('Inertial x Position (m)')
        ylabel('Inertial y Position (m)')
        title('3D Position of Quadrotor')
        zlabel('Inertial Z Position (m)')
        grid on
        view(3)
        print(fig(6),directory_name + "3d_Position_" + print_name,'-dpng')

    end
    hold off

    legend(legend_name,'Location','northoutside')
    





end