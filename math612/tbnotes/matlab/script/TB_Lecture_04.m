
A = [-2 0; -1 3];
t = linspace(0,2*pi,300);
x1 = cos(t);  x2 = sin(t);
x = [x1;x2];  Ax = A*x;
subplot(121), scatter(x1,x2,4,t,'.'), axis equal, axis off, title('x')
subplot(122), scatter(Ax(1,:),Ax(2,:),4,t,'.'), axis equal, axis off, title('Ax')
colormap(hsv)

normAx = sqrt( sum(Ax.^2,1) );  % 2-norms of all the vectors
[sigma1,k1] = max(normAx);  [sigma2,k2] = min(normAx);
sigma = [ sigma1 sigma2 ]
U = [ Ax(:,k1)/sigma1 Ax(:,k2)/sigma2 ]

V = [ x(:,k1) x(:,k2) ]

subplot(121), scatter(x1,x2,4,t,'.'), axis equal, axis off, title('x')
hold on, plot([0 0; V(1,:)],[0 0; V(2,:)], 'k' )
text(1.2*V(1,:),1.2*V(2,:),{'v_1','v_2'})
subplot(122), scatter(Ax(1,:),Ax(2,:),4,t,'.'), axis equal, axis off, title('Ax')
hold on, plot([0 0; U(1,:).*sigma],[0 0; U(2,:).*sigma], 'k' )
text(1.1*U(1,:).*sigma,1.1*U(2,:).*sigma,{'\sigma_1 u_1','\sigma_2 u_2'})
colormap(hsv)

[U,S,V] = svd(A)

A = rand(4,3); 
[U,S,V] = svd(A)       % full SVD
[U1,S1,V] = svd(A,0)   % thin SVD

U1'*U1    % n by n identity
U1*U1'    % NOT the m by m identity
