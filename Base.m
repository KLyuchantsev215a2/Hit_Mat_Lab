%input:
    %rho = initial density
    %H = height of a plate
    %L = plate width
    %N = number of particles approximating the body for now 9+9=18
    %v_0 = initial velocity
%outpt:
    %dynamics of the body
    %mu,k the constants of the material for the generalized Hooke Law
    %E- elastic modulus for materials
rho_0 =1;
v_0 = 10;
Time = 10;
h=2;
dt = 0.001;
mu = 2;
k = 5;
E=500;
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
                      PI=ComputeViscocity(x,v,rho,i,j,h,E);
                      v=ComputeVelocity(i,j,beta,dt,m,v,rho,SIG,PI,nabla_W);
                end
             end
         end
         
         
         for i = 1:N
             for j = 1:N
                for beta = 1:2
                      nabla_W=Compute_nabla_W(i,j,x,h,beta);
                      L=ComputeL(i,j,beta,m,v,rho,nabla_W);  
                end
             end
         end
         
         
        for i = 1:N
            % F(1:2,1:2,i)= F(1:2,1:2,i)+dt* L(1:2,1:2,i);    
             dtLL = dt* L(1:2,1:2,i);
             F(1:2,1:2,i)= expm(dtLL)*F(1:2,1:2,i);
        end
        
        for i = 1:N
             SIG(1:2,1:2,i)=ComputeStress(F(1:2,1:2,i),mu,k);
        end
        
        for i = 1:N
             x(1,1,i)=x(1,1,i)+dt*v(1,1,i);
             x(1,2,i)=x(1,2,i)+dt*v(1,2,i);
        end
        
        for i = 1:N
             rho(1,i)=ComputeRho(i,x,m,N,h);
        end
            
       
        x_coord(1:N) = x(1,1,1:N);
        y_coord(1:N) = x(1,2,1:N);
        subplot(2,2,1);
        scatter(x_coord,y_coord);
       
        
       detF=ones(1,N);
       for i = 1:N
              detF(1,i)=det(F(1:2,1:2,i))*100;
       end
       
        tri=delaunay(x_coord,y_coord);
        subplot(2,2,2);
        trisurf(tri,x_coord,y_coord,detF);
        
        subplot(2,2,3);
        trisurf(tri,x_coord,y_coord,rho);
        pause(0.00001);
        
    end
    
    disp(x);
    main=F;    
