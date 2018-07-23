function [init] =initialization_v(v_0)
v=zeros(1,2,N);
    for a=1:9
        v(1,1,a)=v_0;
        v(1,2,a)=0;
    end
    
    for a=9:18
        v(1,1,a)=-v_0;
        v(1,2,a)=0;
    end
init=v;