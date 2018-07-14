 function [rho] = ComputeRho(a,x,m,N,h)

rho=0;
for b = 1:N
    rho=rho+m*ComputeW(a,b,x,h); 
end

