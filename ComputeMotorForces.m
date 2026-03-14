function motor_forces = ComputeMotorForces(Fc,Gc,d,km)

    matrix = [-1 -1 -1 -1
              -d/sqrt(2) -d/sqrt(2) d/sqrt(2) d/sqrt(2)
              d/sqrt(2) -d/sqrt(2) -d/sqrt(2) d/sqrt(2)
              km -km km -km];
    motor_forces = (matrix^-1) * [Fc; Gc];




end