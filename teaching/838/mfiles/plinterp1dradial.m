% Demo of piecewise linear interpolation in 1D, using radial basis

%%
% Exact function to sample
g = @(x) exp(sin(2*x));
%g = @(x) x.*tanh(8*x);

%%
% Choose nodes
n = 300;
x = linspace(-1,1,n)';   % equispaced
z = g(x);  % sample

%%
% Form interpolation matrix
A = zeros(n);
for j = 1:n
  A(:,j) = abs(x-x(j));
end

%%
% Solve system for coefficients
c = A\z

%%
% Create the interpolant as a function
f = @(t) abs(bsxfun(@minus,x',t(:)))*c;

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