function [eigenvals, K3] = CalcK3(K1,K2,mintimeconst,I,g,n)
    %{
    Inputs: K1: K1 value
            K2: K2 Value
            mintimeconst: Minimum time constant
            g: gravitational acceleration
            n: n = 1: Lateral, n = 2: Longitudinal
    Outputs: eigenvalues: Eigenvalues of the system 
             K3: K3 Value
    Methodology: Calculating the gain for K3 using loops in order to reach
                 a desired gain
     %}
    


% Initializing K3
K3 = 0;

% If loop that goes through and calculates A_Cl
if n == 1
    % Lateral system
    A_cl = [0 g 0
            0 0 1
            -K3/I(n,n) -K2/I(n,n) -K1/I(n,n)];
else
    % Longitudinal System
    A_cl = [0 -g 0
            0 0 1
            K3/I(n,n) -K2/I(n,n) -K1/I(n,n)];
end
% Calculate the eigenvalues for the updated A_cl matrix
eigenvals = eig(A_cl);

% Initializing the Time Constant
Time_const = 1/min(abs(eigenvals));

% While loops that go through until the time constant is below 1.25 seconds
% for each system
if n == 1
    % Lateral sytem
    while Time_const>mintimeconst
        % Resetting K3
        K3 = K3+.000001;
        
        % Recalculating A_cl
        A_cl = [0 g 0
            0 0 1
            -K3/I(n,n) -K2/I(n,n) -K1/I(n,n)];
        
        % Recalculating Eigen Values
        eigenvals = eig(A_cl);
        
        % Recalculating Time Constant
        Time_const = 1/min(abs(eigenvals));
    end
else
    % Longitudinal system
    while Time_const>mintimeconst
        % Resetting K3
        K3 = K3+.000001;
        
        % Recalculating A_cl
        A_cl = [0 -g 0
            0 0 1
            K3/I(n,n) -K2/I(n,n) -K1/I(n,n)];
        
        % Recalculating Eigen Values
        eigenvals = eig(A_cl);
        
        % Recalculating Time Constant
        Time_const = 1/min(abs(eigenvals));
    end
end
end