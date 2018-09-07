function [init] =initialization_x(flag,N) %initialization(L,H,N,flag)
%for now size fixed (2,2)
%flag 1 -upper plate -1 -lower plate
%N_y = fix(sqrt(N*L/H));
%N_x = fix( N / N_y);
i=1;
x=zeros(1,2,N);

for  xi=1:5
    for  yi=1:5
        x(1,1,i) =xi;
        x(1,2,i) =yi;
        i=i+1;
    end
end

for  xi=1:5
    for  yi=1:5
        x(1,1,i) =xi*flag;
        x(1,2,i) =-yi*flag;
        i=i+1;
    end
end
init=x;