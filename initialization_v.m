function [init] =initialization_v(v_0,N)

v=zeros(1,2,N);
    for i=1:25
        v(1,1,i)=0;
        v(1,2,i)=-v_0;
    end
    
    for i=26:50
        v(1,1,i)=0;
        v(1,2,i)=v_0;
    end
init=v;