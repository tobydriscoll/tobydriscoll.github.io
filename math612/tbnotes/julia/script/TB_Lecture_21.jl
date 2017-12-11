
A = [ 1e-20 1; 1 0 ]
L = [ 1 0 ; 1e20 1 ]
U = [ 1e-20 1; 0 -1e20 ]
show(A - L*U)

A = [
    17     2     3    13
     5    12    10     8
     9     7     7    12
     4    14    15     2
];

L1 = eye(4);  L1[2:4,1] = -A[2:4,1]/A[1,1]
A1 = L1*A

P2 = eye(4);  P2[[2 4],:] = P2[[4 2],:]
A1 = P2*A1;
L2 = eye(4);  L2[3:4,2] = -A1[3:4,2]/A1[2,2]
A2 = L2*A1

P3 = eye(4);  P3[[3 4],:] = P3[[4 3],:]
A2 = P3*A2
L3 = eye(4);  L3[4,3] = -A2[4,3]/A2[3,3]
A3 = L3*A2

U = L3*P3*L2*P2*L1*A

U = L3 * P3*L2/P3 * P3*P2*L1/P2/P3 * P3*P2 * A

U = L3 * P3*L2*P3 * P3*P2*L1*P2*P3 * P3*P2 * A

P3L2 = P3*L2

P3P2L1 = P3*P2*L1

LL2 = P3*L2*P3

LL1 = P3*P2*L1*P2*P3

P = P3*P2;
U = L3*LL2*LL1*P*A

L = eye(4)/LL1/LL2/L3

norm(P*A-L*U)

(L,U,p) = lu(A)

b = collect(1:4);  x = U\( L\( b[p] ) )

norm(b-A*x)

LU = lufact(A)

x = LU\b

m = 6;
A = tril(-ones(m,m),-1) + eye(m);
A[:,m] .= 1;
A

(L,U) = lu(A);
U

m = 53;
A = tril(-ones(m,m),-1) + eye(m);
A[:,m] .= 1;
x = (1:m)/m;
b = A*x;
norm(x - A\b) / norm(x)

cond(A)

(Q,R) = qr(A);
norm(x - R\(Q'*b)) / norm(x)
