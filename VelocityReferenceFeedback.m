function [Fc,Gc] = VelocityReferenceFeedback(t,var,n)
    %{
    Inputs: t:             time
            var:           12x1 statevector
            n:             n=1: Latitude, n=2: Longitude
    Outputs: Fc:           Upward force
             Gc:           Moment vector
    Methodology:           Use variabvles and functions to calculate the
                           reactive forces and moments
    %}



    % Initializing conditions
    m = .068;
    I = [5.8*10^-5 0 0
        0 7.2*10^-5 0
        0 0 1*10^-4];
    g = 9.81;
    mintimeconst_lat = 1.25;
    k2_lat = 40*I(1,1);
    k1_lat = 22*I(1,1);
    k2_long = 40*I(2,2);
    k1_long =  22*I(2,2);

    % Extracting variables
    phi = var(4);
    theta = var(5);
    u = var(7);
    v = var(8);
    p = var(10);
    q = var(11);
    r = var(12);
    
    % Calculating K3
    [~, k3_lat] = CalcK3(k1_lat,k2_lat,mintimeconst_lat,I,g,1);
    [~, k3_long] = CalcK3(k1_long,k2_long,mintimeconst_lat,I,g,2);

    % If statement that sets up the reference velocities
    if t>= 0 && t<=2 && n==1
        % Latitude
        u_ref = 0;
        v_ref = 0.5;
    elseif t>= 0 && t<=2 && n==2
        % Longitude
        u_ref = 0.5;
        v_ref = 0;
    else
        % Removing the reference velocity
        u_ref = 0;
        v_ref = 0;
    end
    
    % Calculating the forces and Moments
    Fc = -m*g;
    Lc = -k1_lat*p - k2_lat*phi + k3_lat*(v_ref - v);
    Mc = -k1_long*q - k2_long*theta - k3_long*(u_ref - u);
    Nc = -.004*r;
    Gc = [Lc; Mc; Nc];

end