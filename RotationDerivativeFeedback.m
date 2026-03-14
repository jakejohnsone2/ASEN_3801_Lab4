function [Fc, Gc] = RotationDerivativeFeedback(var, m, g)
%{
    Inputs: var:           12x1 statevector
            m:             mass (kg)
            g:             Gravitational Acceleration (m/s^2)

    Outputs: Fc:           Body z force
             Gc:           3x1 Vector containing the body moments
    Methodology:           Use given gains and weight to calculate the
                           respective forces and moments.
    %}

% Calculating the Force
Fc = -m*g;

% Calculating the rotational components
Gc(1) = -var(10)*.004;
Gc(2) = -var(11)*.004;
Gc(3) = -var(12)*.004;

end 