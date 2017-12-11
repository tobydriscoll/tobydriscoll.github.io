
format compact
A = rand(2,4) + 1i*rand(2,4)

Aadjoint = A'

Atrans = A.'

u = [ 4; -1; 2+2i ],  v = [ -1; 1i; 1 ], 
innerprod = u'*v

length_u_squared = u'*u

sum( abs(u).^2 )

norm_u = norm(u)

cos_theta = (u'*v) / ( norm(u)*norm(v) )

theta = acos(cos_theta)

A = rand(4,4)+1i*rand(4,4);  (inv(A))'

inv(A')

[Q,~] = qr(rand(5,3),0)

QhQ = Q'*Q

u = rand(5,1);  c = Q'*u

v = Q*c

r = u-v;  Q'*r

v'*r

[Q,~] = qr(rand(5,5)+1i*rand(5,5));
abs( inv(Q) - Q' )

c = Q'*u; 
v = Q*c;
r = u - v
