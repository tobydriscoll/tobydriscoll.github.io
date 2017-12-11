
 p = poly([1,1,1,0.4,2.2]);      % polynomial with these as roots
 q = p + 1e-9*randn(size(p));    % small changes to its coefficients
 format long, roots(q)

p = poly(1:20);
plot(1:20,0,'ko'), hold on
for k = 1:500
   q = p.*(1+1e-9*randn(size(p)));  % relative perturbations
   r = roots(q);
   plot(real(r),imag(r),'.')
end

roots(p)

format short e
A = hilb(5);  kappa = cond(A)

perturb = @(z,ep) z.*(1 + ep*(2*rand(size(z))-1));
x = 0.3+(1:5)';  b = A*x;
bound = 1e-10*kappa
for k = 1:8
    bb = perturb(b,1e-10);
    fprintf(' relative error = %.2e\n', norm( A\bb - x ) / norm( x ) )
end

x = 0.3+(1:5)';  b = A*x;
bound = 1e-10*kappa
for k = 1:8
    AA = perturb(A,1e-10);
    fprintf(' relative error = %.2e\n', norm( AA\b - x ) / norm( x ) )
end
