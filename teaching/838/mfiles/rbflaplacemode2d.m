% Laplace eigenmodes on an ellipse

%% 
% Domain definition
a = 1;  b = 0.8;   % semiaxes of ellipse

%%
% RBF definitions
ep = 3;
phi = @(r) sqrt(1+(ep*r).^2);
Lphi = @(r) ep^2*(2+(ep*r).^2) ./ (1+(ep*r).^2).^1.5;

%%
% Interior nodes/centers
n = round(300*4/pi);
x = 2*haltonseq(n,2)-1;   % uniform in [-1,1]^2
out = (x(:,1).^2/a^2 + x(:,2).^2/b^2) > 1;
x(out,:) = [];
n = size(x,1);
% Boundary nodes/centers
m = 200;
w = exp(2i*pi*(0:m-1)'/m);
w = [a*real(w), b*imag(w)];

%%
% All pairwise distances
R = distmatrix([x;w],[x;w]);  % this is (m+n)x(m+n)

%%
% Interpolation matrix
P = phi(R);
% PDE/BC matrix 
Q = [ Lphi(R(1:n,:)); phi(R(n+(1:m),:)) ];
% Second matrix to impose boundary conditions in generalized eigenproblem
B = zeros(m+n);  B(1:n,1:n) = eye(n);

%%
% Solve generalized eigenproblem, and sort results
[V,L] = eig(Q,B*P);
lam = diag(L);
[lam,idx] = sort(lam);
V = V(:,idx);

%%
% Convert eigenvectors to collocation values
U = P*V;  

%%
% Create a grid for evaluation, and plot.
[R,T] = meshgrid( (0:30)/30.01, pi*(-40:40)/40 );
Xe = a*R.*cos(T);  Ye = b*R.*sin(T);
node = [x;w];

clf
for k = 1:6
  subplot(2,3,k)
  E = griddata(node(:,1),node(:,2),U(:,k),Xe,Ye,'cubic');
  surf(Xe,Ye,E/max(abs(E(:))))
  title(['\lambda=' num2str(lam(k))])
end
