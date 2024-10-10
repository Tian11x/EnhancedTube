function [X] = DisAndFea(Matrix)
% ���벻��ȫ��������
% ������Vivaldi������ȫ�������Ͳ���ȫ��������
% Ȼ����䲻��ȫ��������
[n,~] = size(Matrix);
D = Vivaldi(Matrix); %����Vivaldi���ɾ������
F = zeros(n,n); 
for i=1:n
   for j=1:n
      if (i~=j) && Matrix(i,j)~=0
         F(i,j) = Matrix(i,j)/D(i,j); 
      end
   end
end
% �ָ�F �൱�ڶ��ֵ�SVT
maxIter = 5;
Fi = F;
for i=1:maxIter
   Fi = SVT(Fi,0.1); 
end
F = Fi;
% ����D��F֮�󣬻ָ�Ŀ�����
X = D.*F;
end

