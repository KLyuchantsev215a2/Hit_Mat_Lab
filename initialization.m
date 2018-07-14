function [init] = initialization(L,H,N)

N_y = fix(sqrt(N*L/H));
N_x = fix( N / N_y);

for  a=1:N
	x(1,1,a) = (a-fix(a/N_x)*N_x)*L/N_x;
	x(1,2,a) = (fix(a / N_x) )*H / N_y;
end
 
init=x;