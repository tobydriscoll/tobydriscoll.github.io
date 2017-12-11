
P = [0 0; 1. 1.]

norm(P^2-P)

using PyPlot
x1 = -5:5; 
(X,Y) = (repmat(x1,1,11),repmat(x1',11,1));
x = [ X[:] Y[:] ];  
Px = (P*x')';
plot([x[:,1] Px[:,1] ]',[x[:,2] Px[:,2]]',"b")
axis("equal")
plot(Px[:,1],Px[:,2],"ko")

svd(P)[2]

P = [0 0; 0 1]

x = [X[:] Y[:]];  Px = (P*x')';
plot([x[:,1] Px[:,1]]',[x[:,2] Px[:,2]]',"b");
plot(Px[:,1],Px[:,2],"ko");
axis("equal")


