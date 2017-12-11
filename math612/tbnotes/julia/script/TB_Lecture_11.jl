
year = collect(1955:5:2000);
anomaly = [ -0.0480; -0.0180; -0.0360; -0.0120; -0.0040; 0.1180; 0.2100; 0.3320; 0.3340; 0.4560 ];
using Plots;  pyplot(legend=false);
plot(year,anomaly,m=:o,l=nothing)

t = year-1955;
@show m = length(t);

A = t.^0;
for j = 1:m-1
    A = [A t.^j];
end
b = anomaly;

c = A\b;   # coefficients, from degree 0 to m-1

using Polynomials
p = Poly(c)

plot(t->p(t-1955),1955,2000)
plot!(year,anomaly,m=:o,l=nothing);
title!("World temperature anomaly");
xlabel!("year"); ylabel!("anomaly (deg C)")

A = A[:,1:4];
@show size(A);

c = A\b;   # coefficients, from degree 0 to 3

p = Poly(c);  # fitting polynomial
plot(t->p(t-1955),1955,2000)
plot!(year,anomaly,m=:o,l=nothing);
title!("World temperature anomaly");
xlabel!("year"); ylabel!("anomaly (deg C)")

B = A'*A;  z = A'*b;
@show size(B);

[c B\z]

(Q,R) = qr(A);  z = Q'*b;
[c R\z]

(U,s,V) = svd(A);  z = U'*b;
[c V*(z./s)]
