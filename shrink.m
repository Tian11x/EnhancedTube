function X = shrink(Y,rho)

[n1,n2,n3] = size(Y);
max12 = max(n1,n2);
X = zeros(n1,n2,n3);
Y = fft(Y,[],3);

% first frontal slice
[U,S,V] = svd(Y(:,:,1),'econ');
S = diag(S);
S = max(S-rho,0);
tol = max12*eps(max(S));
r = sum(S > tol);
S = S(1:r);
X(:,:,1) = U(:,1:r)*diag(S)*V(:,1:r)';

% i=2,...,halfn3
halfn3 = round(n3/2);
for i = 2 : halfn3
    [U,S,V] = svd(Y(:,:,i),'econ');
    S = diag(S);
    S = max(S-rho,0);
    tol = max12*eps(max(S));
    r = sum(S > tol);
    S = S(1:r);
    X(:,:,i) = U(:,1:r)*diag(S)*V(:,1:r)';    
    X(:,:,n3+2-i) = conj(X(:,:,i));
end

% if n3 is even
if mod(n3,2) == 0
    i = halfn3+1;
    [U,S,V] = svd(Y(:,:,i),'econ');
    S = diag(S);
    S = max(S-rho,0);
    tol = max12*eps(max(S));
    r = sum(S > tol);
    S = S(1:r);
    X(:,:,i) = U(:,1:r)*diag(S)*V(:,1:r)';
end
X = ifft(X,[],3);
