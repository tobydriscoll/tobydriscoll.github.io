
A = randn(500,500);
b = ones(500,1);
K = b;
n = 10;
for j = 1:n-1
    K = [K A*K(:,j)];
end

cond(K)

m = size(A,1);  n = 50;
Q= zeros(m,n+1);
H = zeros(n+1,n);
Q(:,1) = b/norm(b);
for j = 1:n
    v = A*Q(:,j);
    for i = 1:j
        H(i,j) = dot(Q(:,i),v);
        v = v - H(i,j)*Q(:,i);
    end
    H(j+1,j) = norm(v);
    Q(:,j+1) = v/H(j+1,j);
end

spy(H);

lam = eig(A);
plot(real(lam),imag(lam),'.')
axis square
axis equal
hold on
for j = 5:n
    lam = eig(H(1:j,1:j));
    plot(real(lam),imag(lam),'rx')
end
