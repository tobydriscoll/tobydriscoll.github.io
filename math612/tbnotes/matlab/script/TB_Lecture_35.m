
m = 1200;
A = 2*eye(m) + 0.5*randn(m,m)/sqrt(m);
plot(eig(A),'.')
axis equal, title('Eigenvalues of A')

b = ones(m,1);
[Q,H] = arnoldi(A,b,15);
resnorm = [];
for n = 1:15
    e1 = eye(n+1,1);
    yn = H(1:n+1,1:n) \ (norm(b)*e1);
    resnorm(n) = norm( H(1:n+1,1:n)*yn - norm(b)*e1 );
    xn = Q(:,1:n)*yn;
end

semilogy(resnorm,'o-')
xlabel('n'), ylabel('norm of residual')
title('Convergence of GMRES residual')

semilogy(resnorm,'o-')
hold on
semilogy([1 15],norm(b)*.25.^([1 15]),'--')
xlabel('n'), ylabel('norm of residual')
title('Convergence of GMRES residual')

theta = linspace(0,pi,m)';
d = (-2+2*sin(theta)) + 1i*cos(theta);
D = diag(d);
A = A + D;
lam = eig(A);
plot(lam,'.')
axis equal, title('Eigenvalues of A')

b = ones(m,1);
[Q,H] = arnoldi(A,b,80);
resnorm = [];
for n = 1:80
    e1 = eye(n+1,1);
    yn = H(1:n+1,1:n) \ (norm(b)*e1);
    resnorm(n) = norm( H(1:n+1,1:n)*yn - norm(b)*e1 );
    xn = Q(:,1:n)*yn;
end

semilogy(resnorm,'.-')
hold on, semilogy([0 80],norm(b)*.25.^([0 80]),'--')
xlabel('n'), ylabel('norm of residual')
title('Convergence of GMRES residual')


