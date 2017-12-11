
A = [2 1 1; 1 3 1; 1 1 4]
(λ,X) = eig(A);
@show λ;

X

x = X[:,3];  
v = [0.4;0.5;0.75];
evec_err = norm(-x-v)

eval_est = v'*A*v/(v'*v)
eval_err = norm(eval_est-λ[3])

v = rand(3);
evec_err = [];
for k = 1:20
    v = v/norm(v);
    evec_err = [evec_err;min(norm(v-x),norm(v+x))];
    v = A*v;
end
using PyPlot
semilogy(evec_err,".-");

abs( v'*A*v/(v'*v) - λ[3] )

for mu = [4 4.5 5.1]
    LU = lufact(A-mu*eye(3));
    v = rand(3,1);
    for k = 1:20
        v = v/norm(v);
        evec_err[k] = min(norm(v-x),norm(v+x));
        v = LU\v;
    end
    semilogy(evec_err,".-")
end

A = map(x->convert(BigFloat,x),A);
v = map(x->convert(BigFloat,x),ones(3));
mu = [];
for k = 1:5
    v = v/norm(v);
    mu = [mu; dot(v,A*v)]; 
    v = (A-mu[k]*eye(3))\v;    
end
println("error in eigenvalue estimates: ");
[@printf("%.60f\n",mu[i]-mu[end]) for i=1:4];
