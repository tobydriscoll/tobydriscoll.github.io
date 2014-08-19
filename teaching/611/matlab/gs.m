function [Q,R] = gs(A)

[m,n] = size(A);

Q = zeros(m,n);
R = zeros(n,n);
for j = 1:n
    V(:,j) = A(:,j); 
    for i = 1:j-1
        R(i,j) = Q(:,i)'*A(:,j);
        V(:,j) = V(:,j) - Q(:,i)*R(i,j);
    end
    R(j,j) = norm(V(:,j));
    Q(:,j) = V(:,j) / R(j,j);
end