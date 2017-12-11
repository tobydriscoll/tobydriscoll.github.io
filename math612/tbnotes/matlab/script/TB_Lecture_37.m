
m = 500;
kappa = 10;
lam = linspace(1,kappa,m)';
A = sparse(diag(lam));
b = randn(m,1);
b = b/norm(b);
[xCG,~,~,~,resnorm] = pcg(A,b,1e-14,100);
semilogy(resnorm,'.-')
hold on
ylim([1e-16 1])
xlabel('n')
title('Convergence of CG')
legend('||r_n||_2')

x = b./diag(A);
Anorm = @(x) sqrt(x'*A*x);
Aerr = Anorm(x);
for n = 1:100
    [xCG,~] = pcg(A,b,1e-14,n);
    Aerr(n+1) = Anorm(x-xCG);
end
semilogy(resnorm,'.-')
hold on
semilogy(Aerr,'.-')
ylim([1e-16 1])
xlabel('n')
title('Convergence of CG')
legend('||r_n||_2','||\epsilon_n||_A')

for kappa = [10 100 1000 1e4]
    bound = 2*( (sqrt(kappa)-1)/(sqrt(kappa)+1) ).^(0:100);
    semilogy(0:100,bound*Aerr(1))
    hold on
end
ylim([1e-16 1])
text(60,1e-15,'\kappa=10')
text(95,1e-8,'\kappa=10^2')
text(95,1e-3,'\kappa=10^3')
text(95,1e-1,'\kappa=10^4')
title('Effect of conditioning on convergence')
xlabel('n')

kappa = 1e4;
lam = linspace(1,kappa,m)';
A = sparse(diag(lam));
b = randn(m,1);
b = b/norm(b);
[xCG,~,~,~,resnorm] = pcg(A,b,1e-14,100);
semilogy(resnorm,'.-')
hold on
text(60,0.3,'CG')
[xMR,~,~,~,resnorm] = gmres(A,b,[],1e-14,100);
semilogy(resnorm,'.-')
text(40,.0075,'MINRES')
ylim([1e-4 1])
xlabel('n')
title('Convergence for \kappa=10^4 ')
