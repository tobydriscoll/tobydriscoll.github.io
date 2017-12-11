
A = magic(6)

A = hess(A+A');
lambda = eig(A);
[~,idx] = sort(abs(lambda));
lambda = lambda(idx)

Q = eye(6);
subdiag = [];
for k = 1:30
    Z = A*Q;
    [Q,R] = qr(Z);  % Q converges to eigenvectors
    D = Q'*A*Q;     % D converges to diagonal
    subdiag = [subdiag; diag(D,-1)'];
end
semilogy(abs(subdiag),'-o')
axis tight
title('Subdiagonal terms in SI')
xlabel('k'), ylabel('|a^{(k)}_{j+1,j}|')

D = A;
subdiag = [];
for k = 1:30
    [Q,R] = qr(D);
    D = R*Q;
    subdiag = [subdiag; diag(D,-1)'];
end
semilogy(abs(subdiag),'-o')
axis tight
title('Subdiagonal terms in QR')
xlabel('k'), ylabel('|a^{(k)}_{j+1,j}|')

D

D = A;  m = length(A);
subdiag = [];
for k = 1:8
    mu = D(m,m);
    [Q,R] = qr(D - mu*eye(m));
    D = R*Q + mu*eye(m);
    subdiag = [subdiag; diag(D,-1)'];
end
semilogy(abs(subdiag),'-o')
axis tight
title('Subdiagonal terms in shifted QR')
xlabel('k'), ylabel('|a^{(k)}_{j+1,j}|')

format short e
D

D = D(1:m-1,1:m-1);  m = m-1;
mu = D(m,m);
[Q,R] = qr(D - mu*eye(m));
D = R*Q + mu*eye(m)
