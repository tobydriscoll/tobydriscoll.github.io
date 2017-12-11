x = chebfun('x',[0,1]);
r = exp(2*x.^4);
S = pi*r.^2;
plot(r)

%%
A = chebop(@(u) diff(u,2) + diff(u)*diff(S)/S,[0 1],'dirichlet','neumann');
[V,Lam] = eigs(A,15);
lam = diag(Lam);
om = sqrt(-lam)

%%
clf
for omega = linspace(.3,.7,51)
    ode = @(u) diff(u,2) + diff(u)*diff(S)/S + (omega-0.05i)^2*u;
    L = chebop(ode,[0,1]);
    L.lbc = 1;
    L.rbc = @(u) diff(u);
    u = L\0;
    %plot(u), hold on
    ampl = max( abs(u) );
    plot(omega,ampl,'o'), hold on
end

