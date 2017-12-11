
using(MAT)
vars = matread("hou111kh.mat");
A = vars["A"];
using PyPlot
imshow(A); colorbar()

mu = mean(A,2);  
A = A .- mu;  # subtract each voter's average from all votes
imshow(A)

x=rand(500);
PyPlot.hist(x)

B = A';
U,σ,V = svd(B);   # thin SVD
plot(σ,"o")

x1 = U[:,1]'*B;   x2 = U[:,2]'*B;
subplot(211); plt[:hist](x1[:],32)
xlabel("first coefficient"), ylabel("frequency")
subplot(212); plt[:hist](x2[:],32)
xlabel("second coefficient"), ylabel("frequency")

c = zeros(size(A,1),3);  
c[vars["party"].==1,3] = 1;  # blue   
c[vars["party"].==2,1] = 1;  # red
scatter(x1,x2,20,c)
xlabel("partisanship"), ylabel("bipartisanship")
title("111th U.S. Congress, House voting")


