% Demo of RBF interpolation in 3D

%%
% Exact function to sample
g = @(x) ones(size(x(:,1)));

%%
% Choose nodes
n = 1000;
ctr = haltonseq(n,3);  % uniform
%ctr = rand(n,2);   % random
val = g(ctr);  % sample

%%
% Interpolation matrix
R = distmatrix(ctr,ctr);
A = R; 

%%
% Solve system for coefficients
c = A\val;

%%
% Create a grid for evaluation, and evaluate.
xe = 0:1/14:1;
[X1,X2,X3] = ndgrid( xe,xe,xe );
Xe = [X1(:) X2(:) X3(:)];
G = g(Xe);
F = distmatrix( Xe, ctr ) * c;
norm(F(:)-G(:))/sqrt(numel(X1))