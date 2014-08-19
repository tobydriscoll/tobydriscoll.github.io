function [f,tspan,u0] = Nbody(N)

% Produce necessary values to solve a 7-body problem in the plane

m = 1:N;  % masses
tspan = [0 0.5];
z = exp(2i*pi*(0:N-1)'/N);  % roots of unity
u0 = [ real(z); imag(z); % initial positions
  zeros(2*N,1)         % initial velocities
  ]; 
f = @timederiv;

  function dudt = timederiv(t,u)
    
    x = u(1:N);  y = u(N+(1:N));
    xdot = u(2*N+(1:N));  ydot = u(3*N+(1:N));
    
    % Compute cubes of pairwise distances
    R3 = eye(N);  % diagonal values are meaningless
    for i = 1:N
      for j = i+1:N
        R3(i,j) = ( (x(i)-x(j))^2 + (y(i)-y(j))^2 )^1.5;
        R3(j,i) = R3(i,j);
      end
    end
    
    for i = 1:N
      xdotdot(i) = m * ((x - x(i))./R3(:,i));
      ydotdot(i) = m * ((y - y(i))./R3(:,i));
    end
    
    dudt = [ xdot; ydot; xdotdot(:); ydotdot(:) ];
    
  end

end