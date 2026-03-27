function var_dot = QuadrotorEOM_Linearized_InnerLoop(t, var, g, m, I)
    %{
    Inputs: t:             time
            var:           12x1 statevector
            g:             gravity
            m:             mass
            I:             Inertia Matrix
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
    
    
    % Calculating the forces and moments
    [Zc, Gc] = InnerLoopFeedback(var);
    Zc = Zc - (-m*g);
    Lc = Gc(1);
    Mc = Gc(2);
    Nc = Gc(3);
    
    %% Calculating the Linearized equations

    var_dot(1,1) = u;
    var_dot(2,1) = v;
    var_dot(3,1) = w;
    var_dot(4,1) = p;
    var_dot(5,1) = q;
    var_dot(6,1) = r;
    var_dot(7,1) = -g*theta;
    var_dot(8,1) = g*phi;
    var_dot(9,1) = 1/m*Zc;
    var_dot(10,1) = 1/Ix*Lc;
    var_dot(11,1) = 1/Iy*Mc;
    var_dot(12,1) = 1/Iz*Nc;

end