function [Q,H] = arnoldi(A,b,n)

%b = randn(size(A,1),1);
Q(:,1) = b/norm(b);
for j = 1:n-1
    v = A*Q(:,j);
    for i = 1:j
        H(i,j) = Q(:,i)'*v;
        v = v - H(i,j)*Q(:,i);
    end
    H(j+1,j) = norm(v);
    Q(:,j+1) = v/H(j+1,j);
end