
m = 400;
kappa = 10;
N = 60;
lam = linspace(1,kappa,m)';
A = diag(lam);
b = randn(m,1);
b = b/norm(b);
[Q,T] = lanczos(A,b,N);
T(1:5,1:5)

clf
plot(N+3,lam,'r.')
hold on
for n = 4:N
    theta = eig(T(1:n,1:n));
    plot(n,theta,'k.')
end
xlabel('n'), ylabel('eigenvalues')
title('Convergence of Ritz values in Lanczos iteration')

resnorm = [];
for n = 2:N
    yn = T(1:n+1,1:n)\eye(n+1,1);
    xn = Q(:,1:n)*yn;
    resnorm(n) = norm(b-A*xn);
end
clf
semilogy(resnorm,'.-')
hold on
bound = 2*( (sqrt(kappa)-1)/(sqrt(kappa)+1) ).^(0:N);
plot(0:N,bound,'k--')
ylim([1e-16 1])
xlabel('n'), ylabel('||r_n||')
title('Convergence of MINRES, and an upper bound')


