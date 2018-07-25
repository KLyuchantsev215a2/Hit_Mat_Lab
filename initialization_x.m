function [init] =initialization_x(flag,N) %initialization(L,H,N,flag)
%for now size fixed (2,2)
%flag 1 -upper plate -1 -lower plate
%N_y = fix(sqrt(N*L/H));
%N_x = fix( N / N_y);
a=1;
x=zeros(1,2,N);

for  i=1:3
    for  j=1:3
        x(1,1,a) =i;
        x(1,2,a) =j;
        a=a+1;
    end
end

for  i=1:3
    for  j=1:3
        x(1,1,a) =-i*flag;
        x(1,2,a) =-j*flag;
        a=a+1;
    end
end
init=x;