
A = [ 
    17     2     3    13
     5    12    10     8
     9     7     7    12
     4    14    15     2
    ];
x = collect(4:-1:1)//2;   # exact answer
b = A*x;

AA = [A b];
AA[2,:] = AA[2,:] - (5//17)*AA[1,:];
AA[3,:] = AA[3,:] - (9//17)*AA[1,:];
AA[4,:] = AA[4,:] - (4//17)*AA[1,:];
AA

I = eye(Rational,4);
L21 = copy(I);  L21[2,1] = -5//17;
L31 = copy(I);  L31[3,1] = -9//17;
L41 = copy(I);  L41[4,1] = -4//17;

L41*(L31*(L21*[A b]))

L1 = L41*L31*L21

A1 = L1*A

map(x->convert(Rational,x),A)

L2 = copy(I);
L2[3,2] = (-101//194);
L2[4,2] = (-230//194);
A2 = L2*A1

L3 = eye(4);
L3[4,3] = -A2[4,3]/A2[3,3];
A3 = L3*A2

U = L3*L2*L1*A

M = L3*L2*L1

[ L1[:,1] L2[:,2] L3[:,3] ]

L = inv(M)

A - L*U
