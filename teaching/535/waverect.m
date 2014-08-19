function [X,Y,t,U,mov] = waverect

% Wave equation in a rectangle

xspan = [-2 2];
yspan = [-1 1];
tspan = [0 6];
f = @(x,y) (4-x.^2).*(1-y.^2) .* exp( -4*(x.^2+(y-0.5).^2) );
N = [80 40];
m = prod(N-1);  % number of unknowns for displacement and velocity

x = linspace(xspan(1),xspan(2),N(1)+1)';
y = linspace(yspan(1),yspan(2),N(2)+1)';
h = [ diff(xspan)/N(1) diff(yspan)/N(2) ];
[X,Y] = ndgrid(x,y);
U0 = f(X,Y);
U0 = U0(2:N(1),2:N(2));

t = linspace(tspan(1),tspan(2),120);
[t,w] = ode45(@timederiv,t,[U0(:);0*U0(:)]);

  function dwdt = timederiv(t,w)
    u = reshape(w(1:m),N-1);
    udot = reshape(w(m+(1:m)),N-1);
    zr = zeros(1,N(2)-1);  zc = zeros(N(1)-1,1);
    uxx = ( [u(2:end,:);zr] - 2*u + [zr;u(1:end-1,:)] ) / h(1)^2;
    uyy = ( [u(:,2:end) zc] - 2*u + [zc u(:,1:end-1)] ) / h(2)^2;
    dwdt = [ udot(:); uxx(:)+uyy(:) ];
  end

U = zeros([N+1 120]);
U(2:N(1),2:N(2),:) = reshape( w(:,1:m)', [N-1 120] );

% Animate solution
clf, shg
axis([ xspan yspan min(U(:)) max(U(:)) ])
caxis( [min(U(:)) max(U(:))] )
axis equal
hold on
for j = 1:120
  surf(X,Y,U(:,:,j)), shading interp
  mov(j) = getframe;
  cla
end

end