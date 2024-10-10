function [IDX] = new_matrix_sample(n1,n2,sample_number)
%NEW_MATRIX_SAMPLE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%=================������� tube ����==============
%���룺IDX����λ�������� Number ���������� 
%�����IDX ����λ��������
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

