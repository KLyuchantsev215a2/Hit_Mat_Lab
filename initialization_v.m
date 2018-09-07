function [init] =initialization_v(v_0,N)

v=zeros(1,2,N);
    for a=1:9
        v(1,1,a)=0;
        v(1,2,a)=-v_0;
    end
    
    for a=10:18
        v(1,1,a)=0;
        v(1,2,a)=v_0;
    end
init=v;