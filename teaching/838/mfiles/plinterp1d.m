% Demo of piecewise linear interpolation in 1D

%%
% Exact function to sample
g = @(x) exp(sin(2*x));
%g = @(x) x.*tanh(8*x);

%%
% Choose nodes
n = 100;
x = linspace(-1,1,n)';   % equispaced
z = g(x);  % sample

%%
% Form interpolation matrix
A = ones(n);
for j = 2:n
  A(:,j) = max(0,x(j)-x);
end

%%
% Solve system for coefficients
c = A\z

%%
% Create the interpolant as a function
f = @(t) c(1) + max(0,bsxfun(@minus,x(2:n)',t(:)))*c(2:n);

%%
% Plot result and error
clf
subplot(1,2,1)
fplot(f,[-1 1])
hold on, fplot(g,[-1 1],'k')
plot(x,z,'ko')
title('Interpolant and function')
subplot(1,2,2)
fplot(@(x) f(x)-g(x),[-1 1])
hold on, plot(x,0*z,'o')
title('Error')