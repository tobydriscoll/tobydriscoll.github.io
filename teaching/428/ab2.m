function [t,w] = ab2(dydt,tspan,y0,N)

h = (tspan(2)-tspan(1))/N;
t = tspan(1) + (0:N)'*h;

% Starting value by Euler.
w = zeros(N+1,length(y0));
w(1,:) = y0(:).';
f(1,:) = dydt(t(1),w(1,:));
w(2,:) = w(1,:) + h*f(1,:);
f(2,:) = dydt(t(2),w(2,:));

% Main iteration.
for i = 2:N
  w(i+1,:) = w(i,:) + 0.5*h*(3*f(2,:)-f(1,:));
  f(1,:) = f(2,:);
  f(2,:) = dydt(t(i+1),w(i+1,:));
end

