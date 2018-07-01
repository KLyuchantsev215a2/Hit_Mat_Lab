function [main] = Base(rho,H,L,N,v)
%input:
    %rho = initial density
    %H = height of a plate
    %L = plate width
    %N = number of particles approximating the body
    %v_0 = initial velocity
%outpt:
    %dynamics of the body

    F=eye(3);
    S=H*L;
    m=rho*S/N;
    
    %coordinate(particle) initialization
    main=F;    