
[Qj,~] = qr(rand(6,3),0);   % get a random Q with 3 ON columns
Pj = eye(6) - Qj*Qj';
svd(Pj)       % all 1 or 0, as required for an orthogonal projector

Mj = eye(6) - Qj(:,1)*Qj(:,1)' - Qj(:,2)*Qj(:,2)' - Qj(:,3)*Qj(:,3)';
norm(Pj-Mj)

Gj = eye(6);
for k = 1:3
    Gj = Gj*(eye(6)-Qj(:,k)*Qj(:,k)');
end
norm(Gj-Pj)

n_ = 50:50:500;
time_ = [];
for k = 1:length(n_)
    n = n_(k);
    A = rand(1200,n);
    Q = zeros(1200,n);  R = zeros(600,600); 
    
    tic
    R(1,1) = norm(A(:,1));
    Q(:,1) = A(:,1)/R(1,1);
    for j = 2:n
        R(1:j-1,j) = Q(:,1:j-1)'*A(:,j);
        v = A(:,j) - Q(:,1:j-1)*R(1:j-1,j);
        R(j,j) = norm(v);
        Q(:,j) = v/R(j,j);
    end
    time_(k) = toc;
end
loglog(n_,time_,'-o',n_,(n_/500).^2,'--')
axis tight, xlabel('n'), ylabel('elapsed time')


