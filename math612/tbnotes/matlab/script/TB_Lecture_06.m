
A = magic(6);  A = A(:,1:4)

R = norm(A(:,1)),  Q = A(:,1)/R

P = Q*Q';  
v = A(:,2) - P*A(:,2);
innerprod = v'*Q

R(1,2) = Q(:,1)'*A(:,2);
v = A(:,2) - Q(:,1)*R(1,2);
R(2,2) = norm(v)
Q(:,2) = v/R(2,2)

P = Q(:,1:2)*Q(:,1:2)';
v = A(:,2) - P*A(:,2);
innerprod = v'*Q

R(1:2,3) = Q(:,1:2)'*A(:,3);
v = A(:,3) - Q(:,1:2)*R(1:2,3);
R(3,3) = norm(v)
Q(:,3) = v/R(3,3)

norm( Q*R - A(:,1:3) )

R = norm(A(:,1));
Q = A(:,1)/R(1,1);
for j = 2:size(A,2)
    R(1:j-1,j) = Q'*A(:,j);
    v = A(:,j) - Q*R(1:j-1,j);
    R(j,j) = norm(v);
    Q(:,j) = v/R(j,j);
end

Q,R

norm(Q'*Q-eye(4))

norm(A-Q*R)

A = magic(9);   b = (1:9)';
[Q,R] = qr(A);
z = Q'*b;
x(9,1) = z(9)/R(9,9);
for i = 8:-1:1
    x(i) = (z(i) - R(i,i+1:9)*x(i+1:9)) / R(i,i);
end
x

norm(A*x-b)
