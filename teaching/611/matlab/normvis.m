A = input('Give me a real 2x2 matrix: ');

% 1-norm
t = 1:-0.05:0;
x = [ t -t -t t ];
y = [ 1-t 1-t -1+t -1+t ];
Au = A*[x;y];                           % apply to unit sphere
normAu = sum(abs(Au),1);                % 1-norm of vectors
[normA,idx] = max(normAu);              % 1-norm of matrix
idx = idx(1);

figure
ax(1) = subplot(121);
plot(x,y,'k.')
axis equal, axis square, grid on
title('u'), hold on
plot([0 x(idx)],[0 y(idx)],'b-','linew',1.5)
ax(2) = subplot(122);
plot(Au(1,:),Au(2,:),'k.')
axis equal, axis square, grid on
m = max(abs(axis)); axis(m*[-1 1 -1 1])
title('Au'), hold on
plot([0 Au(1,idx)],[0 Au(2,idx)],'b-','linew',1.5)
xlabel(sprintf('|| A ||_1 = %.3f',normA))

% 2-norm
t = pi*(0:0.02:2);
x = cos(t);  y = sin(t);
Au = A*[x;y];                           % apply to unit sphere
normAu = sqrt( sum(abs(Au).^2,1) );     % 2-norm of vectors
[normA,idx] = max(normAu);              % 2-norm of matrix
idx = idx(1);

figure
ax(1) = subplot(121);
plot(x,y,'k.')
title('u'), hold on
axis equal, axis square, grid on
plot([0 x(idx)],[0 y(idx)],'b-','linew',1.5)
ax(2) = subplot(122);
plot(Au(1,:),Au(2,:),'k.')
title('Au'), hold on
axis equal, axis square, grid on
plot([0 Au(1,idx)],[0 Au(2,idx)],'b-','linew',1.5)
xlabel(sprintf('|| A ||_2 = %.3f',normA))

% Inf-norm
t = -1:.05:1;  o = ones(size(t));
x = [ t o -t -o ];  y = [ o -t -o t ];
Au = A*[x;y];                           % apply to unit sphere
normAu = max(abs(Au),[],1);             % Inf-norm of vectors
[normA,idx] = max(normAu);              % Inf-norm of matrix
idx = idx(1);

figure
ax(1) = subplot(121);
plot(x,y,'k.')
title('u'), hold on
axis equal, axis square, grid on
plot([0 x(idx)],[0 y(idx)],'b-','linew',1.5)
ax(2) = subplot(122);
plot(Au(1,:),Au(2,:),'k.')
title('Au'), hold on
axis equal, axis square, grid on
plot([0 Au(1,idx)],[0 Au(2,idx)],'b-','linew',1.5)
xlabel(sprintf('|| A ||_{ inf} = %.3f',normA))
