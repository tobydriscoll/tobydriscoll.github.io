% Demo of RBF interpolation in 4D

%%
% Basic function
phi = @(r) r.^1;

%%
% Exact function to sample
g = @(x) ones(size(x(:,1)));

%%
% Choose nodes
n = 1000;
ctr = haltonseq(n,4);  % uniform
%ctr = rand(n,2);   % random
val = g(ctr);  % sample

%%
% Interpolation matrix
R = distmatrix(ctr,ctr);
A = R.^3;

%%
% Solve system for coefficients
c = A\val;

%%
% Create a grid for evaluation, and evaluate.
xe = 0:1/11:1;
[X1,X2,X3,X4] = ndgrid( xe,xe,xe,xe );
Xe = [X1(:) X2(:) X3(:) X4(:)];
G = g(Xe);
E = phi( distmatrix(Xe,ctr) );
F = E*c;

%%
norm(F(:)-G(:))/sqrt(numel(X1))