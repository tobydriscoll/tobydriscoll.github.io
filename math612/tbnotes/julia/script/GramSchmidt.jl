function gs(A)
  m,n = size(A);
  Q = zeros(A);  R = zeros(Q[1:n,1:n]);
  #Q = zeros(m,n);  R = zeros(n,n);
  for j = 1:n
    R[1:j-1,j] = Q[:,1:j-1]'*A[:,j];
    v = A[:,j] - Q[:,1:j-1]*R[1:j-1,j];
    R[j,j] = norm(v);
    Q[:,j] = v/R[j,j];
  end
  return Q,R;
end;

function mgs(B)
  A = copy(B);
  m,n = size(A);
  Q = zeros(A);  R = zeros(Q[1:n,1:n]);
  #Q = zeros(m,n);  R = zeros(n,n);
  for j = 1:n
    R[j,j] = norm(A[:,j]);
    Q[:,j] = A[:,j]/R[j,j];
    A
    R[j,j+1:n] = Q[:,j]'*A[:,j+1:n];
    A
    Q[:,j]
    R[j,j+1:n]
    A[:,j+1:n] -= Q[:,j:j]*R[j:j,j+1:n];
  end
  return Q,R;
end;
