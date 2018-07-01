function [W]=ComputeW(xi,xj,h)
%kernel of SPH as a function
% of the coordinate particle i and j

% input:  %xi vector coordinate initial particle
          %xj vector coordinate 
          %h  blurring radius
          
% output: W = the force of the particle j effect on the initial i

    W=0;
    x=xi-xj;
    q=norm(x,2)/h;
    C=1/(pi*h*h);
    
    if q>=0 & q<=1
        W=C*(15. / 7.)*(2. / 3. - q*q + 1./2.*q*q*q);
    elseif q >= 1 & q <= 2
        W = C*(5. / 14.)* pow(2 - q, 3);
    end
