
(U,s,V) = svd(randn(80,80));
s = 2.0.^(-1:-1:-80);
A = U*diagm(s)*V';
include("GramSchmidt.jl");  # my GS and MGS implementations
using PyPlot

semilogy(s,".")
(Qc,Rc) = gs(A);  # classical
semilogy(diag(Rc),"o")
(Qm,Rm) = mgs(A); # modified
semilogy(diag(Rm),"s")
legend(["singular values",L"classical $r_{jj}$",L"MGS $r_{jj}$"])
title("Gram-Schmidt in double precision"), xlabel("j")

A = convert(Array{Float32},A);
semilogy(s,".")
(Qc,Rc) = gs(A);  # classical
semilogy(diag(Rc),"o")
(Qm,Rm) = mgs(A); # modified
semilogy(diag(Rm),"s")

legend(["singular values",L"classical $r_{jj}$",L"MGS $r_{jj}$"])
title("Gram-Schmidt in single precision"), xlabel("j")

A = [pi sqrt(2); 355/113 sqrt(2)];

Q = A[:,1]/norm(A[:,1]);
v = A[:,2] - Q[:,1]*Q[:,1]'*A[:,2]

Q = [ Q v/norm(v)];
norm(Q'*Q - eye(2))
