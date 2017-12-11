
using Polynomials 
p = poly([1,1,1,0.4,2.2]);         # polynomial with these as roots
q = p + Poly(1e-9*randn(6));       # small changes to its coefficients
println(roots(q))

p = poly(1.0:20);
using PyPlot
plot(collect(1:20),zeros(20),"ko")
for k = 1:500
    q = Poly(p.a.*(1+1e-9*randn(21)));  # relative perturbations
    r = roots(q);
    plot(real(r),imag(r),".")
end
axis("equal")

roots(p)

hilb(n) = [ 1.0/(i+j) for i=1:n, j=1:n];
A = hilb(5);  kappa = cond(A)

perturb(z,ep) = z.*(1 + ep*(2*rand(size(z))-1));
x = 0.3+(1:5);  b = A*x;
for k = 1:8
    bb = perturb(b,1e-10);
    @printf(" relative error = %.2e\n", norm( A\bb - x ) / norm( x ) )
end
@show bound = 1e-10*kappa;

x = 0.3+(1:5);  b = A*x;
for k = 1:8
    AA = perturb(A,1e-10);
    @printf(" relative error = %.2e\n", norm( AA\b - x ) / norm( x ) )
end
@show bound = 1e-10*kappa;
