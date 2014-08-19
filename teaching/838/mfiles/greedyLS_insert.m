% Demo of greedy least-squares algorithm
%%
phi = @(e,r) sqrt(1+(e*r).^2);
%phi = @(e,r) exp(-(e*r).^2);

%%
% Exact function to sample
g = @franke2d;

%%
% Nodes and samples
m = 1000;
node = haltonseq(m,2);  
z = g(node(:,1),node(:,2));  % samples

%% 
% Start with a random center set
J = [];  n = 0;
Q = [];  R = [];  % QR factorization of evaluation matrix
Jnew = ceil(m*rand(20,1));
ep = 5;

%% 
% Adaptive iteration
figure
normr = [];
for k = 1:80
  A = phi( ep, distmatrix(node,node(Jnew,:)) );  % new columns of A
  for j = 1:size(A,2)
    [Q,R] = qrinsert(Q,R,n+j,A(:,j));         % update QR factorization
  end
  J = [J; Jnew];  n = n+length(Jnew);
  c = R(1:n,:) \ (Q(:,1:n)'*z);     % least-squares solution
  r = z - Q(:,1:n)*(R(1:n,:)*c);   % residual vector
  normr(k) = norm(r);
   
  % Find the largest residuals from the inactive set. (Trick: reset the 
  % active ones so that they are not eligible.)
  absr = abs(r);  absr(J) = -Inf;
  [tmp,idx] = sort(absr,'descend');
  Jnew = idx(1:5);
  
  % Plot
%   clf, plot3(node(:,1),node(:,2),r,'k.')
%   hold on, plot3(node(J,1),node(J,2),r(J),'bo')
%   plot3(node(new,1),node(new,2),r(new),'r*')
%   title(sprintf('iteration #%i',k))
%   pause
end
