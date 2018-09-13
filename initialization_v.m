function [init] =initialization_v(v_0,N,sqn)

v=zeros(1,2,N);
    for i=1:(sqn*sqn)
        v(1,1,i)=0;
        v(1,2,i)=-v_0;
    end
    
    for i=(sqn*sqn+1):sqn*sqn*2
        v(1,1,i)=0;
        v(1,2,i)=v_0;
    end
init=v;