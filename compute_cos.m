function coss = compute_cos(A)
% ����ܸ�ֵ����

% ��ȡ�����Ĵ�С
[~, ~, k] = size(A);

% ��ʼ������������
coss = zeros(1, k-1);

% ����������
for i = 1:k-1
    cos = CosVar(A(:,:,i),A(:,:,i+1));
    coss(i) = cos;
end

end

