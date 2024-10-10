function [X] = my_ADMM(T,A)
%MY_ADMM 此处显示有关此函数的摘要
%   此处显示详细说明
[n1,n2,n3] = size(T);
M = T.*A;
X = zeros(n1,n2,n3);
Z = zeros(n1,n2,n3);
B = zeros(n1,n2,n3);
I = ones(n1,n2,n3);
converged = false;
N = 0;
iteration = 0;
ErrorOld = 1;
Reapiteration = 0;
while ~converged
    iteration = iteration + 1;
    X = (I-A) .* (Z-B) + M;
    D = X + B;
    Z = shrink(D,1e3);
    B = B + X - Z;
    N = N + 1;
    fprintf('iteration %4d,rank of X is %4d, rel. residual is %.1e\n',N,tubalrank(X),norm(X(:)-T(:))/norm(T(:)));
    ErrorNew = norm(X(:)-T(:))/norm(T(:));
    if abs(ErrorNew - ErrorOld)/abs(ErrorOld) < 0.01
        Reapiteration = Reapiteration + 1;
    else
        Reapiteration = 0;
        ErrorOld = ErrorNew;
    end
    % 数据归一化后， 参数设置：最大迭代轮数 20， 最大重复迭代轮数 3，奇异值收缩参数 1.4 
    % 数据不归一化， 参数设置：最大迭代轮数  100  ， 最大重复迭代轮数   ， 奇异值收缩参数  10
    if iteration >= 20 || Reapiteration>= 10
        converged = true;
    end  
end
end

