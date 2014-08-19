%% Demos of solving IVPs in matlab

%% Euler's method and instability
eulerode
err

%% Backward Euler method
backwardeuler
loglog( [20 40 80 160 320 640 1280], abs(err) )

%% The 5-body problem
[f,tspan,u0] = Nbody(5);  % problem setup

% The popular RK45 method
[t,u] = ode45( f, tspan, u0 ); 
size(t)  % time points
size(u)  % solution history
plot(t,u,'.-')  % note nonuniform time steps

%%
% A high-accuracy Adams method
[t,u] = ode113( f, [0 1.5], u0 );
length(t)
plot(u(:,1:5),u(:,6:10))
axis([-1 1 -1 1])
