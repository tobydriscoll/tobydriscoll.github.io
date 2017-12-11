
using PyPlot
x = linspace(-1,1,90);
y = x';
contour(x[:],y[:],sqrt(x.^2 .+ y.^2))
axis("equal")
title("level curves of the 2-norm")
xlabel(L"x_1"), ylabel(L"x_2")

contour(x[:],y[:],abs(x) .+ abs(y))
axis("equal")
title("contours of the 1-norm")
xlabel(L"x_1"), ylabel(L"x_2")

contour(x[:],y[:],broadcast(max,abs(x),abs(y)))
axis("equal")
title("contours of the ∞-norm")
xlabel(L"x_1"), ylabel(L"x_2")

A = [-2 0; -1 3];
t = linspace(0,2*pi,300);
x1 = cos(t');  
x2 = sin(t');
Ax = A*[x1;x2];
subplot(1,2,1)
scatter(x1,x2,20,t,".",cmap="hsv",edgecolor="none") 
axis("equal")
title(L"x")
subplot(1,2,2)
scatter(Ax[1,:],Ax[2,:],20,t,".",cmap="hsv",edgecolor="none")
axis("equal")
title(L"Ax")

plot(t,sqrt( sum(Ax.^2,1)' ))
xlim(0,2*pi)
xlabel("angle")
ylabel(L"||Ax||_2")
plot([0; 2*pi],[norm(A); norm(A)],":")
text(6.4,norm(A),L"||A||_2")

t = linspace(-1,1,100)';  
o = ones(size(t));
x1 = [t o t -o];  
x2 = [o t -o t];
Ax = A*[x1;x2];
subplot(1,2,1)
scatter(x1,x2,20,1:400,".",cmap="hsv",edgecolor="none") 
axis("equal")
title(L"x")
subplot(1,2,2)
scatter(Ax[1,:],Ax[2,:],20,1:400,".",cmap="hsv",edgecolor="none")
axis("equal")
title(L"Ax")

plot(maximum(abs(Ax),1)')
ylabel(L"||Ax||_{\infty}")
plot([1;400],[norm(A,Inf);norm(A,Inf)],":")
text(402,norm(A,Inf),L"||A||_{\infty}")

onenorm = maximum( sum(abs(A),1), 2)

infnorm = maximum( sum(abs(A),2), 1)

ϕ,Θ = (linspace(0,1.5*π,70),linspace(π/4,π,50)');
X1,X2,X3 = (sin(Θ).*cos(ϕ),sin(Θ).*sin(ϕ),cos(Θ).*ϕ.^0);
x = [X1[:] X2[:] X3[:]];
Q = qr(rand(3,3))[1];
Qx = (Q*x')';

colrs = sum(x,2);
scatter3D(x[:,1],x[:,2],zs=x[:,3],s=40,c=colrs,marker=".",edgecolor="none")
title(L"x")

scatter3D(Qx[:,1],Qx[:,2],zs=Qx[:,3],s=40,c=colrs,marker=".",edgecolor="none")
title(L"Qx")

