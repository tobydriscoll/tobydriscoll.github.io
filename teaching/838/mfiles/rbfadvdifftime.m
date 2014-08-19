% RBF solution of time-dependent advection-diffusion in a disk
% Homogeneous Dirichlet boundary conditions

%% 
% Problem definition 
f = @(x,y) ones(size(x));      % forcing function
nu = 0.08;                    % diffusion coefficient
u0 = @(x,y) 0*x;               % initial condition

%%
% RBF definitions
ep = 5;
phi = @(r) sqrt(1+(ep*r).^2);
Lap_phi = @(r) ep^2*(2+(ep*r).^2) ./ (1+(ep*r).^2).^1.5;

%%
% Interior nodes/centers
n = round(500*4/pi);
x = 2*haltonseq(n,2)-1;   % uniform in [-1,1]^2
out = (x(:,1).^2 + x(:,2).^2) > 1;
x(out,:) = [];
n = size(x,1);
% Boundary nodes/centers
m = 200;
w = exp(2i*pi*(0:m-1)'/m);
w = [real(w), imag(w)];

%%
% All pairwise distances (and differences)
[R,DX] = distmatrix([x;w],[x;w]);  % R is (m+n)x(m+n)

%%
% Interpolation matrix
P = phi(R);
% Evaluate Lap(phi) + dphi_dx at interior nodes.
% In order to compute dphi_dx, we need to use the x coordinate of all 
% pairwise differences.
Q1 = nu*Lap_phi(R(1:n,:)) - ep^2*DX(1:n,:,1)./phi(R(1:n,:));
% Discrete collocation operator
A = Q1 / P;
% Reduce size by removing the boundary nodes
A = A(:,1:n);

%%
% Define the ODE 
b = f(x(:,1),x(:,2));
timeder = @(t,u) A*u + b;

%%
% Create a grid for evaluation.
[R,T] = meshgrid( (0:30)/30.01, pi*(-40:40)/40 );
Xe = R.*cos(T);  Ye = R.*sin(T);
node = [x;w]; 
clf, set(gcf,'doublebuf','on')

%% 
% RK4 in time
% dt = 0.0025;
% u = u0(x(:,1),x(:,2));
% for k = 1:ceil(50/dt)
%   t = k*dt;
%   s1 = dt*timeder(t,u);
%   s2 = dt*timeder(t+0.5*dt,u+s1/2);
%   s3 = dt*timeder(t+0.5*dt,u+s2/2);
%   s4 = dt*timeder(t+dt,u+s3);
%   u = u + (s1+2*(s2+s3)+s4)/6;
%   if rem(k,5)==0  % plot every 5 steps
%     U = griddata(node(:,1),node(:,2),[u;0*w(:,1)],Xe,Ye,'cubic');
%     mesh(Xe,Ye,U)
%     title(['t=' num2str(t)]), drawnow
%   end
% end

%%
% Integrate system in time
[t,u] = ode15s(timeder,[0:.04:5],u0(x(:,1),x(:,2)));
zmax = max(u(:));
for k = 1:length(t)
  U = griddata(node(:,1),node(:,2),[u(k,:)';0*w(:,1)],Xe,Ye,'cubic');
  mesh(Xe,Ye,U), axis([-1 1 -1 1 0 zmax]), caxis([0 zmax])
  title(['t=' num2str(t(k))]), drawnow
end

