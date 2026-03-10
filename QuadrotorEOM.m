function var_dot = QuadrotorEOM(t, var, g, m, I, d, km, nu, mu, motor_forces)
    %{
    Inputs: t:             time
            var:           12x1 statevector
            g:             gravity
            m:             mass
            I:             Inertia Matrix
            d:             motor distance from center
            km:            Control moment coefficient
            nu             Aerodynamic force coefficient
            mu:            Aerodynamic moment coefficient
            motor_forces:  4x1 force vector
    Outputs: var_dot:      change in variables contained in the statevector
    Methodology:           Use Equations of motions to simulate the 
                           reactions of a quadrotor.
    %}



    %% Initialization
    % Extracting our variables from the statevector
    x_e = var(1);
    y_e = var(2);
    z_e = var(3);
    phi = var(4);
    theta = var(5);
    psi = var(6);
    u = var(7);
    v = var(8);
    w = var(9);
    p = var(10);
    q = var(11);
    r = var(12);
    
    % Extracting values from the inertia matrix
    Ix = I(1,1);
    Iy = I(2,2);
    Iz = I(3,3);
    
    % Calculating the force due to aerodynamic effects
    X = -nu*norm([u v w])*u;
    Y = -nu*norm([u v w])*v;
    Z = -nu*norm([u v w])*w;
    
    % Calculating the moment due to aerodynamic effects
    L = -mu*norm([p q r])*p;
    M = -mu*norm([p q r])*q;
    N = -mu*norm([p q r])*r;
    
    % Calculating the controls vector
    Body_motor = [-1 -1 -1 -1
                   -d/sqrt(2) -d/sqrt(2) d/sqrt(2) d/sqrt(2)
                   d/sqrt(2) -d/sqrt(2) -d/sqrt(2) d/sqrt(2)
                   km -km km -km]*motor_forces;

    % Extracting the control forces and moments
    Zc = Body_motor(1);
    Lc = Body_motor(2);
    Mc = Body_motor(3);
    Nc = Body_motor(4);


    % Calculating the dcm
    DCM = [cos(theta)*cos(psi) sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi) cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi)
           cos(theta)*sin(psi) sin(phi)*sin(theta)*sin(psi)-cos(phi)*cos(psi) cos(phi)*sin(theta)*sin(psi)+sin(phi)*cos(psi)
           -sin(theta) sin(phi)*cos(theta) cos(phi)*cos(theta)];
    
    %% Calculating the change in the variables
    % Calculating the change in inertial position of our quadrotor
    var_dot(1:3,1) = DCM*var(7:9);
    
    % Calculating the change in euler angles of our quadrotor
    var_dot(4:6,1) = [1 sin(phi)*tan(theta) cos(phi)*tan(theta)
                       0 cos(phi) -sin(phi)
                       0 sin(phi)*sec(theta) cos(phi)*sec(theta)]*var(10:12);

    % Calculating the change in velocity of our quadrotor
    var_dot(7:9,1) = [r*v-q*w-g*sin(theta)+1/m*X
                      p*w-r*u+g*cos(theta)*sin(phi)+1/m*Y
                      q*u-p*v+g*cos(theta)*cos(phi)+1/m*(Z+Zc)];

    % Calculating the change in rotational velocity of our quadrotot
    var_dot(10:12,1) = [(Iy-Iz)/Ix*q*r+1/Ix*(L+Lc)
                        (Iz-Ix)/Iy*p*r+1/Iy*(M+Mc)
                        (Ix-Iy)/Iz*p*q+1/Iz*(N+Nc)];


end