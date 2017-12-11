
m = 100; n = 15;
t = (0:m-1)'/(m-1);
A = t.^0;
for j = 2:15, A(:,j)=t.^(j-1); end
b = exp(sin(4*t));
x = A\b;
plot(t,b-A*x)
title('Residual of least squares fit')

b = b/2006.787453104851834;
x = A\b;  y = A*x;

format compact, format short e
kappa = cond(A)
theta = asin(norm(y-b)/norm(b))
eta = norm(A)*norm(x)/norm(y)

K(1,1) = sec(theta);  K(2,1) = kappa*K(1,1);
K(1,2) = K(2,1)/eta;  K(2,2) = kappa + kappa^2*tan(theta)/eta

x = A\b;
fprintf('x(15) = %.15f\n',x(15))
errBS = abs(x(15)-1)

[Q,R] = qr(A,0);
x = R\(Q'*b);
fprintf('x(15) = %.15f\n',x(15))
errHH = abs(x(15)-1)

[Q,R] = mgs(A);
x = R\(Q'*b);
fprintf('x(15) = %.15f\n',x(15))
err = abs(x(15)-1)

norm(Q'*Q-eye(15))

[Q,R] = mgs([A b]);
x = R(1:15,1:15) \ R(1:15,16);
fprintf('x(15) = %.15f\n',x(15))
errMGS = abs(x(15)-1)

x = (A'*A)\(A'*b);
fprintf('x(15) = %.15f\n',x(15))

[U,S,V] = svd(A,0);
x = V*(S\(U'*b));
fprintf('x(15) = %.15f\n',x(15))
errSVD = abs(x(15)-1)

b = vpa( exp(sin(4*t)), 64 );
A = vpa(A,64);
[Q,R] = qr(A,0);
x1 = R\ (Q'*b);
[Q,R] = mgs([A b]);
x2 = R(1:15,1:15) \ R(1:15,16);
x3 = (A'*A)\(A'*b);
[U,S,V] = svd(A,0);
x4 = V*(S\(U'*b));

[x1(end);x2(end);x3(end);x4(end)]

t = vpa(0:m-1,64)'/vpa(m-1,64);
A = t.^0;
for j = 1:14, A=[A,t.*A(:,j)]; end
b = exp(sin(4*t));

[Q,R] = qr(A,0);
x1 = R\ (Q'*b);
[Q,R] = mgs([A b]);
x2 = R(1:15,1:15) \ R(1:15,16);
x3 = (A'*A)\(A'*b);
[U,S,V] = svd(A,0);
x4 = V*(S\(U'*b));

[x1(end);x2(end);x3(end);x4(end)]
