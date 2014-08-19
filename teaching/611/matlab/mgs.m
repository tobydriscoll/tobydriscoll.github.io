function [Q,R] = mgs(A)

[m,n] = size(A);

Q = zeros(m,n);
R = zeros(n,n);
V(:,:,1) = A;
for i = 1:n
  R(i,i) = norm(V(:,i,i));
  Q(:,i) = V(:,i,i)/R(i,i);
  for j = i+1:n
    R(i,j) = Q(:,i)'*V(:,j,i);
    V(:,j,i+1) = V(:,j,i) - Q(:,i)*R(i,j);
  end
end