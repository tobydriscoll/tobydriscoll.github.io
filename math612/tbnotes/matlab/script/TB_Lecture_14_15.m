
format long e, format compact
p = poly( [1e6 1e-6] )

delta = [];
for j = 1:2000
    r = roots(p.*(1+1e-11*randn(1,3)));
    delta = [ delta; norm( (sort(r)-[1e-6;1e6])./[1e-6;1e6], inf ) ];
end
histogram(delta,24)
xlabel('relative change to roots'), ylabel('number of cases')

a = p(1);  b = p(2);  c = p(3);
d = sqrt(b^2-4*a*c)

r1 = (-b+d)/(2*a),  r2 = (-b-d)/(2*a)

-log10(abs(r2-1e-6)/1e-6)

s = -b-d, kappa = 2*norm([-b,d],inf)/abs(s)

c/(a*r1)

pp = poly([r1 r2]);
alpha = pp'\p';   % multiple with closest approximation to p
(p-alpha*pp)./p
