
A = [
    16     2     3    13
     5    11    10     8
     9     7     6    12
     4    14    15     1

];
(λ,X) = eig(A);
@show λ;
@show X;

A = eye(4) + diagm([1;1;1],1)   # Jordan block
(λ,X) = eig(A);
@show rank_X = rank(X)

D = diagm(λ);
residual = norm(A*X-X*D)

A = [
    17    24     1     8    15
    23     5     7    14    16
     4     6    13    20    22
    10    12    19    21     3
    11    18    25     2     9
];

(T,Q) = schur(A);
T

A = A[:,end:-1:1]';
λ = eigvals(A)

(T,Q) = schur(A);
T

eigvals(T[2:3,2:3])

H = hessfact(A)[:H]

eigvals(H)

A = A+A';
hessfact(A)[:H]


