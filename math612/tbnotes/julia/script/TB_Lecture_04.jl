
using PyPlot
A = [-2 0; -1 3];
t = linspace(0,2*pi,300);
x1,x2 = (cos(t),sin(t));
x = [x1.'; x2.'];  Ax = A*x;
subplot(121)
scatter(x1,x2,40,t,".",edgecolor="none",cmap="hsv")
axis("equal"), axis("off")
title(L"x")
subplot(122)
scatter(Ax[1,:].',Ax[2,:].',40,t,".",edgecolor="none",cmap="hsv")
axis("equal"), axis("off")
title(L"Ax")

normAx = sqrt( sum(Ax.^2,1) );  # 2-norms of all the vectors
σ1,k1 = findmax(normAx);  
σ2,k2 = findmin(normAx);
σ = [ σ1 σ2 ];  @show(σ);
U = [ Ax[:,k1]/σ1 Ax[:,k2]/σ2 ];  @show(U);

V = [ x[:,k1] x[:,k2] ]

subplot(121)
scatter(x1,x2,40,t,".",edgecolor="none",cmap="hsv")
axis("equal"), axis("off"), title(L"x")
hold("on")
plot([0 0; V[1,:]],[0 0; V[2,:]], "k" )
text(1.2*V[1,1],1.2*V[2,1],L"v_1")
text(1.2*V[1,2],1.2*V[2,2],L"v_2")

subplot(122)
scatter(Ax[1,:].',Ax[2,:].',40,t,".",edgecolor="none",cmap="hsv")
axis("equal"), axis("off"), title(L"Ax")
hold("on")
plot([0 0; U[1,:].*σ],[0 0; U[2,:].*σ], "k" )
text(1.1*U[1,1].*σ1,1.1*U[2,1].*σ1,L"\sigma_1 u_1") 
text(1.1*U[1,2].*σ2,1.1*U[2,2].*σ2,L"\sigma_2 u_2") 

U,σ,V = svd(A)

A = rand(6,3); 
U,σ,V = svd(A,thin=false);               # full SVD
println("full U = \n",U,"\n\nfull S = \n",diagm(σ))
U1,σ1,V = svd(A)   # thin SVD
println("\n\n\nthin U = \n",U1,"\n\nthin S = \n",diagm(σ1))

println(U1'*U1)           # n by n identity
println("\n\n",U1*U1')    # NOT the m by m identity
