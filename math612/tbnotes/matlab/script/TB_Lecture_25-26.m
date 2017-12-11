
A = magic(4)
lam = eig(A)

[X,D] = eig(A)

A = eye(4) + diag([1 1 1],1)   % Jordan block
[X,D] = eig(A);
rank_X = rank(X)
residual = norm(A*X-X*D)

A = eye(2) + 1e-10*[0 0;0 1]
norm( eig(A) - diag(A) )

norm( roots(poly(A)) - diag(A) )

A = magic(5)
[Q,T] = schur(A);
norm( Q'*Q-eye(5) )
T

A = rot90(A);
lam = eig(A)

[Q,T] = schur(A);
T

eig(T(2:3,2:3))
eig(T(4:5,4:5))

A

x = A(2:5,1);  v = norm(x)*eye(4,1)-x; F = eye(4)-2*(v*v')/(v'*v);

[A(1,:);F*A(2:5,:)]

F*A*F'









H = hess(A)

eig(H)

A = A+A';
hess(A)


