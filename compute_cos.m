function coss = compute_cos(A)
% 输入杠杆值张量

% 获取张量的大小
[~, ~, k] = size(A);

% 初始化相对误差向量
coss = zeros(1, k-1);

% 计算相对误差
for i = 1:k-1
    cos = CosVar(A(:,:,i),A(:,:,i+1));
    coss(i) = cos;
end

end

