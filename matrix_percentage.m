function [percentage] = matrix_percentage(M, r)
% ��������ǰr�к�ǰr�е�Ԫ�غ�ռ��Ԫ�غ͵İٷֱ�
% ���������
% M - ��ά����
% r - ��������ʾǰr�к�ǰr��
% ���������
% percentage - ǰr�к�ǰr�е�Ԫ�غ�ռ��Ԫ�غ͵İٷֱ�

% �������Ԫ������
[m, n] = size(M);
% total_elements = sum(M,'all');

% ����ǰr�к�ǰr�е�Ԫ�صļ�Ȩ��
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

% ����ǰr�к�ǰr�е�Ԫ�غ�ռ��Ԫ�غ͵İٷֱ�
percentage = 100 * (weighted_sum / all_weighted_sum);