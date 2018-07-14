function [W]=ComputeW(a,b,x,h)
%kernel of SPH as a function
% of the coordinate particle i and j

% input:  %xi vector coordinate initial particle
          %xj vector coordinate 
          %h  blurring radius
          
% output: W = the force of the particle j effect on the initial i

W=0;

x_ab=zeros(1, 2);

x_ab(1,1)=x(1,1,a)-x(1,1,b);
x_ab(1,2)=x(1,2,a)-x(1,2,b);

q=norm(x_ab,2)/h;
C=1/(pi*h*h);

if q>=0 & q<=1
    W=C*(15. / 7.)*(2. / 3. - q*q + 1./2.*q*q*q);
elseif q >= 1 & q <= 2
    W = C*(5. / 14.)* pow(2 - q, 3);
end
