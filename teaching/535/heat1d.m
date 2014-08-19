function [x,t,u,mov] = heat1d

% Wave equation on an interval

xspan = [-1 1];
tspan = [0 1];
f = @(x) 1*(1-x.^2).* exp( -12*(x-0.5).^2 );
N = 120;
% source = @(x) heaviside(x+0.507)-heaviside(x-0.07);

x = linspace(xspan(1),xspan(2),N+1)';
h = diff(xspan)/N;
u0 = f(x);
u0 = u0(2:N);

t = linspace(tspan(1),tspan(2),120);
[t,w] = ode15s(@timederiv,t,u0);

  function dudt = timederiv(t,u)
    uxx = ( [u(2:end);0] - 2*u + [0;u(1:end-1)] ) / h^2;
    dudt = uxx;
  end

M = length(t);
u = zeros([N+1 M]);
u(2:N,:) = reshape( w(:,1:N-1)', [N-1 M] );

% Animate solution
clf, shg
axis([ xspan min(u(:)) max(u(:)) ])
hold on
for j = 1:M
  plot(x,u(:,j))
  mov(j) = getframe;
  cla
end

clf
pcolor(x,t,u'), shading interp
xlabel x, ylabel t

end