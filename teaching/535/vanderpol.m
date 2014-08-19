function [f,tspan,u0] = vanderpol(epsilon)

% Produce necessary values to solve van der Pol's equation

tspan = [0 5*epsilon^1.1];
u0 = [ 1; 0 ];
f = @timederiv;

  function dudt = timederiv(t,u)
    
    y = u(1);  ydot = u(2);

    ydotdot = -epsilon*(y^2-1)*ydot - y;
    dudt = [ ydot; ydotdot ];
    
  end

end