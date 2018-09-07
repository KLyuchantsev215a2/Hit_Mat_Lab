rho_0 =1;
v_0 = 0.5;
Time = 10;
h=2;
dt = 0.001;
mu = 2;
k = 5;
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
    S=3*3+3*3;
   %S=H*L;
    m=rho_0*S/N;
    
    %coordinate(particle) initialization
    x=initialization_x(1,N);    
    v=initialization_v(v_0,N);
    
    L=zeros(2,2,N);
    F=zeros(2,2,N);
    SIG=zeros(2,2,N);
    nabla_W=zeros(1,2);
    
    for a = 1:N
      F(1:2,1:2,a)=eye(2);
      SIG(1:2,1:2,a)=ComputeStress(F(1:2,1:2,a),mu,k);
    end
     
    rho=rho_0*ones(1,N);
    
    for i = 1:fix(Time/dt)
                
         for a = 1:N
             for b = 1:N
                for betta = 1:2
                      v(1,1,a)=v(1,1,a)-dt*(m*(SIG(1,betta,a)/rho(1,a)^2+SIG(1,betta,b)/rho(1,b)^2));%можно ли сделать цикл? 
                      v(1,2,a)=v(1,2,a)-dt*(m*(SIG(2,betta,a)/rho(1,a)^2+SIG(2,betta,b)/rho(1,b)^2));
                end
             end
         end
         
         
         for a = 1:N
             for b = 1:N
                for betta = 1:2
                      nabla_W=Compute_nabla_W(a,b,x,h,betta);

                      L(1,betta,a)= (m/rho(1,b)*(v(1,1,b)-v(1,1,a))*nabla_W(betta));  
                      L(2,betta,a)=(m/rho(1,b)*(v(1,2,b)-v(1,2,a))*nabla_W(betta));   
                end
             end
         end
         
         
        for a = 1:N
             %F(:,:,a)= F(:,:,a)+dt* L(:,:,a);    % €вна€ схема Ёйлера
             dtLL = dt* L(:,:,a);
             F(:,:,a)= expm(dtLL)*F(:,:,a);
        end
        for a = 1:N
             SIG(1:2,1:2,a)=ComputeStress(F(1:2,1:2,a),mu,k);
        end
        for a = 1:N
             x(1,1,a)=x(1,1,a)+dt*v(1,1,a);
             x(1,2,a)=x(1,2,a)+dt*v(1,2,a);
             rho(1,a)=ComputeRho(a,x,m,N,h);
        end
     x_coord(1:N) = x(1,1,1:N);
     y_coord(1:N) = x(1,2,1:N);
     scatter(x_coord,y_coord);
            pause(0.001);
    end
    
       disp(x);
    main=F;    