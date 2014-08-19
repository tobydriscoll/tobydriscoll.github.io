A = [ ones(1,10); 1e-8*eye(10) ];

[Q1,R1] = gs(A);
[Q2,R2] = mgs(A);

disp('orthogonality of CGS:')
norm(Q1'*Q1-eye(10))
disp('orthogonality of MGS:')
norm(Q2'*Q2-eye(10))
