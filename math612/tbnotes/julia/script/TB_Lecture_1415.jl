
using PolynomialRoots
r = [1.0e-6; 1.0e6];
@show p = [1.0; -sum(r); 1.0];

delta = [];
for j = 1:2000
    rr = roots( p.*(1+1e-11*randn(3)) );
    delta = [ delta; norm( (sort(real(rr))-r)./r, Inf ) ];
end
using PyPlot
plt[:hist](log.(10,delta),24);
xlabel("relative change to roots (log)"); ylabel("number of cases");

a = p[1];  b = p[2];  c = p[3];
d = sqrt(b^2-4*a*c)

@show r1 = (-b+d)/(2a)
@show r2 = (-b-d)/(2a)

-log(10,abs(r2-1e-6)/1e-6)

s = -b-d;
@show κ = 2*norm([-b,d],Inf)/abs(s);

c/(a*r1) - 1.0e-6

pp = [1; -(r1+r2); (r1*r2)];
α = pp\p;   # multiple with closest approximation to p
@show (p-α.*pp)./p
