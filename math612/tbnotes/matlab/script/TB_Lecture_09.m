
[U,S,V] = svd(randn(80));
s = 2.^(-1:-1:-80);
A = U*diag(s)*V';
reset(0)  % default graphical preferences

semilogy(s,'.')
[Qc,Rc] = gs(A);  % classical
hold on, semilogy(diag(Rc),'o')
[Qm,Rm] = mgs(A); % modified
hold on, semilogy(diag(Rm),'s')
legend('singular values','classical r_{jj}','MGS r_{jj}')
title('Gram-Schmidt in double precision'), xlabel('j')

semilogy(s,'.')
[Qc,Rc] = gs(single(A));  % classical
hold on, semilogy(diag(Rc),'o')
[Qm,Rm] = mgs(single(A)); % modified
hold on, semilogy(diag(Rm),'s')
legend('singular values','classical r_{jj}','MGS r_{jj}')
title('Gram-Schmidt in single precision'), xlabel('j')

A = [pi, sqrt(2); 355/113, sqrt(2)]

Q = A(:,1)/norm(A(:,1));
v = A(:,2) - Q(:,1)*(Q(:,1)'*A(:,2))

Q(:,2) = v/norm(v);
norm(Q'*Q - eye(2))
