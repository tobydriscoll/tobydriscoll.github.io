
ezcontour('sqrt(x.^2+y.^2)',[-1 1],[-1 1])
axis equal, title('2-norm')
xlabel('x_1'), ylabel('x_2')

ezcontour('abs(x)+abs(y)',[-1 1],[-1 1])
axis equal, title('1-norm')
xlabel('x_1'), ylabel('x_2')

ezcontour('max(abs(x),abs(y))',[-1 1],[-1 1])
axis equal, title('\infty-norm')
xlabel('x_1'), ylabel('x_2')

A = [-2 0; -1 3];
t = linspace(0,2*pi,300);
x1 = cos(t);  x2 = sin(t);
Ax = A*[x1;x2];
subplot(121), scatter(x1,x2,4,t,'.'), axis equal, axis off, title('x')
subplot(122), scatter(Ax(1,:),Ax(2,:),4,t,'.'), axis equal, axis off, title('Ax')
colormap(hsv)

plot(t,sqrt( sum(Ax.^2,1) ))
xlim([0 2*pi])
xlabel('angle'), ylabel('||Ax||_2')
hold on, plot([0 2*pi],[norm(A),norm(A)],':')
text(6.4,norm(A),'||A||_2')

t = linspace(-1,1,100);  o = ones(size(t));
x1 = [t,o,t,-o];  x2 = [o,t,-o,t];
Ax = A*[x1;x2];
subplot(121), scatter(x1,x2,4,1:400,'.'), axis equal, axis off, title('x')
subplot(122), scatter(Ax(1,:),Ax(2,:),4,1:400,'.'), axis equal, axis off, title('Ax')
colormap(hsv)

plot(max(abs(Ax),[],1))
ylabel('||Ax||_\infty')
hold on, plot([1 400],[norm(A,inf),norm(A,inf)],':')
text(402,norm(A,inf),'||A||_\infty')

onenorm = max( sum(abs(A),1), [],2)

infnorm = max( sum(abs(A),2), [],1)

[Phi,Theta] = ndgrid(linspace(0,1.5*pi,60),linspace(0.25*pi,pi,50));
x = [ cos(Phi(:)).*sin(Theta(:)) sin(Phi(:)).*sin(Theta(:))  cos(Theta(:)) ];
[Q,~] = qr(magic(3));
Qx = (Q*x')';

colr = sum(x,2);
subplot(121)
scatter3(x(:,1),x(:,2),x(:,3),40,colr,'.')
axis equal, title('x')
subplot(122)
scatter3(Qx(:,1),Qx(:,2),Qx(:,3),40,colr,'.')
axis equal, title('Qx')

