% Compactly supported RBF interpolation in 3D

%%
% Exact function to sample
g = @(x) ones(size(x(:,1)));

%%
% The CS RBF (Wendland's phi_3,1), expressed as a function of
% u = 1-ep*r, and assuming truncation for negative u.
phi = @(u) u.^4 .* (5*spones(u)-4*u);
radius = .1;

%%
% Choose nodes
n = 5000;  
ctr = haltonseq(n,3);  % uniform
val = g(ctr);  % sample

%%
% Interpolation matrix
U = distmatrixcs(ctr,ctr,radius);
A = phi(U);

%%
% Solve system for coefficients
c = A\val;

%%
% Create a grid for evaluation, and evaluate.
xe = 0:1/20:1;
[X1,X2,X3] = meshgrid( xe,xe,xe );
Xe = [X1(:) X2(:) X3(:)];
Ue = distmatrixcs(Xe,ctr,radius);
B = phi(Ue);
F = reshape(B*c,[21 21 21]);
slice(X1,X2,X3,F,[.2:.2:1],1,[0:.25:.75])
colorbar
%norm(F(:)-G(:))/sqrt(numel(X1))