function afternoon

%% Functions of functions
% Toby Driscoll, July 2014
close all, clear

%% Quadrature
% There are many problems that have a function as data. For example, take
% the problem of transforming a function into its definite integral.
% Approximating this transformation numerically is called quadrature.

%%
% In order to use a function as data, we need to create it anonymously, or
% refer to it with an @ sign in front (handle).
integral( @sin,0,pi )

%%
f = @(x) sin(x).*cos(x);
integral(f,-pi,pi)

%%
erf1 = 2/sqrt(pi)*integral(@(t) exp(-t.^2),0,1)
error = erf(1) - erf1

%% Rootfinding
% Another prototypical problem is to find a root of a function. The
% built-in |fzero| is excellent for this. 
fzero(@sin,[1 4])

%%
% You can give either a starting point or a starting interval.
fzero(@sin,2.5)

%%
% The starting interval is greatly preferred.

%% ODEs
% The third classic problem with a function as data is an ordinary
% differential equation, $dy/dt = f(t,y)$. In this case the function data
% is $f(t,y)$. Here is the logistic equation:
f = @(t,y) y.*(1-y);

%%
% And here is its solution for $t\in[0,10]$, $y(0)=0.05$.
[t,y] = ode45( f, [0 10], 0.05 );
plot(t,y,'o-')

%%
% Second order problems have to be rewritten in first order form. For
% example, consider $u'' - u(1-u^2)u' + u = 0$. Introducing $y_1=u$ and
% $y_2=u'$ leads to
f = @(t,y) [ y(2); (1-y(1)^2)*y(2) - y(1) ];
[t,y] = ode45( f, [0 20], [1;0] );
plot(t,y,'o-')

%%
% Here it is in the phase plane.
plot(y(:,1),y(:,2))

%% Parameters
% These kinds of problems are where nested and anonymous functions can be
% handy. Let's consider the ODE above with a parameter $\mu$: $u'' - \mu
% u(1-u^2)u' + u = 0$. We want to write a function for it that includes the
% parameter.

function dydt = myode(t,y,mu)

dydt = zeros(size(y));
dydt(1) = y(2); 
dydt(2) = mu*(1-y(1)^2)*y(2) - y(1);

end

%%
% (This function is actually nested inside the one for this file.) However,
% the ODE solver functions will accept functions of t and y only. We can
% bridge the gap using a "wrapper" anonymous function.
mu = 10;
f = @(t,y) myode(t,y,mu)

%%
% Now |f| is usable by |ode45| but also includes the assigned value of
% |mu|.
[t,y] = ode45( f, [0 60], [1;0] );
plot(t,y,'o-')

%%
% Because |myode| is nested, it would have access to |mu| in the parent
% function if we left it out of the argument list.
function dydt = myode2(t,y)

dydt = zeros(size(y));
dydt(1) = y(2); 
dydt(2) = mu*(1-y(1)^2)*y(2) - y(1);

end

%%
[t,y] = ode45( @myode2, [0 60], [1;0] );
plot(y(:,1),y(:,2))

%%
% The wrapper style is usually preferable, but there are some circumstances
% where the shared workspace of a nested function is useful. 

end

