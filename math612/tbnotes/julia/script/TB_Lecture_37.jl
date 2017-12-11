
using KrylovMethods
using PyPlot
m = 500;
kappa = 10;
lam = linspace(1,kappa,m);
A = sparse(diagm(lam));
b = randn(m);
b = b/norm(b);

(xCG,~,~,~,resnorm) = cg(A,b,tol=1e-14,maxIter=100);
semilogy(resnorm,".-");
ylim(1e-16,1);
xlabel("n");
title("Convergence of CG");
ylabel(L"\|r_n\|_2");

x = b./diag(A);
Anorm(x) = sqrt(dot(x,A*x));
Aerr = [Anorm(x);zeros(100)];
for n = 1:100
    (xCG,~,~,~,resnorm) = cg(A,b,tol=1e-14,maxIter=n,out=-1);
    Aerr[n+1] = Anorm(x-xCG);
end

(xCG,~,~,~,resnorm) = cg(A,b,tol=1e-14,maxIter=100);
semilogy(resnorm,".-");
semilogy(Aerr,".-");
ylim(1e-16,1);
xlabel("n");
title("Convergence of CG");
text(50,1e-10,L"\|r_n\|_2");
text(30,1e-13,L"\|\epsilon_n\|_A");

for kappa = [10 100 1000 1e4]
    bound = 2*( (sqrt(kappa)-1)/(sqrt(kappa)+1) ).^(0:100);
    semilogy(0:100,bound*Aerr[1]);
end
ylim(1e-16,1)
text(60,1e-15,L"\kappa=10")
text(95,1e-8,L"\kappa=10^2")
text(95,1e-3,L"\kappa=10^3")
text(95,1e-1,L"\kappa=10^4")
title("Effect of conditioning on convergence")
xlabel("n")

kappa = 1e4;
lam = linspace(1,kappa,m);
A = sparse(diagm(lam));
b = randn(m);
b = b/norm(b);
(xCG,~,~,~,resnorm) = cg(A,b,tol=1e-14,maxIter=100,out=-1);
semilogy(resnorm,".-")
text(60,0.3,"CG")
(xMR,~,~,~,resnorm) = gmres(A,b,m,tol=1e-14,maxIter=100);
semilogy(resnorm,".-");
text(40,.0075,"MINRES");
xlim(0,100);
ylim(1e-4,1);
xlabel("n");
title(L"Convergence for $\kappa=10^4$");
