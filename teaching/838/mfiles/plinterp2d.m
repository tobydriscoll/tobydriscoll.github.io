% Demo of piecewise linear interpolation in 2D, using radial basis

%%
% Exact function to sample
% g = @(x,y) x.*sin(pi*y) + y.*exp(sin(2*x));
g = @franke2d;

%%
% Choose nodes
n = 800;
ctr = haltonseq(n,2);  % uniform
%ctr = rand(n,2);   % random
val = g(ctr(:,1),ctr(:,2));  % sample

%%
% Interpolation matrix
A = distmatrix(ctr,ctr);

%%
% Solve system for coefficients
c = A\val;

%%
% Create a grid for evaluation, and evaluate.
[Xe,Ye] = meshgrid( 0:1/80:1 );
G = g(Xe(:),Ye(:));
F = distmatrix( [Xe(:) Ye(:)], ctr ) * c;

%%
% Plot result and error
clf, subplot(1,2,1)
F = reshape(F,size(Xe));
G = reshape(G,size(Xe));
surf(Xe,Ye,F)
hold on, plot3(ctr(:,1),ctr(:,2),val,'wo')
title('Interpolant and function')
subplot(1,2,2)
surf(Xe,Ye,F-G,log10(abs(F-G)))
shading interp
view(2), colorbar
title('Error')

%% 
% Plot a basis function
%figure
%q = @(x,y) distmatrix( [x(:) y(:)], ctr ) * [1;zeros(n-1,1)];
%ezsurf(q,[0 1])
