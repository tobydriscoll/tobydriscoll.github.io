
A = magic(3), x = [-1;2;1]

A*x

x(1)*A(:,1) + x(2)*A(:,2) + x(3)*A(:,3)

V = zeros(51,4);  % not strictly necessary
t = linspace(0,1,51)'; 
for j = 0:3, V(:,j+1) = t.^j; end
plot(t,V)

A = magic(4); B = triu(ones(4,3)); 
C = A*B

[ A*B(:,1), A*B(:,2), A*B(:,3) ]

u = [ 1; 2; 3; 4 ];  v = [ 1i -1i 1 ];
size(u), size(v)

u*v

A = [ 0 1; 0 0 ]
rank(A)

format short e
B = A + [0 0; 1e-12 0 ]
rank(B)

A = magic(3);  x = [ -1; 1; 2 ];
v_standard = A*x

v_Abasis = A^(-1) * v_standard

v_Abasis = A \ v_standard


