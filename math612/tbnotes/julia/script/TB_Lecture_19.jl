
m = 100; n = 15;
t = (0:m-1)/(m-1);
A = [t[i].^(j-1) for i=1:m, j=1:n];
b = exp(sin(4*t));
x = A\b;

using PyPlot
plot(t,b-A*x)
title("Residual of least squares fit")

b = b/2006.787453104851834;
x = A\b;  y = A*x;

@show kappa = cond(A);
@show theta = asin(norm(y-b)/norm(b));
@show eta = norm(A)*norm(x)/norm(y);

K = zeros(2,2);
K[1,1] = sec(theta);  K[2,1] = kappa*K[1,1];
K[1,2] = K[2,1]/eta;  K[2,2] = kappa + kappa^2*tan(theta)/eta;
K

x = A\b;
@printf("x(15) = %.15f\n",x[n])
errBS = abs(x[n]-1)

(Q,R) = qr(A);
x = R\(Q'*b);
@printf("x(15) = %.15f\n",x[n])
errHH = abs(x[n]-1)

include("GramSchmidt.jl")
(Q,R) = mgs(A);
x = R\(Q'*b);
@printf("x(15) = %.15f\n",x[n])
err = abs(x[n]-1)

norm(Q'*Q-eye(15))

(Q,R) = mgs([A b]);
x = R[1:n,1:n] \ R[1:n,n+1];
@printf("x(15) = %.15f\n",x[n])
errMGS = abs(x[n]-1)

x = (A'*A)\(A'*b);
@printf("x(15) = %.15f\n",x[n])

(U,s,V) = svd(A);
x = V*((U'*b)./s);
@printf("x(15) = %.15f\n",x[n])
errMGS = abs(x[n]-1)

setprecision(BigFloat,128);  # use 128-bit floats
b = convert( Array{BigFloat},exp(sin(4*t)) );
A = convert(Array{BigFloat},A);
(Q,R) = qr(A);
x1 = R\ (Q'*b);
(Q,R) = mgs([A b]);
x2 = R[1:15,1:15] \ R[1:15,16];
x3 = (A'*A)\(A'*b);
x4 = A\b;

[x1[n];x2[n];x3[n];x4[n]]

t = convert(Array{BigFloat},collect(0:m-1))/convert(BigFloat,m-1);
A = [t[i].^j for i=1:m, j=0:n-1];
b = exp(sin(4*t));

(Q,R) = qr(A);
x1 = R\ (Q'*b);
(Q,R) = mgs([A b]);
x2 = R[1:15,1:15] \ R[1:15,16];
x3 = (A'*A)\(A'*b);
x4 = A\b;

[x1[n];x2[n];x3[n];x4[n]]
