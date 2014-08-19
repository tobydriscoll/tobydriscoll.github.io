% RBF solution of advection-diffusion in a disk

%% 
% Problem definition 
f = @(x,y) ones(size(x));      % forcing function
g = @(x,y) 0*x;                % Dirichlet boundary condition
nu = 0.05;                      % diffusion coefficient

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
Q1 = -nu*Lap_phi(R(1:n,:)) + ep^2*DX(1:n,:,1)./phi(R(1:n,:));
Q2 = phi(R(n+(1:m),:));
% Discrete collocation operator
A = [ Q1;Q2 ] / P;
% RHS of the system
rhs = [ f(x(:,1),x(:,2)); g(w(:,1),w(:,2)) ];

%%
% Solve system for values at nodes
u = A\rhs;

%%
% Create a grid for evaluation, and evaluate.
[R,T] = meshgrid( (0:30)/30.01, pi*(-40:40)/40 );
Xe = R.*cos(T);  Ye = R.*sin(T);
node = [x;w];
clf
U = griddata(node(:,1),node(:,2),u,Xe,Ye,'cubic');
mesh(Xe,Ye,U)
hold on, plot3(node(:,1),node(:,2),u,'k.','markersize',16)
title(['Solution with \nu=' num2str(nu)])

