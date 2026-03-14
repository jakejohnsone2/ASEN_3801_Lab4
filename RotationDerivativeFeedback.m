function [Fc, Gc] = RotationDerivativeFeedback(var, m, g)

Fc = m*g;
Gc(1) = -var(10)*.004;
Gc(2) = -var(11)*.004;
Gc(3) = -var(12)*.004;

end 