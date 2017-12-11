
Qj = qr(rand(6,3))[1];   # get a random Q with 3 ON columns
Pj = eye(6) - Qj*Qj';
σ = svd(Pj)[2]       # all 1 or 0, as required for an orthogonal projector

Mj = eye(6) - Qj[:,1]*Qj[:,1]' - Qj[:,2]*Qj[:,2]' - Qj[:,3]*Qj[:,3]';
norm(Pj-Mj)

Gj = eye(6);
for k = 1:3
    Gj = Gj*(eye(6)-Qj[:,k]*Qj[:,k]');
end
norm(Gj-Pj)

n_ = collect(50:50:500);
time_ = zeros(size(n_));
for k = 1:length(n_)
    n = n_[k];
    A = rand(1200,n);
    Q = zeros(1200,n);  R = zeros(600,600); 
    
    tic();
    R[1,1] = norm(A[:,1]);
    Q[:,1] = A[:,1]/R[1,1];
    @time for j = 2:n
        R[1:j-1,j] = Q[:,1:j-1]'*A[:,j];
        v = A[:,j] - Q[:,1:j-1]*R[1:j-1,j];
        R[j,j] = norm(v);
        Q[:,j] = v/R[j,j];
    end
    time_[k] = toc();
end

using PyPlot
loglog(n_,time_,"-o",n_,(n_/500).^2,"--")
xlabel("n"), ylabel("elapsed time")

n_ = collect(50:50:300);
time_ = zeros(size(n_));
foo=0;
for k = 1:length(n_)
    n = n_[k];
    A = rand(1200,n);
    Q = zeros(1200,n);  R = zeros(n,n); 
    tic();
    R[1,1] = norm(A[:,1]);
    Q[:,1] = A[:,1]/R[1,1];
    for j = 2:n
        v = A[:,j];
        for i = 1:j-1
            foo = 0;
            @time for q = 1:1200
              foo += A[q,j]*Q[q,i];  
            end
            #foo = Q[:,i]'*A[:,j];
            #foo = sum(Q[:,i].*A[:,j]);
            R[i,j] = foo;
            v = v - Q[:,i]*R[i,j];
        end
        R[j,j] = norm(v);
        Q[:,j] = v/R[j,j];
    end
    time_[k] = toc();
end



