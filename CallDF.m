function [X] = CallDF(Tensor,p)
% ����Ŀ�������Ͳ�����
% ����������
% Ȼ�����CallDF�ָ�ÿһ������
[n,~,k] = size(Tensor);
Number = floor(n*n*p);
% �׶�һ����������
IDX = zeros(n,n,k);
for t=1:k
    num = 0;
    while num<Number
       pos = randi(n*n);
       row=floor( (pos-1)/n) +1;%�ҵ���Ӧ����
       col=mod( (pos-1),n)+1; %�ҵ���Ӧ����
       if IDX(row, col, t) == 0
          IDX(row,col, t) = 1;
          num = num + 1;
       end
    end
end
X = zeros(n,n,k);
% �׶ζ����ָ�
for t=1:k
   X(:,:,t) = DisAndFea(IDX(:,:,t).*Tensor(:,:,t)); 
end
end

