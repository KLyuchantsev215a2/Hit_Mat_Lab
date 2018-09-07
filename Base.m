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
    N=50;
    S=5*5+5*5;
   %S=H*L;
    m=rho_0*S/N;
    
    %coordinate(particle) initialization
    x=initialization_x(1,N);    
    v=initialization_v(v_0,N);
    
    L=zeros(2,2,N);
    F=zeros(2,2,N);
    SIG=zeros(2,2,N);
    nabla_W=zeros(1,2);
    
    for i = 1:N
      F(1:2,1:2,i)=eye(2);
      SIG(1:2,1:2,i)=ComputeStress(F(1:2,1:2,i),mu,k);
    end
     
    rho=rho_0*ones(1,N);
    
    for n = 1:fix(Time/dt)
                
         for i = 1:N
             for j = 1:N
                for beta = 1:2
                      nabla_W=Compute_nabla_W(i,j,x,h,beta);
                     
                      v(1,1,i)=v(1,1,i)-dt*(m*(SIG(1,beta,i)/rho(1,i)^2+SIG(1,beta,j)/rho(1,j)^2))*nabla_W(beta); 
                      v(1,2,i)=v(1,2,i)-dt*(m*(SIG(2,beta,i)/rho(1,i)^2+SIG(2,beta,j)/rho(1,j)^2))*nabla_W(beta);
                end
             end
         end
         
         
         for i = 1:N
             for j = 1:N
                for beta = 1:2
                      nabla_W=Compute_nabla_W(i,j,x,h,beta);

                      L(1,beta,i)= (m/rho(1,j)*(v(1,1,j)-v(1,1,i))*nabla_W(beta));  
                      L(2,beta,i)=(m/rho(1,j)*(v(1,2,j)-v(1,2,i))*nabla_W(beta));   
                end
             end
         end
         
         
        for i = 1:N
             %F(:,:,a)= F(:,:,a)+dt* L(:,:,a);    % €вна€ схема Ёйлера
             dtLL = dt* L(:,:,i);
             F(:,:,i)= expm(dtLL)*F(:,:,i);
        end
        
        for i = 1:N
             SIG(1:2,1:2,i)=ComputeStress(F(1:2,1:2,i),mu,k);
        end
        
        for i = 1:N
             x(1,1,i)=x(1,1,i)+dt*v(1,1,i);
             x(1,2,i)=x(1,2,i)+dt*v(1,2,i);
             rho(1,i)=ComputeRho(i,x,m,N,h);
        end
        
        x_coord(1:N) = x(1,1,1:N);
        y_coord(1:N) = x(1,2,1:N);
        scatter(x_coord,y_coord);
        pause(0.001);
        
    end
    
    disp(x);
    main=F;    