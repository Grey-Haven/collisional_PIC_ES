% Solving the 2-D Poisson equation by the Finite Difference
...Method 
% Numerical scheme used is a second order central difference in space
...(5-point difference)
%%
%Specifying parameters
nx=Nx;                           %Number of steps in space(x)
ny=Ny;                           %Number of steps in space(y)       
niter=1000;                      %Number of iterations 
dx=2/(nx-1);                     %Width of space step(x)
dy=2/(ny-1);                     %Width of space step(y)
% x=0:dx:2;                        %Range of x(0,2) and specifying the grid points
% y=0:dy:2;                        %Range of y(0,2) and specifying the grid points
% b=zeros(nx,ny);                  %Preallocating b
pn=zeros(nx,ny);                 %Preallocating pn
%%
% Initial Conditions
p=zeros(nx,ny);                  %Preallocating p
%%
%Boundary conditions
p(:,1)=0;
p(:,ny)=0;
p(1,:)=0;                  
p(nx,:)=0;
%%
%Source term
% b(round(ny/4),round(nx/4))=3000;
% b(round(ny*3/4),round(nx*3/4))=-3000;
b = rho_mesh;
%%
i_idx = 2:nx-1;
j_idx = 2:ny-1;
%Explicit iterative scheme with C.D in space (5-point difference)
for it=1:niter
    pn=p;
    p(i_idx,j_idx)=((dy^2*(pn(i_idx+1,j_idx)+pn(i_idx-1,j_idx)))+(dx^2*(pn(i_idx,j_idx+1)+pn(i_idx,j_idx-1)))-(b(i_idx,j_idx)*dx^2*dy*2))/(2*(dx^2+dy^2));
    %Boundary conditions 
    p(:,1)=0;
    p(:,ny)=0;
    p(1,:)=0;                  
    p(nx,:)=0;
end
phi_full = p;
%%
%Plotting the solution
% h=surf(x,y,p','EdgeColor','none');       
% shading interp
% axis([-0.5 2.5 -0.5 2.5 -100 100])
% title({'2-D Poisson equation';['{\itNumber of iterations} = ',num2str(it)]})
% xlabel('Spatial co-ordinate (x) \rightarrow')
% ylabel('{\leftarrow} Spatial co-ordinate (y)')
% zlabel('Solution profile (P) \rightarrow')