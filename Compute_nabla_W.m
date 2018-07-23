function [nabla_W]=Compute_nabla_W(a,b,x,h,betta)
%kernel of SPH as a function
% of the coordinate particle i and j

% input:  %a number initial particle
          %b namber calculated particle 
          %h  blurring radius
          %x coordinate all particle 
          %betta normal for the derivative 
% output: W = the force of the particle j effect on the initial i

nabla_W=0;

r=zeros(1, 2);

r(1,1)=x(1,1,a)-x(1,1,b);
r(1,2)=x(1,2,a)-x(1,2,b);

q=norm(r,2)/h;
C=1/(pi*h*h);

if q>=0 & q<=1
  nabla_W=C*(15. / 7.)*(-2*q+3/2*q*q)*(r(1,betta)/(h*norm(r,2)));
elseif q >= 1 & q <= 2
   nabla_W = -C*(5. / 14.)*3*(2 - q)^2*(r(1,betta)/(h*norm(r,2)));
end
