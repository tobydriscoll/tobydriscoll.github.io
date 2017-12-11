
A = magic(4);
A = A + A' + eye(4)

L1 = eye(4);  L1(2:4,1) = -A(2:4,1)/A(1,1);
A1 = L1*A

L1*A1'

A1 = L1*A*L1'

L2 = eye(4);  L2(3:4,2) = -A1(3:4,2)/A1(2,2);
A2 = L2*A1*L2'

L3 = eye(4);  L3(4,3) = -A2(4,3)/A2(3,3);
A3 = L3*A2*L3'

L = inv(L1)*inv(L2)*inv(L3);  D = diag(diag(A3));
norm( A - L*D*L' )

B = A'*A/100

c = sqrt(B(1,1));
L1 = eye(4);  
L1(1,1) = 1/c;
L1(2:4,1) = -B(2:4,1)/c^2

L1*B

B1 = L1*B*L1'

c = sqrt(B1(2,2));
L2 = eye(4);  L2(2,2) = 1/c;
L2(3:4,2) = -B1(3:4,2)/c^2;
B2 = L2*B1*L2'

c = sqrt(B2(3,3));
L3 = eye(4);  L3(3,3) = 1/c;
L3(4:4,3) = -B2(4:4,3)/c^2;
B3 = L3*B2*L3'
L4 = eye(4);  L4(4,4) = 1/sqrt(B3(4,4));
B4 = L4*B3*L4'

inv(L1)

[c; B(2:4,1)/c]

inv(L1)
inv(L2)
inv(L3)

inv(L1)*inv(L2)*inv(L3)*inv(L4)
