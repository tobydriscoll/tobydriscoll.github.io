function [X,Y,t,U,mov] = wavedisk

% Wave equation in a disk

tspan = [0 3];
f = @(r,theta) 2*(1-r.^2).*(r.*cos(theta).*(1-r.*sin(theta)));
N = [51 24];  % first must be odd!
m = (N(1)-1)*N(2);  % number of unknowns for displacement and velocity

r = linspace(-1,1,N(1)+1)';
theta = linspace(0,pi,N(2)+1)';  theta(end) = [];
h = [ 2/N(1) pi/N(2) ];
[R,THETA] = ndgrid(r,theta);
U0 = f(R,THETA);
U0 = U0(2:N(1),:);

t = linspace(tspan(1),tspan(2),120);
[t,w] = ode45(@timederiv,t,[U0(:);0*U0(:)]);

  function dwdt = timederiv(t,w)
    u = reshape(w(1:m),[N(1)-1 N(2)]);
    udot = reshape(w(m+(1:m)),[N(1)-1 N(2)]);
    zr = zeros(1,N(2));  zc = zeros(N(1)-1,1);
    urr = ( [u(2:end,:);zr] - 2*u + [zr;u(1:end-1,:)] ) / h(1)^2;
    ur = ( [u(2:end,:);zr] - [zr;u(1:end-1,:)] ) / (2*h(1));
    uqq = ( [u(:,2:end) u(end:-1:1,1)] - 2*u + ...
      [u(end:-1:1,end) u(:,1:end-1)] ) / h(2)^2;
    rm1 = diag(1./abs(r(2:N(1))));
    udotdot = urr + rm1*ur + rm1*rm1*uqq;
    dwdt = [ udot(:); udotdot(:) ];
  end

U = zeros([N(1)+1 N(2) 120]);
U(2:N(1),:,:) = reshape( w(:,1:m)', [N(1)-1 N(2) 120] );

% Animate solution
clf, shg
axis([ -1 1 -1 1 min(U(:)) max(U(:)) ])
caxis( [min(U(:)) max(U(:))] )
axis equal
hold on
X = R.*cos(THETA);  Y = R.*sin(THETA);
X(:,end+1) = X(end:-1:1,1);  Y(:,end+1) = Y(end:-1:1,1);
for j = 1:120
  UU = [ U(:,:,j) U(end:-1:1,1,j) ];
  surf(X,Y,UU), shading interp, drawnow
  mov(j) = getframe;
  cla
end

end