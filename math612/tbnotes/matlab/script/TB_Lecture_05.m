
load hou111kh
imagesc(A), colorbar

mu = mean(A,2);  
A = bsxfun(@minus,A,mu);  % subtract each voter's average from all votes
imagesc(A)

B = A';
[U,S,V] = svd(B,0);
sigma = diag(S);
plot(sigma,'o','markersize',3)

x1 = U(:,1)'*B;   x2 = U(:,2)'*B;
subplot(211), histogram(x1,32)
xlabel('first coefficient'), ylabel('frequency')
subplot(212), histogram(x2,32)
xlabel('second coefficient'), ylabel('frequency')

c = zeros(size(A,1),3);  
c(party==1,3) = 1;  % blue   
c(party==2,1) = 1;  % red
scatter(x1,x2,20,c)
xlabel('partisanship'), ylabel('bipartisanship')
title('111th U.S. Congress, House voting')




