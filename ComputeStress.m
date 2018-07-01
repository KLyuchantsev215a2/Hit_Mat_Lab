function [stress] = ComputeStress(F,mu,k)
% Subroutine which computes Cauchy stress tensor as a function
% of the deformation gradient F
% input:  F = deformation gradient
%         mu = shear modulus
%          k = bulk modulus
% output: stress = Cauchy stresss (true stress)
%
%   neo-Hookean material
%
J = det(F);
B = F*F';  % left Cauchy-Green tensor
Biso = J^(-2/3)*B;    % isochoric part of the stress
devBiso = Biso - 1/3*trace(Biso)*eye(3);   % deviatoric part Biso
stress = 2*mu*devBiso + k*(J-1)*eye(3);