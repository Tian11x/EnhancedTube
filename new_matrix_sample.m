function [IDX] = new_matrix_sample(n1,n2,sample_number)
%NEW_MATRIX_SAMPLE 此处显示有关此函数的摘要
%   此处显示详细说明
%=================随机采样 tube 函数==============
%输入：IDX测量位置张量； Number 采样个数； 
%输出：IDX 测量位置张量；
%===============================================
IDX = zeros(n1,n2);
sample = floor(sample_number/2);
N = floor(0.1*n1);
K = floor(sample/N);
while N>n1 || K>n2
   N = N + 1;
   K = floor(sample/N);
end
idx_row = randperm(n1,N);
for i =1:N
    row = idx_row(i);
    idx_col = randperm(n2, K);
    for j=1:K
        col = idx_col(j);
        IDX(row,col) = 1;
        IDX(col,row) = 1;
    end
end
end

