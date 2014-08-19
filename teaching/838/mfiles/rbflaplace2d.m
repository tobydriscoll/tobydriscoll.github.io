% RBF solution of Laplace's equation in a disk

%% 
% Problem definition (and exact solution)
exact = @(x,y) real( exp(sin(x+1i*y)) );
f = @(x,y) 0*x;          % forcing function
g = @(x,y) exact(x,y);   % Dirichlet boundary condition

%%
% RBF definitions
ep = 3;
phi = @(r) sqrt(1+(ep*r).^2);
Lphi = @(r) ep^2*(2+(ep*r).^2) ./ (1+(ep*r).^2).^1.5;

%%
% Interior nodes/centers
n = round(200*4/pi);
x = 2*haltonseq(n,2)-1;   % uniform in [-1,1]^2
out = (x(:,1).^2 + x(:,2).^2) > 1;
x(out,:) = [];
n = size(x,1);
% Boundary nodes/centers
m = 100;
w = exp(2i*pi*(0:m-1)'/m);
w = [real(w), imag(w)];

%%
% All pairwise distances
R = distmatrix([x;w],[x;w]);  % this is (m+n)x(m+n)

%%
% System matrix and RHS
A = [ Lphi(R(1:n,:)); phi(R(n+(1:m),:)) ];
rhs = [ f(x(:,1),x(:,2)); g(w(:,1),w(:,2)) ];

%%
% Solve system for coefficients
c = A\rhs;

%%
% Create a grid for evaluation, and evaluate.
[R,T] = meshgrid( .05:.05:1, pi*(-40:40)/40 );
Xe = R.*cos(T);  Ye = R.*sin(T);
E = phi( distmatrix([Xe(:) Ye(:)], [x;w]) );
U = E*c;

%%
% Plot result and error
clf, subplot(1,2,1)
U = reshape(U,size(Xe));
surf(Xe,Ye,U)
title('Solution')
subplot(1,2,2)
err = exact(Xe,Ye) - U;  
surf(Xe,Ye,err,log10(abs(err)))
shading interp
view(2), colorbar
title('Error')
