
A = [2 1 1; 1 3 1; 1 1 4]
[V,D] = eig(A);

[X,Y,Z] = sphere(100);
v = [X(:) Y(:) Z(:)]';
Av = A*v;
Ray = sum( conj(v).*Av, 1 );
surf(X,Y,Z,reshape(Ray,size(X)))
hold on
plot3(V(1,:),V(2,:),V(3,:),'k*')

title('Rayleigh quotient values on the unit sphere')
shading interp, axis square
view(107,20)
xlabel('x'), ylabel('y'), zlabel('z')

x = V(:,3);  
v = [0.4;0.5;0.75];
evec_err = norm(x-v)

eval_est = v'*A*v/(v'*v)
eval_err = norm(eval_est-D(3,3))

v = rand(3,1);
for k = 1:20
    v = v/norm(v);
    evec_err(k) = min(norm(v-x),norm(v+x));
    v = A*v;
end
semilogy(evec_err)    
    

abs( v'*A*v/(v'*v) - D(3,3) )

diag(D)

(5-5.2)/(5-2.46)



for mu = [4 4.5 5.1]
    [L,U] = lu(A-mu*eye(3));
    v = rand(3,1);
    for k = 1:20
        v = v/norm(v);
        evec_err(k) = min(norm(v-x),norm(v+x));
        v = U\(L\v);
    end
    semilogy(evec_err)
    hold on
end

digits(60)
A = vpa(A);
lambda = eig(A)

v = vpa(ones(3,1));
for k = 1:5
    v = v/norm(v);
    mu = v'*A*v; 
    fprintf('error in eigenvalue = %.50f\n',double(min(mu-lambda)))
    v = (A-mu*eye(3))\v;    
end
