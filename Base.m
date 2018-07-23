function [main] = Base(rho_0,H,L,v_0,Time,h,dt,mu,k)
%input:
    %rho = initial density
    %H = height of a plate
    %L = plate width
    %N = number of particles approximating the body for now 9+9=18
    %v_0 = initial velocity
%outpt:
    %dynamics of the body
    %mu,k the constants of the material for the generalized Hooke Law
    N=18;
    mu=1;
    k=1;
    S=3*3+3*3;
   %S=H*L;
    m=rho_0*S/N;
    
    %coordinate(particle) initialization
    x=initialization_x(1);    
    v=initialization_v(v_0);
    
    L=zeros(2,2,N);
    F=zeros(2,2,N);
    nabla_W=zeros(2);
    for a = 1:N
      F(1:2,1:2,a)=eye(2);
    end
    
    SIG=zeros(2,2,N); 
    rho=rho_0*ones(N);
    
    for i = 1:fix(Time/dt)
        
         v_tmp=v;
         
         
         for a = 1:N
             SIG(1:2,1:2,a)=ComputeStress(F(1:2,1:2,a),mu,k);
             x(1:2,a)=x(1:2,a)+dt*v(1:2,a);
         end
         
         for a = 1:N
             for b = 1:N
                for betta = 1:2
                      nabla_W(betta)=Compute_nabla_W(a,b,x,h,betta);
                      v(1,1,a)=v(1,1,a)-dt*(m(SIG(1,betta,a)/rho(a)^2+SIG(1,betta,b)/rho(b)^2));%можно ли сделать цикл? 
                      v(1,2,a)=v(1,2,a)-dt*(m(SIG(1,betta,a)/rho(a)^2+SIG(1,betta,b)/rho(b)^2));
                      
                      L(1,betta,a)=m/rho(b)*(v_tmp(1,1,b)-v_tmp(1,1,a))*nabla_W(betta);  
                      L(2,betta,a)=m/rho(b)*(v_tmp(1,2,b)-v_tmp(1,2,a))*nabla_W(betta);          
                end
             end
         end
    end
    
    main=F;    