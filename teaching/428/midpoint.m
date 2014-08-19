function [t,w] = midpoint(dydt,tspan,y0,N)

h = (tspan(2)-tspan(1))/N;
t = tspan(1) + (0:N)'*h;

% Starting value by Euler.
w = zeros(N+1,length(y0));
w(1,:) = y0(:).';
w(2,:) = w(1,:) + h*dydt(t(1),w(1,:));

% Main iteration.
for i = 2:N
  w(i+1,:) = w(i-1,:) + 2*h*dydt(t(i),w(i,:));
end

