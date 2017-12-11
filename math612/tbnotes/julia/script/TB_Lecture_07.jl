
A = round(10*rand(6,4))

(Q,R) = (zeros(6,4),zeros(4,4));
R[1,1] = norm(A[:,1]);
Q[:,1] = A[:,1]/R[1,1];

P = Q[:,1]*Q[:,1]';  
v = A[:,2] - P*A[:,2];
@show v'*Q[:,1];

R[1,2] = dot(Q[:,1],A[:,2]);
v = A[:,2] - Q[:,1]*R[1,2];

R[2,2] = norm(v);
@show R;
Q[:,2] = v/R[2,2];
@show Q;

P = Q[:,1:2]*Q[:,1:2]';
v = A[:,2] - P*A[:,2];
@show v'*Q[:,1:2];

(R[1,3],R[2,3]) = dot(Q[:,1],A[:,3]),dot(Q[:,2],A[:,3]);
v = A[:,3] - Q[:,1:2]*R[1:2,3];
R[3,3] = norm(v);
@show R;
Q[:,3] = v/R[3,3];

@show norm( Q*R[:,1:3] - A[:,1:3] );

(m,n) = size(A);
(Q,R) = (zeros(m,n),zeros(n,n));
R[1,1] = norm(A[:,1]);
Q[:,1] = A[:,1]/R[1,1];
for j = 2:n
    R[1:j-1,j] = Q[:,1:j-1]'*A[:,j];
    v = A[:,j] - Q[:,1:j-1]*R[1:j-1,j];
    R[j,j] = norm(v);
    Q[:,j] = v/R[j,j];
end

 
@show Q;

norm(Q'*Q-eye(n))

norm(A-Q*R)

A = round(10*rand(9,9));   b = collect(1:9);
m = 9;
(Q,R) = qr(A);
z = Q'*b;
x = zeros(m);
x[m] = z[m]/R[m,m];
for i = m-1:-1:1
    y = z[i] - R[i,i+1:m]*x[i+1:m];
    x[i] = y[1] / R[i,i];
end
@show x;

norm(A*x-b)
