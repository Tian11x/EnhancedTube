function [D] = ASVT(A, lambda)
[n1, n2] = size(A);
max12 = max(n1,n2);
[U, S, V] = svd(A,'econ');
S = diag(S);
S = max(S-lambda,0);
tol = max12*eps(max(S));
r = sum(S > tol);
S = S(1:r);
D = U(:,1:r)*diag(S)*V(:,1:r)';
end

