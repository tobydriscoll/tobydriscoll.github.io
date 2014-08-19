% Demo of polynomial interpolation in 1D
set(0,'defaultlinelinewidth',1.25)

%%
% Exact function to sample
g = @(x) exp(sin(2*x));
%g = @(x) x.*tanh(8*x);

%%
% Choose nodes
n = 5;
x = linspace(-1,1,n)';   % equispaced
z = g(x);  % sample

%%
% Form Vandermonde matrix
A = ones(n);
for j = 1:n-1
  A(:,j+1) = x.^j;
end

%%
% Solve system for polynomial coefficients
c = A\z

%%
% Create the polynomial interpolant as a function
p = @(x) polyval(c(end:-1:1),x);

%%
% Plot result and error
clf
subplot(1,2,1)
fplot(p,[-1 1])
hold on, fplot(g,[-1 1],'k')
plot(x,z,'ko')
title('Interpolant and function')
subplot(1,2,2)
fplot(@(x) p(x)-g(x),[-1 1])
hold on, plot(x,0*z,'o')
title('Error')