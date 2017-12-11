
x = randn(5,1);  alpha = norm(x);
v = alpha*eye(5,1) - x;
F = eye(5) - 2*(v*v')/(v'*v);
norm(F'*F-eye(5))

F*x

A = randn(6,3);  
x = A(:,1);  
v = [x(1)+sign(x(1))*norm(x);x(2:end)]; 
v = v/norm(v);
F = eye(6) - 2*(v*v');
F*A

QR = qr(A)

HH = @(v) eye(length(v)) - 2*(v*v')/(v'*v);
v1 = [1;QR(2:6,1)];  F1 = HH(v1);
v2 = [1;QR(3:6,2)];  F2 = HH(v2);
v3 = [1;QR(4:6,3)];  F3 = HH(v3);

Q = F1*blkdiag(1,F2)*blkdiag(eye(2),F3);
R = triu(QR);
norm(Q*R-A)
