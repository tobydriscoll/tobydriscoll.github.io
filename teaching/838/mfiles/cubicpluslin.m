% Demo of cubic interpolation in 2D, with linear reproduction

%%
% Exact function to sample
% g = @(x,y) x.*sin(pi*y) + y.*exp(sin(2*x));
g = @franke2d;

%%
% Choose nodes
n = 20;
ctr = haltonseq(n,2);  % uniform
x = ctr(:,1);  y = ctr(:,2);
val = g(x,y);  % sample

%%
% Interpolation matrix
R = distmatrix(ctr,ctr);
A = R.^3;

%%
% Polynomial basis evaluation
P = [ ones(size(x)) x y ];
M = size(P,2);

%%
% Solve system for coefficients
c = [A P; P' zeros(M)] \ [val;zeros(M,1)];

%%
% Create a grid for evaluation, and evaluate.
[Xe,Ye] = meshgrid( 0:1/80:1 );
G = g(Xe(:),Ye(:));
Re = distmatrix( [Xe(:) Ye(:)], ctr ); 
Ae = Re.^3;
Pe = [ ones(size(Xe(:))) Xe(:) Ye(:) ];
F = [Ae,Pe] * c;

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


