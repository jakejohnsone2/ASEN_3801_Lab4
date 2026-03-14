function motor_forces = ComputeMotorForces(Fc,Gc,d,km)
     %{
    Inputs: Fc:            Motor force
            Gc:            Motor Moments
            d:             radial distance
            km:            moment coefficien
    Outputs: motor_forces: forces each motor is outputing     
    Methodology:           Using given equations to calculate the
                           individual motor forces
     %}
    
    % Calculating the matrix
    matrix = [-1 -1 -1 -1
              -d/sqrt(2) -d/sqrt(2) d/sqrt(2) d/sqrt(2)
              d/sqrt(2) -d/sqrt(2) -d/sqrt(2) d/sqrt(2)
              km -km km -km];
    % Calculating the motor forces
    motor_forces = (matrix^-1) * [Fc; Gc];




end