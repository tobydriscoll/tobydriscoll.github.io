
include("Krylov.jl")
m = 400;
kappa = 10;
N = 60;
lam = linspace(1,kappa,m);
A = diagm(lam);
b = randn(m);
b = b/norm(b);
(Q,T) = lanczos(A,b,N);
T[1:5,1:5]

using PyPlot
nn = ones(m);
plot([N+3],lam',"r.")
for n = 4:N
    theta = eigvals(T[1:n,1:n]);
    plot([n],theta',"k.")
end
xlabel("n"), ylabel("eigenvalues")
title("Convergence of Ritz values in Lanczos iteration")

resnorm = zeros(N);
for n = 2:N
    yn = T[1:n+1,1:n]\[1;zeros(n)];
    xn = Q[:,1:n]*yn;
    resnorm[n] = norm(b-A*xn);
end
semilogy(resnorm,".-");

bound = 2*( (sqrt(kappa)-1)/(sqrt(kappa)+1) ).^(0:N);
semilogy(0:N,bound,"k--");

ylim(1e-16,1);
xlabel(L"n"), ylabel(L"\|r_n\|");
title("Convergence of MINRES, and an upper bound");
