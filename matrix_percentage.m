function [percentage] = matrix_percentage(M, r)
% 计算矩阵的前r行和前r列的元素和占总元素和的百分比
% 输入参数：
% M - 二维矩阵
% r - 参数，表示前r行和前r列
% 输出参数：
% percentage - 前r行和前r列的元素和占总元素和的百分比

% 计算矩阵元素总数
[m, n] = size(M);
% total_elements = sum(M,'all');

% 计算前r行和前r列的元素的加权和
weighted_sum = 0;
all_weighted_sum = 0;
for i = 1:m
   for j = 1:n
      all_weighted_sum = all_weighted_sum + M(i,j)^2;
      if (i<=r) || (j<=r)
         weighted_sum  =  weighted_sum + M(i,j)^2;
      end
   end
end

% sum_r_rows = sum(M(1:r,:), 'all');
% sum_r_cols = sum(M(:,1:r), 'all');
% sum_r = sum(M(1:r,1:r), 'all');

% 计算前r行和前r列的元素和占总元素和的百分比
percentage = 100 * (weighted_sum / all_weighted_sum);