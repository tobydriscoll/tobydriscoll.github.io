%% Spruce budworm outbreaks
% Toby Driscoll, February 2016

%%
% (Chebfun example applics/Budworm.m)
% [Tags: #ODE #BVP]

%%
% Outbreaks of the spruce budworm have been known to devastate tens of
% millions of acres of Canadian forest. A classic interaction-diffusion
% model for budworm population is due to Ludwig [1] (here in nondimensional
% form [2]):
%%
% $$u_t = u_{xx} - \displaystyle\frac{u^2}{1+u^2} + ru\left( 1 - q^{-1} u
% \right), \qquad 0 \le x \le L,$$
%%
% where $u(x,t)$ is the population in a one-dimensional "forest", and
% $r$, $q$, and $L$ are parameters. 
r = .2; 
q = 0.5;
ODE = @(u) diff(u,2) - u^2/(1+u^2)  + r*u*(1-u/q);

%% 
% Of interest is the long-term or steady solution in which $u_t$ equals
% zero---in particular, whether there exist stable, nonzero steady
% solutions, representing a sustained outbreak. For some values of $r$ and
% $q$, there is a critical length $L_0$ such that an outbreak occurs if and
% only if $L>L_0$.

%%
% At the ends of the forest, the population drops to zero, we set up
% Dirichlet boundary conditions for the BVP. Also, in order to observe the
% outbreak solutions, we have to manually set an initial solution guess,
% because the default choice would be the zero solution.
for L = 2:2:16
    B = chebop(ODE,[0,L], 0,0 ); 
    B.init = chebfun( @(x) q*x.*(L-x), [0,L] );

    u = B\0;
    plot(u), hold on
end
set(gca,'xtick',2:2:16)
 
%%
% The threshold $L_0$ apparently lies somewhere within $[6,8]$. 

%% References
%
% 1. D. Ludwig, D. D. Jones, and C. S. Holling, "Qualitative Analysis of
% Insect Outbreak Systems: The Spruce Budworm and Forest," The Journal of
% Animal Ecology, vol. 47, no. 1, p. 315, 1978.
%
% 2. J. D. Murray, _Mathematical Biology II: Spatial Models and
% Biomedical Applications_, 3rd ed. Springer, 2003.