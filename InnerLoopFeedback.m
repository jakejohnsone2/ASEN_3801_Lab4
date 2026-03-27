function [Fc, Gc] = InnerLoopFeedback(var)
    %{
    Inputs: var:                    State vector
    Outputs: Fc:                    Upward Force
             Gc                     Aircraft Moments
    Methodology:                    Calculate the controls given the state
                                    variables and calculated gains
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

    % Initializing Variables
    m = .068;
    g = 9.81;
    kp_roll = .00232;
    kd_roll = .001276;
    kp_pitch = .00288;
    kd_pitch = .001584;

    %% Control Law Calculation
    
    % Calculating the controls moments and forces
    Fc = -m*g;
    Gc(1,1) = -kp_roll*phi-kd_roll*p;
    Gc(2,1) = -kp_pitch*theta-kd_pitch*q;
    Gc(3,1) = -r*.004;
end