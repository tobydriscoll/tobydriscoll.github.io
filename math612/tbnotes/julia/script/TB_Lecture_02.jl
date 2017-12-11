
A = rand(2,4) + 1im*rand(2,4)

Aadjoint = A'

Atrans = A.'

u = [ 4; -1; 2+2im ]
v = [ -1; 1im; 1 ]
println("dot(u,v) gives ", dot(u,v))
println("u'*v gives ",u'*v)

length_u_squared = u'*u

sum( abs(u).^2 )

norm_u = norm(u)

cos_theta = (u'*v) / ( norm(u)*norm(v) )

theta = acos(cos_theta)

A = rand(4,4)+1im*rand(4,4);  (inv(A))'

inv(A')

Q = qr(rand(5,3))[1]

QhQ = Q'*Q

u = rand(5,1);  c = Q'*u

v = Q*c

r = u-v;  Q'*r

v'*r

Q = qr(rand(5,5)+1im*rand(5,5))[1]
abs( inv(Q) - Q' )

c = Q'*u; 
v = Q*c;
r = u - v
