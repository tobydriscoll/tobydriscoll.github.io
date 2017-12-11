
A = [
        35     1     6    26    19    24
     3    32     7    21    23    25
    31     9     2    22    27    20
     8    28    33    17    10    15
    30     5    34    12    14    16
     4    36    29    13    18    11
];

A = hessfact(A+A')[:H];
λ = eigvals(A);
λ = λ[sortperm(abs(λ))]

Q = eye(6);
subdiag = zeros(0,5);
for k = 1:30
    Z = A*Q;
    (Q,R) = qr(Z);  # Q converges to eigenvectors
    D = Q'*A*Q;     # D converges to diagonal
    subdiag = [subdiag; diag(D,-1)'];
end
using PyPlot
semilogy(abs(subdiag),"-o");
title("Subdiagonal terms in SI");
xlabel(L"k"); ylabel(L"|a^{(k)}_{j+1,j}|");

D = A;
subdiag = zeros(0,5);
for k = 1:30
    (Q,R) = qr(D);
    D = R*Q;
    subdiag = [subdiag; diag(D,-1)'];
end
semilogy(abs(subdiag),"-o");
title("Subdiagonal terms in QR");
xlabel(L"k"); ylabel(L"|a^{(k)}_{j+1,j}|");

D

D = A;  m = size(A,1);
subdiag = zeros(0,m-1);
for k = 1:8
    mu = D[m,m];
    (Q,R) = qr(D - mu*eye(m));
    D = R*Q + mu*eye(m);
    subdiag = [subdiag; diag(D,-1)'];
end
semilogy(abs(subdiag),"-o");
title("Subdiagonal terms in shifted QR");
xlabel(L"k"); ylabel(L"|a^{(k)}_{j+1,j}|");

D

D = D[1:m-1,1:m-1];  m = m-1;
mu = D[m,m];
(Q,R) = qr(D - mu*eye(m));
D = R*Q + mu*eye(m)
