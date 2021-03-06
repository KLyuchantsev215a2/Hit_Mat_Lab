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
    clear;
    
rho_0 =1.2;
v_0 = 2;
Time = 10;
mu = 1000;             % ������ ������
k = 10000;              % �-� ��������� ������
E=9*k*mu/(3*k+mu);   % ������ ����
sqn=6;
N=sqn*sqn*2;
S=10^(-4)*2;
%S=H*L;
m=rho_0*S/N;
fr=10;
h=(m/rho_0)^(1/2);
dt=0.01*h/v_0;
    %coordinate(particle) initialization
    x=initialization_x(1,N,sqn);    
    v=initialization_v(v_0,N,sqn);
    
    
    F=zeros(2,2,N);
    SIG=zeros(2,2,N);
    nabla_W=zeros(1,2);
    
    for i = 1:N
      F(1:2,1:2,i)=eye(2);
      SIG(1:2,1:2,i)=ComputeStress(F(1:2,1:2,i),mu,k);
    end
     
    rho=rho_0*ones(1,N);
    
    for n = 1:fix(Time/dt)
                L=zeros(2,2,N);
         for i = 1:N
             for j = 1:N
                for beta = 1:2
                      nabla_W=Compute_nabla_W(i,j,x,h,beta);
                      PI=0;%ComputeViscocity(x,v,rho,i,j,h,E,mu);
                      v=ComputeVelocity(i,j,beta,dt,m,v,rho,SIG,PI,nabla_W);
                end
             end
         end
         
         
         for i = 1:N
             for j = 1:N
                for beta = 1:2
                      nabla_W=Compute_nabla_W(i,j,x,h,beta);
                      L=ComputeL(L,i,j,beta,m,v,rho,nabla_W);  
                end
             end
         end
         
         
        for i = 1:N
              %F(1:2,1:2,i)= F(1:2,1:2,i)+dt* L(1:2,1:2,i)*F(1:2,1:2,i);  
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
            
        if (fix(n/fr)==n/fr)
         x_coord(1:N) = x(1,1,1:N);
         y_coord(1:N) = x(1,2,1:N);
         subplot(2,2,1);
         scatter(x_coord,y_coord,'black');
       
        
         detF=ones(1,N);
         detSIG=ones(1,N);
         for i = 1:N
                 detF(1,i)=det(F(1:2,1:2,i));
         end
         
         for i = 1:N
                 detSIG(1,i)=det(SIG(1:2,1:2,i));
         end
       
         tri=delaunay(x_coord,y_coord);
         subplot(2,2,2);
          trisurf(tri,x_coord,y_coord,detF);
        
         subplot(2,2,3);
         trisurf(tri,x_coord,y_coord,rho(1:N));
         
         subplot(2,2,4);
         trisurf(tri,x_coord,y_coord,detSIG);
         pause(0.0000001);
        
         
     end
    end
    main=F;    
