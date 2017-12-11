
A = round(5*rand(3,3))
x = [-1.;1.;2.]

A*x

x[1]*A[:,1] + x[2]*A[:,2] + x[3]*A[:,3]

t = linspace(0,1,51); 
V = zeros(length(t),4);
for j = 0:3
    V[:,j+1] = t.^j; 
end
using PyPlot
plot(t,V)

A = round(8*rand(4,4)); B = triu(ones(4,3)); 
C = A*B

[ A*B[:,1] A*B[:,2] A*B[:,3] ]

u = [ 1; 2; 3 ];  v = [ 1im -1im 1 ];
size(u), size(v)

u*v

A = [ 0 1; 0 0 ]
rank(A)

B = A + [0 0; 1e-12 0 ]
rank(B)

A = round(10*rand(3,3));  x = [ -1; 1; 2 ];
v_standard = A*x

v_Abasis = A^(-1) * v_standard

v_Abasis = A \ v_standard
