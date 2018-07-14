function [main] = Base(rho,H,L,N,v_0,Time,h,dt,mu,k)
%input:
    %rho = initial density
    %H = height of a plate
    %L = plate width
    %N = number of particles approximating the body
    %v_0 = initial velocity
%outpt:
    %dynamics of the body
    %mu,k the constants of the material for the generalized Hooke Law
    mu=1;
    k=1;
    S=H*L;
    m=rho*S/N;
    
    %coordinate(particle) initialization
    x_upper=zeros(1, 2,N);    
    x_lower=zeros(1, 2,N);    
    
    v_upper= -v_0*ones(1,2,N);
    v_lower=  v_0*ones(1,2,N);
    
    L_upper=zeros(2,2,N);
    L_lower=zeros(2,2,N);
    
    F_upper=zeros(2,2,N);
    F_lower=zeros(2,2,N);
    
    for a = 1:N
      F_upper(1:2,1:2,a)=eye(2);
    end
    
    SIG_upper=zeros(2,2,N);
    SIG_lower=zeros(2,2,N);
    
    rho_upper=zeros(1,N);
    rho_lower=zeros(1,N);
    
    for i = 1:fix(Time/dt)
         for a = 1:N
             SIG_upper(1:2,1:2,a)=ComputeStress(F_upper(1:2,1:2,a),mu,k);
             SIG_lower(1:2,1:2,a)=ComputeStress(F_lower(1:2,1:2,a),mu,k);
         end
         
    end
    
    main=F;    